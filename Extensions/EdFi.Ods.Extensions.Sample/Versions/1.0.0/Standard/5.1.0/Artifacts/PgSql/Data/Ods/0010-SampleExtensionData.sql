do $$
declare grandBendElementarySchoolId int;
declare staff207230Usi int;
declare staff207219Usi int;
declare contact777777Usi int;
declare contact778025Usi int;
declare student604854Usi int;
declare student605614Usi INT;
declare educationContentIdentifier varchar(225);
declare bilingualProgramEducationOrganizationId int;
declare bilingualProgramProgramName varchar(60);
declare bilingualProgramProgramTypeDescriptorId int;
declare graduationPlanEducationOrganizationId int;
declare graduationPlanGraduationTypeDescriptorId int;
declare graduationPlanGraduationSchoolYear smallint;
declare student604854SPABeginDate timestamp;
declare student604854SPAEducationOrganizationId int;
declare student604854SPAProgramEducationOrganizationId int;
declare student604854SPAProgramName varchar(60);
declare student604854SPAProgramTypeDescriptorId int;
declare student604854SSABeginDate date;
declare student604854SSALocalCourseCode varchar(60);
declare student604854SSASchoolId int;
declare student604854SSASchoolYear smallint;
declare student604854SSASectionIdentifier varchar(255);
declare student604854SSASessionName varchar(60);
declare student604854SSAStudentUSI int;
declare staff207219EmploymentEducationOrganizationId int;
declare staff207219EmploymentStatusDescriptorId int;
declare staff207219EmploymentHireDate date;
declare staff207219EmploymentStaffUSI int;
declare staff207230AssignmentBeginDate date;
declare staff207230AssignmentEducationOrganizationId int;
declare staff207230AssignmentStaffClassificationDescriptorId int;
declare staff207230AssignmentStaffUsi int;
declare academicSubjectDescriptorId int;
declare achievementCategoryDescriptorId int;
declare addrTypeDescriptorId int;
declare cteProgramServiceDescriptorId int;
declare credentialFieldDescriptorId int;
declare disciplineDescriptorId int;
declare disabilityDescriptorId int;
declare telephoneNumberTypeDescriptor int;
declare serviceDescriptorId int;
declare stateAbbreviationDescriptorId int;
declare artMediumDescriptorId int;
declare membershipTypeDescId int;
declare favoriteBookCategoryDescriptorId int;
declare studentArtProgramAssociationStudentUsi int;
declare studentArtProgramAssociationBeginDate timestamp;
declare studentArtProgramAssociationEducationOrganizationId int;
declare studentArtProgramAssociationProgramEducationOrganizationId int;
declare studentArtProgramAssociationProgramName varchar(60);
declare studentArtProgramAssocationProgramTypeDescriptorId int;

begin
select SchoolId into grandBendElementarySchoolId from edfi.School where SchoolId = 255901107;
select StaffUSI into staff207230Usi from edfi.Staff where StaffUniqueId = '207230';
select StaffUSI into staff207219Usi from edfi.Staff where StaffUniqueId = '207219';
select ContactUSI into contact777777Usi from edfi.Contact where ContactUniqueId = '777777';
select ContactUSI into contact778025Usi from edfi.Contact where ContactUniqueId = '778025';
select StudentUSI into student604854Usi from edfi.Student where StudentUniqueId = '604854';
select StudentUSI into student605614Usi from edfi.Student where StudentUniqueId = '605614';

-- Sanity check to make sure some data exists, otherwise skip the script
if grandBendElementarySchoolId is null or student604854Usi is null or student605614Usi is null then
    return;
end if;

-- Verify all required source data is available in the core namespace
select ContentIdentifier into educationContentIdentifier from edfi.EducationContent;

select EducationOrganizationId, ProgramName, ProgramTypeDescriptorId 
into bilingualProgramEducationOrganizationId, bilingualProgramProgramName, bilingualProgramProgramTypeDescriptorId
from edfi.Program 
where ProgramName = 'Bilingual';

select EducationOrganizationId, GraduationPlanTypeDescriptorId, GraduationSchoolYear  
into graduationPlanEducationOrganizationId, graduationPlanGraduationTypeDescriptorId, graduationPlanGraduationSchoolYear
from edfi.GraduationPlan
where EducationOrganizationId = grandBendElementarySchoolId;

select BeginDate, EducationOrganizationId, ProgramEducationOrganizationId, ProgramName, ProgramTypeDescriptorId 
into student604854SPABeginDate, student604854SPAEducationOrganizationId, student604854SPAProgramEducationOrganizationId, student604854SPAProgramName, student604854SPAProgramTypeDescriptorId
from edfi.StudentProgramAssociation
where StudentUSI = student604854Usi;

select BeginDate, LocalCourseCode, SchoolId, SchoolYear, SectionIdentifier, SessionName, StudentUSI 
into student604854SSABeginDate, student604854SSALocalCourseCode, student604854SSASchoolId, student604854SSASchoolYear, student604854SSASectionIdentifier, student604854SSASessionName, student604854SSAStudentUSI
from edfi.StudentSectionAssociation
where StudentUSI = student604854Usi;

select EducationOrganizationId, EmploymentStatusDescriptorId, HireDate, StaffUSI 
into staff207219EmploymentEducationOrganizationId, staff207219EmploymentStatusDescriptorId, staff207219EmploymentHireDate, staff207219EmploymentStaffUSI
from edfi.StaffEducationOrganizationEmploymentAssociation
where StaffUSI = staff207219Usi;

select BeginDate, EducationOrganizationId, StaffClassificationDescriptorId, StaffUSI 
into staff207230AssignmentBeginDate, staff207230AssignmentEducationOrganizationId, staff207230AssignmentStaffClassificationDescriptorId, staff207230AssignmentStaffUsi
from edfi.StaffEducationOrganizationAssignmentAssociation
where StaffUSI = staff207230Usi;

select DescriptorId into academicSubjectDescriptorId
from edfi.Descriptor d
inner join edfi.AcademicSubjectDescriptor asd
on d.DescriptorId = asd.AcademicSubjectDescriptorId;

select DescriptorId into achievementCategoryDescriptorId
from edfi.Descriptor d
inner join edfi.AchievementCategoryDescriptor acd
on d.DescriptorId = acd.AchievementCategoryDescriptorId;

select DescriptorId into addrTypeDescriptorId
from edfi.Descriptor d
inner join edfi.AddressTypeDescriptor atd
on d.DescriptorId = atd.AddressTypeDescriptorId;

select DescriptorId into cteProgramServiceDescriptorId
from edfi.Descriptor d
inner join edfi.CTEProgramServiceDescriptor cpsd
on d.DescriptorId = cpsd.CTEProgramServiceDescriptorId;

select DescriptorId into credentialFieldDescriptorId
from edfi.Descriptor d
inner join edfi.CredentialFieldDescriptor cfd
on d.DescriptorId = cfd.CredentialFieldDescriptorId;

select DescriptorId into disciplineDescriptorId
from edfi.Descriptor d
inner join edfi.DisciplineDescriptor dd
on d.DescriptorId = dd.DisciplineDescriptorId;

select DescriptorId into disabilityDescriptorId
from edfi.Descriptor d
inner join edfi.DisabilityDescriptor dd
on d.DescriptorId = dd.DisabilityDescriptorId;

select DescriptorId into telephoneNumberTypeDescriptor
from edfi.Descriptor d
inner join edfi.TelephoneNumberTypeDescriptor tntd
on d.DescriptorId = tntd.TelephoneNumberTypeDescriptorId;

select DescriptorId into serviceDescriptorId
from edfi.Descriptor d
inner join edfi.ServiceDescriptor sd
on d.DescriptorId = sd.ServiceDescriptorId;

SELECT DescriptorId into stateAbbreviationDescriptorId
FROM edfi.Descriptor d
INNER JOIN edfi.StateAbbreviationDescriptor sad
ON d.DescriptorId = sad.StateAbbreviationDescriptorId;

-- Create new descriptor values
insert into edfi.Descriptor (Namespace, CodeValue, ShortDescription, Description)
    values ('uri://ed-fi.org/ArtMediumDescriptor', 'Art Medium', 'Art Medium', 'Art Medium');
select DescriptorId into artMediumDescriptorId
    from edfi.Descriptor where Namespace = 'uri://ed-fi.org/ArtMediumDescriptor' and CodeValue = 'Art Medium';
insert into sample.ArtMediumDescriptor values (artMediumDescriptorId);


insert into edfi.Descriptor (Namespace, CodeValue, ShortDescription, Description)
    values ('uri://ed-fi.org/MembershipTypeDescriptor', 'Membership Type', 'Membership Type', 'Membership Type');
select DescriptorId into membershipTypeDescId
    from edfi.Descriptor where Namespace = 'uri://ed-fi.org/MembershipTypeDescriptor' and CodeValue = 'Membership Type';
insert into sample.MembershipTypeDescriptor values (membershipTypeDescId);

insert into edfi.Descriptor (Namespace, CodeValue, ShortDescription, Description)
    values ('uri://ed-fi.org/FavoriteBookCategoryDescriptor', 'Non-Fiction', 'Non-Fiction', 'Non-Fiction');
select DescriptorId into favoriteBookCategoryDescriptorId
    from edfi.Descriptor where Namespace = 'uri://ed-fi.org/FavoriteBookCategoryDescriptor' and CodeValue = 'Non-Fiction';
insert into sample.FavoriteBookCategoryDescriptor values (favoriteBookCategoryDescriptorId);

-- Create extension records to prevent dropped records due to extension requirements

INSERT INTO sample.StaffExtension
    (StaffUSI
    , FirstPetOwnedDate)
SELECT
    StaffUSI
    , NULL
FROM edfi.Staff
WHERE NOT EXISTS
    (SELECT StaffUSI
    FROM sample.StaffExtension se
    WHERE StaffUSI = se.StaffUsi);

INSERT INTO sample.ContactExtension
    (ContactUSI
    , IsSportsFan
    , CoffeeSpend
    , GraduationDate
    , AverageCarLineWait
    , LuckyNumber
    , RainCertainty
    , PreferredWakeUpTime
    , BecameParent
    , GPA
    , Duration)
SELECT
    ContactUSI
    , '0'
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
FROM edfi.Contact
WHERE NOT EXISTS
    (SELECT ContactUSI
    FROM sample.ContactExtension pe
    WHERE ContactUSI = pe.ContactUSI);

INSERT INTO sample.ContactFavoriteBookTitle
    (ContactUSI
    , FavoriteBookTitle)
SELECT
    ContactUSI
    , 'Green Eggs and Ham'
FROM edfi.Contact;

INSERT INTO sample.ContactAddressExtension
    (AddressTypeDescriptorId
    , City
    , ContactUSI
    , PostalCode
    , StateAbbreviationDescriptorId
    , StreetNumberName
    , OnBusRoute)
SELECT
    AddressTypeDescriptorId
    , City
    , ContactUSI
    , PostalCode
    , pa.StateAbbreviationDescriptorId
    , StreetNumberName
    , '0'
FROM edfi.ContactAddress pa
WHERE NOT EXISTS
    (SELECT ContactUSI
    FROM sample.ContactAddressExtension pae
    WHERE AddressTypeDescriptorId = pae.AddressTypeDescriptorId
    AND City = pae.City
    AND ContactUSI = pae.ContactUSI
    AND PostalCode = pae.PostalCode
    AND pa.StateAbbreviationDescriptorId = pae.StateAbbreviationDescriptorId);
    
INSERT INTO sample.ContactAddressSchoolDistrict
    (AddressTypeDescriptorId
    , City
    , ContactUSI
    , PostalCode
    , SchoolDistrict
    , StateAbbreviationDescriptorId
    , StreetNumberName)
SELECT
    AddressTypeDescriptorId
    , City
    , ContactUSI
    , PostalCode
    , 'Original School District'
    , pae.StateAbbreviationDescriptorId
    , StreetNumberName
FROM sample.ContactAddressExtension pae;

INSERT INTO sample.ContactTeacherConference
    (ContactUSI
    , DayOfWeek
    , StartTime
    , EndTime)
SELECT
    ContactUSI
    ,'Monday'
    , '12:00:00'
    , '12:00:00'
FROM sample.ContactExtension;

INSERT INTO sample.StudentContactAssociationExtension
    (ContactUSI
    , StudentUSI
    , BedtimeReader
    , PriorContactRestrictions
    , BookBudget
    , ReadGreenEggsAndHamDate
    , ReadingTimeSpent
    , BooksBorrowed
    , BedtimeReadingRate
    , LibraryTime
    , LibraryVisits
    , StudentRead
    , LibraryDuration
    , EducationOrganizationId
    , InterventionStudyIdentificationCode)
SELECT
    ContactUSI
    , StudentUSI
    , '0'
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
FROM edfi.StudentContactAssociation
WHERE NOT EXISTS
    (SELECT
        ContactUSI
        , StudentUSI
    FROM sample.StudentContactAssociationExtension spa
    WHERE ContactUSI = spa.ContactUSI
    AND StudentUSI = spa.StudentUSI);

INSERT INTO sample.StudentContactAssociationFavoriteBookTitle
    (ContactUSI
    , StudentUSI
    , FavoriteBookTitle)
SELECT
    ContactUSI
    , StudentUSI
    , 'Green Eggs and Ham'
FROM edfi.StudentContactAssociation;

INSERT INTO sample.StudentSchoolAssociationExtension
    (EntryDate
    , SchoolId
    , StudentUSI
    , MembershipTypeDescriptorId)
SELECT
    EntryDate
    , SchoolId
    , StudentUSI
    , NULL
FROM edfi.StudentSchoolAssociation
WHERE NOT EXISTS
    (SELECT
        EntryDate
        , SchoolId
        , StudentUSI
    FROM sample.StudentSchoolAssociationExtension ssae
    WHERE EntryDate = ssae.EntryDate
    AND SchoolId = ssae.SchoolId
    AND StudentUSI = ssae.StudentUSI);

INSERT INTO sample.StudentEducationOrganizationAssociationAddressExtension
    (AddressTypeDescriptorId
    , City
    , EducationOrganizationId
    , PostalCode
    , StateAbbreviationDescriptorId
    , StreetNumberName
    , StudentUSI
    , Complex
    , OnBusRoute)
SELECT
    AddressTypeDescriptorId
    , City
    , EducationOrganizationId
    , PostalCode
    , seoaa.StateAbbreviationDescriptorId
    , StreetNumberName
    , StudentUSI
    , NULL
    , '0'
FROM edfi.StudentEducationOrganizationAssociationAddress seoaa
WHERE NOT EXISTS
    (SELECT EntryDate, SchoolId, StudentUSI
    FROM sample.StudentSchoolAssociationExtension ssae
    WHERE EntryDate = ssae.EntryDate
    AND SchoolId = ssae.SchoolId
    AND StudentUSI = ssae.StudentUSI);

INSERT INTO sample.StudentEducationOrganizationAssociationAddressSchoolDistrict
    (AddressTypeDescriptorId
    , City
    , EducationOrganizationId
    , PostalCode
    , StateAbbreviationDescriptorId
    , StreetNumberName
    , StudentUSI
    , SchoolDistrict)
SELECT
    AddressTypeDescriptorId
    , City
    , EducationOrganizationId
    , PostalCode
    , seoaae.StateAbbreviationDescriptorId
    , StreetNumberName
    , StudentUSI
    , 'Test District'
FROM sample.StudentEducationOrganizationAssociationAddressExtension seoaae;

-- Create sample data for new Bus domain entity
INSERT INTO sample.Bus
    (BusId)
VALUES
    ('602');
    
INSERT INTO sample.StudentCTEProgramAssociationExtension
    (BeginDate
    , EducationOrganizationId
    , ProgramEducationOrganizationId
    , ProgramName
    , ProgramTypeDescriptorId
    , StudentUSI
    , AnalysisCompleted
    , AnalysisDate)
SELECT
    BeginDate
    , EducationOrganizationId
    , ProgramEducationOrganizationId
    , ProgramName
    , ProgramTypeDescriptorId
    , StudentUSI
    , NULL
    , NULL
FROM edfi.StudentCTEProgramAssociation
WHERE NOT EXISTS
    (SELECT
        BeginDate
        , EducationOrganizationId
        , ProgramEducationOrganizationId
        , ProgramName
        , ProgramTypeDescriptorId
        , StudentUSI
    FROM sample.StudentCTEProgramAssociationExtension scteopae
    WHERE BeginDate = scteopae.BeginDate
    AND EducationOrganizationId = scteopae.EducationOrganizationId
    AND ProgramEducationOrganizationId = scteopae.ProgramEducationOrganizationId
    AND ProgramName = scteopae.ProgramName
    AND ProgramTypeDescriptorId = scteopae.ProgramTypeDescriptorId
    AND StudentUSI = scteopae.StudentUSI);
    
-- Create sample data for new BusRoute domain entity

INSERT INTO sample.BusRoute
    (BusId
    , BusRouteNumber
    , BusRouteDirection
    , Daily
    , OperatingCost
    , StartDate
    , WeeklyMileage
    , ExpectedTransitTime
    , OptimalCapacity
    , HoursPerWeek
    , BusRouteDuration
    , DisabilityDescriptorId
    , StaffUSI
    , EducationOrganizationId
    , StaffClassificationDescriptorId
    , BeginDate)
VALUES
    ('602', 102, 'Northbound', '1', '5', '2010-05-29', 375.33, '57', 9.75, 60.5, 3630, disabilityDescriptorId, staff207230AssignmentStaffUsi, staff207230AssignmentEducationOrganizationId, staff207230AssignmentStaffClassificationDescriptorId, staff207230AssignmentBeginDate);

INSERT INTO sample.BusRouteBusYear
    (BusId
    , BusRouteNumber
    , BusYear)
VALUES
    ('602', 102, 2018)
    , ('602', 102, 2017)
    , ('602', 102, 2016)
    , ('602', 102, 2015)
    , ('602', 102, 2014)
    , ('602', 102, 2013)
    , ('602', 102, 2012)
    , ('602', 102, 2011)
    , ('602', 102, 2010);

INSERT INTO sample.BusRouteProgram
    (BusId
    , BusRouteNumber
    , EducationOrganizationId
    , ProgramName
    , ProgramTypeDescriptorId)
VALUES ('602', 102, bilingualProgramEducationOrganizationId, bilingualProgramProgramName, bilingualProgramProgramTypeDescriptorId);

INSERT INTO sample.BusRouteServiceAreaPostalCode
    (BusId
    , BusRouteNumber
    , ServiceAreaPostalCode)
VALUES ('602', 102, '78705');

INSERT INTO sample.BusRouteStartTime
    (BusId
    , BusRouteNumber
    , StartTime)
VALUES ('602', 102, '13:01:01');

INSERT INTO sample.BusRouteTelephone
    (BusId
    , BusRouteNumber
    , TelephoneNumberTypeDescriptorId
    , TelephoneNumber
    , OrderOfPriority
    , TextMessageCapabilityIndicator
    , DoNotPublishIndicator)
VALUES ('602', 102, @telephoneNumberTypeDescriptor, '555-123-4567', 1, '1', '0');

-- Add extension data for a particular school
UPDATE sample.SchoolExtension
SET IsExemplary = '1'
WHERE SchoolId = grandBendElementarySchoolId;

INSERT INTO sample.SchoolCTEProgramService
    (SchoolId
    , CTEProgramServiceDescriptorId
    , CIPCode
    , PrimaryIndicator
    , ServiceBeginDate
    , ServiceEndDate)
VALUES (grandBendElementarySchoolId, cteProgramServiceDescriptorId, '13.0301', '0', '2018-08-20', '2018-09-20');

INSERT INTO sample.SchoolDirectlyOwnedBus
    (SchoolId
    , DirectlyOwnedBusId)
VALUES (@grandBendElementarySchoolId, '602');

--- Add extension data for a particular Contact
UPDATE sample.ContactExtension
SET IsSportsFan = '1'
    , CoffeeSpend = 15.50
    , GraduationDate = '1976-04-30'
    , AverageCarLineWait = '20'
    , LuckyNumber = 13
    , RainCertainty = 5.75
    , PreferredWakeUpTime = '07:00:00'
    , BecameParent = 1983
    , GPA = 3.5
    , Duration = 25
WHERE ContactUSI = contact777777Usi;

UPDATE sample.ContactTeacherConference
SET DayOfWeek = 'Thursday',
    EndTime = '13:00:00'
WHERE ContactUSI = contact777777Usi;

INSERT INTO edfi.ContactAddress
    (AddressTypeDescriptorId
    , ContactUSI
    , StreetNumberName
    , City
    , StateAbbreviationDescriptorId
    , PostalCode)
VALUES (addrTypeDescriptorId, contact777777Usi, '123 ABC Street', 'Springfield', stateAbbreviationDescriptorId, '1111111');

INSERT INTO sample.ContactAuthor
    (Author
    , ContactUSI)
VALUES ('SampleAuthor', contact777777Usi);

INSERT INTO sample.ContactCeilingHeight
    (CeilingHeight
    , ContactUSI)
VALUES (10.2, contact777777Usi);

INSERT INTO sample.ContactCTEProgramService
    (ContactUSI
    , CTEProgramServiceDescriptorId
    , CIPCode
    , PrimaryIndicator
    , ServiceBeginDate
    , ServiceEndDate)
VALUES (contact777777Usi, cteProgramServiceDescriptorId, '13.0301', '0', '2018-08-20', '2018-09-20');

INSERT INTO sample.ContactEducationContent
    (ContentIdentifier
    , ContactUSI)
VALUES (educationContentIdentifier, contact777777Usi);

INSERT INTO sample.ContactStudentProgramAssociation
    (BeginDate
    , EducationOrganizationId
    , ContactUSI
    , ProgramEducationOrganizationId
    , ProgramName
    , ProgramTypeDescriptorId
    , StudentUSI)
VALUES (student604854SPABeginDate, student604854SPAEducationOrganizationId, contact777777Usi, student604854SPAProgramEducationOrganizationId, student604854SPAProgramName, student604854SPAProgramTypeDescriptorId, student604854Usi);

--- Add extension data for a particular Staff member
UPDATE sample.StaffExtension
SET FirstPetOwnedDate = '2013-04-15'
WHERE StaffUSI = staff207219Usi;

INSERT INTO sample.StaffPet
    (PetName
    , StaffUSI
    , IsFixed)
VALUES ('Sparky', staff207219Usi, '1');

INSERT INTO sample.StaffPetPreference
    (StaffUSI
    , MinimumWeight
    , MaximumWeight)
VALUES (staff207219Usi, 1, 50);

--- Add extension data for a particular Student
INSERT INTO sample.StudentPet
    (PetName
    , StudentUSI
    , IsFixed)
VALUES ('Bingo', student604854Usi, '0');

INSERT INTO sample.StudentPetPreference
    (StudentUSI
    , MinimumWeight
    , MaximumWeight)
VALUES (student604854Usi, 1, 35);

INSERT INTO sample.StudentAquaticPet
    (PetName
    , StudentUSI
    , IsFixed
    , MimimumTankVolume)
VALUES ('Nemo', student604854Usi, NULL, 20);

INSERT INTO sample.StudentAquaticPet
    (PetName
    , StudentUSI
    , IsFixed
    , MimimumTankVolume)
VALUES ('Dory', student604854Usi, NULL, 100);

--- Create sample data for new StudentArtProgram subclass
studentArtProgramAssociationStudentUsi := student605614Usi;
studentArtProgramAssociationBeginDate := '2018-08-20';
studentArtProgramAssociationEducationOrganizationId := grandBendElementarySchoolId;
studentArtProgramAssociationProgramEducationOrganizationId := bilingualProgramEducationOrganizationId;
studentArtProgramAssociationProgramName := bilingualProgramProgramName;
studentArtProgramAssocationProgramTypeDescriptorId := bilingualProgramProgramTypeDescriptorId;

INSERT INTO edfi.GeneralStudentProgramAssociation
    (BeginDate
    , EducationOrganizationId
    , ProgramEducationOrganizationId
    , ProgramName
    , ProgramTypeDescriptorId
    , StudentUSI
    , Discriminator)
VALUES (studentArtProgramAssociationBeginDate, studentArtProgramAssociationEducationOrganizationId, studentArtProgramAssociationProgramEducationOrganizationId, studentArtProgramAssociationProgramName, studentArtProgramAssocationProgramTypeDescriptorId, studentArtProgramAssociationStudentUsi, 'sample.StudentArtProgramAssociation');

INSERT INTO sample.StudentArtProgramAssociation
    (BeginDate
    , EducationOrganizationId
    , ProgramEducationOrganizationId
    , ProgramName
    , ProgramTypeDescriptorId
    , StudentUSI
    , IdentificationCode
    , ExhibitDate
    , ProgramFees
    , NumberOfDaysInAttendance
    , HoursPerDay
    , PrivateArtProgram
    , KilnReservation
    , KilnReservationLength
    , ArtPieces
    , PortfolioPieces
    , MasteredMediums)
VALUES (studentArtProgramAssociationBeginDate, studentArtProgramAssociationEducationOrganizationId, studentArtProgramAssociationProgramEducationOrganizationId, studentArtProgramAssociationProgramName, studentArtProgramAssocationProgramTypeDescriptorId, studentArtProgramAssociationStudentUsi, '1234', '2018-12-16', 40.00, 30, 1, '0', '12:15:00', '60', 15, 32, 2.5);

INSERT INTO sample.StudentArtProgramAssociationArtMedium
    (BeginDate
    , EducationOrganizationId
    , ProgramEducationOrganizationId
    , ProgramName
    , ProgramTypeDescriptorId
    , StudentUSI
    , ArtMediumDescriptorId)
VALUES (studentArtProgramAssociationBeginDate, studentArtProgramAssociationEducationOrganizationId, studentArtProgramAssociationProgramEducationOrganizationId, studentArtProgramAssociationProgramName, studentArtProgramAssocationProgramTypeDescriptorId, studentArtProgramAssociationStudentUsi, artMediumDescriptorId);

INSERT INTO sample.StudentArtProgramAssociationPortfolioYears
    (BeginDate
    , EducationOrganizationId
    , ProgramEducationOrganizationId
    , ProgramName
    , ProgramTypeDescriptorId
    , StudentUSI
    , PortfolioYears)
VALUES (studentArtProgramAssociationBeginDate, studentArtProgramAssociationEducationOrganizationId, studentArtProgramAssociationProgramEducationOrganizationId, studentArtProgramAssociationProgramName, studentArtProgramAssocationProgramTypeDescriptorId, studentArtProgramAssociationStudentUsi, 2017)
    , (studentArtProgramAssociationBeginDate, studentArtProgramAssociationEducationOrganizationId, studentArtProgramAssociationProgramEducationOrganizationId, studentArtProgramAssociationProgramName, studentArtProgramAssocationProgramTypeDescriptorId, studentArtProgramAssociationStudentUsi, 2018);


INSERT INTO sample.StudentArtProgramAssociationService
    (BeginDate
    , EducationOrganizationId
    , ProgramEducationOrganizationId
    , ProgramName
    , ProgramTypeDescriptorId
    , StudentUSI
    , ServiceDescriptorId
    , PrimaryIndicator
    , ServiceBeginDate)
VALUES (studentArtProgramAssociationBeginDate, studentArtProgramAssociationEducationOrganizationId, studentArtProgramAssociationProgramEducationOrganizationId, studentArtProgramAssociationProgramName, studentArtProgramAssocationProgramTypeDescriptorId, studentArtProgramAssociationStudentUsi, serviceDescriptorId, '1', '2018-09-03');

INSERT INTO sample.StudentArtProgramAssociationStyle
    (BeginDate
    , EducationOrganizationId
    , ProgramEducationOrganizationId
    , ProgramName
    , ProgramTypeDescriptorId
    , StudentUSI
    , Style)
VALUES (studentArtProgramAssociationBeginDate, studentArtProgramAssociationEducationOrganizationId, studentArtProgramAssociationProgramEducationOrganizationId, studentArtProgramAssociationProgramName, studentArtProgramAssocationProgramTypeDescriptorId, studentArtProgramAssociationStudentUsi, 'Post Modern');

--- Create sample data for new StudentGraduationPlanAssociation
INSERT INTO sample.StudentGraduationPlanAssociation
    (EducationOrganizationId
    , GraduationPlanTypeDescriptorId
    , GraduationSchoolYear
    , StudentUSI
    , EffectiveDate
    , IsActivePlan
    , GraduationFee
    , TargetGPA
    , HighSchoolDuration
    , RequiredAttendance
    , CommencementTime
    , HoursPerWeek
    , StaffUSI)
VALUES (graduationPlanEducationOrganizationId, graduationPlanGraduationTypeDescriptorId, graduationPlanGraduationSchoolYear, student604854Usi, '2018-08-05', '1', 50.00, 3.75, '2', 0.95, '14:00:00', 30, staff207219Usi);

INSERT INTO sample.StudentGraduationPlanAssociationAcademicSubject
    (EducationOrganizationId
    , GraduationPlanTypeDescriptorId
    , GraduationSchoolYear
    , StudentUSI
    , AcademicSubjectDescriptorId)
VALUES (graduationPlanEducationOrganizationId, graduationPlanGraduationTypeDescriptorId, graduationPlanGraduationSchoolYear, student604854Usi, academicSubjectDescriptorId);

INSERT INTO sample.StudentGraduationPlanAssociationStudentContactAssociation
    (EducationOrganizationId
    , GraduationPlanTypeDescriptorId
    , GraduationSchoolYear
    , StudentUSI
    , ContactUSI)
VALUES (graduationPlanEducationOrganizationId, graduationPlanGraduationTypeDescriptorId, graduationPlanGraduationSchoolYear, student604854Usi, contact778025Usi);

INSERT INTO sample.StudentGraduationPlanAssociationCareerPathwayCode
    (EducationOrganizationId
    , GraduationPlanTypeDescriptorId
    , GraduationSchoolYear
    , StudentUSI
    , CareerPathwayCode)
VALUES (graduationPlanEducationOrganizationId, graduationPlanGraduationTypeDescriptorId, graduationPlanGraduationSchoolYear, student604854Usi, 15);

INSERT INTO sample.StudentGraduationPlanAssociationCTEProgramService
    (EducationOrganizationId
    , GraduationPlanTypeDescriptorId
    , GraduationSchoolYear
    , StudentUSI
    , CTEProgramServiceDescriptorId
    , CIPCode
    , PrimaryIndicator
    , ServiceBeginDate
    , ServiceEndDate)
VALUES (graduationPlanEducationOrganizationId, graduationPlanGraduationTypeDescriptorId, graduationPlanGraduationSchoolYear, student604854Usi, cteProgramServiceDescriptorId, '13.0301', '1', '2018-08-20', '2018-09-20');

INSERT INTO sample.StudentGraduationPlanAssociationDescription
    (EducationOrganizationId
    , GraduationPlanTypeDescriptorId
    , GraduationSchoolYear
    , StudentUSI
    , Description)
VALUES (graduationPlanEducationOrganizationId, graduationPlanGraduationTypeDescriptorId, graduationPlanGraduationSchoolYear, student604854Usi, 'Recommended graduation plan with additional requirement of 3.75 GPA');

INSERT INTO sample.StudentGraduationPlanAssociationDesignatedBy
    (EducationOrganizationId
    , GraduationPlanTypeDescriptorId
    , GraduationSchoolYear
    , StudentUSI
    , DesignatedBy)
VALUES (graduationPlanEducationOrganizationId, graduationPlanGraduationTypeDescriptorId, graduationPlanGraduationSchoolYear, student604854Usi, 'State of Texas');

INSERT INTO sample.StudentGraduationPlanAssociationIndustryCredential
    (EducationOrganizationId
    , GraduationPlanTypeDescriptorId
    , GraduationSchoolYear
    , StudentUSI
    , IndustryCredential)
VALUES (graduationPlanEducationOrganizationId, graduationPlanGraduationTypeDescriptorId, graduationPlanGraduationSchoolYear, student604854Usi, 'CTE Certificate');

INSERT INTO sample.StudentGraduationPlanAssociationYearsAttended
    (EducationOrganizationId
    , GraduationPlanTypeDescriptorId
    , GraduationSchoolYear
    , StudentUSI
    , YearsAttended)
VALUES (graduationPlanEducationOrganizationId, graduationPlanGraduationTypeDescriptorId, graduationPlanGraduationSchoolYear, student604854Usi, 2017);

--- Add extension data for a particular StudentContactAssociation
UPDATE sample.StudentContactAssociationExtension
SET PriorContactRestrictions = 'No Pickup'
    , BedtimeReader = '1'
    , BookBudget = 25.00
    , ReadGreenEggsAndHamDate = '2015-11-02'
    , ReadingTimeSpent = '30'
    , BooksBorrowed = 5
    , BedtimeReadingRate = 8.5
    , LibraryTime = '10:30:00'
    , LibraryVisits = 2
    , StudentRead = 2018
    , LibraryDuration = 45
    , EducationOrganizationId = 255901
WHERE ContactUSI = contact777777Usi AND StudentUSI = student605614Usi;

INSERT INTO sample.StudentContactAssociationDiscipline
    (ContactUSI
    , StudentUSI
    , DisciplineDescriptorId)
VALUES (contact777777Usi, student605614Usi, disciplineDescriptorId);

INSERT INTO sample.StudentContactAssociationHoursPerWeek
    (ContactUSI
    , StudentUSI
    , HoursPerWeek)
VALUES (contact777777Usi, student605614Usi, 14.5);

INSERT INTO sample.StudentContactAssociationPagesRead
    (ContactUSI
    , StudentUSI
    , PagesRead)
VALUES (contact777777Usi, student605614Usi, 567.8);

INSERT INTO sample.studentcontactassociationstaffeducationorganizationemplo_a92b1d
    (ContactUSI
    , StudentUSI
    , EducationOrganizationId
    , EmploymentStatusDescriptorId
    , HireDate
    , StaffUSI)
VALUES (contact777777Usi, student605614Usi, staff207219EmploymentEducationOrganizationId, staff207219EmploymentStatusDescriptorId, staff207219EmploymentHireDate, staff207219EmploymentStaffUSI);

INSERT INTO sample.StudentContactAssociationTelephone
    (ContactUSI
    , StudentUSI
    , TelephoneNumber
    , TelephoneNumberTypeDescriptorId
    , OrderOfPriority
    , TextMessageCapabilityIndicator
    , DoNotPublishIndicator)
VALUES (contact777777Usi, student605614Usi, '123-555-4567', telephoneNumberTypeDescriptor, 1, '1', '0');

--- Add extension data to a particular StudentSchoolAssociation
UPDATE sample.StudentSchoolAssociationExtension
SET MembershipTypeDescriptorId = membershipTypeDescId
WHERE StudentUSI = student604854Usi AND SchoolId = grandBendElementarySchoolId;

INSERT INTO sample.StudentFavoriteBook
           (FavoriteBookCategoryDescriptorId
           , StudentUSI
           , BookTitle)
     VALUES
           (favoriteBookCategoryDescriptorId
           ,student604854Usi
           ,'The Mindset');
           
INSERT INTO sample.StudentFavoriteBookArtMedium
           (ArtMediumDescriptorId
           , FavoriteBookCategoryDescriptorId
           , StudentUSI
           , ArtPieces)
     VALUES
           (artMediumDescriptorId
           ,favoriteBookCategoryDescriptorId
           ,student604854Usi
           ,1);

--- Add extension data to a particular StudentSectionAssociation
-- INSERT INTO sample.StudentSectionAssociationRelatedGeneralStudentProgramAss_c72e02
           -- (BeginDate
           -- , LocalCourseCode
           -- , RelatedBeginDate
           -- , RelatedEducationOrganizationId
           -- , RelatedProgramEducationOrganizationId
           -- , RelatedProgramName
           -- , RelatedProgramTypeDescriptorId
           -- , SchoolId
           -- , SchoolYear
           -- , SectionIdentifier
           -- , SessionName
           -- , StudentUSI)
     -- VALUES
           -- (student604854SSABeginDate
           -- , student604854SSALocalCourseCode
           -- , student604854SPABeginDate
           -- , student604854SPAEducationOrganizationId
           -- , student604854SPAProgramEducationOrganizationId
           -- , student604854SPAProgramName
           -- , student604854SPAProgramTypeDescriptorId
           -- , student604854SSASchoolId
           -- , student604854SSASchoolYear
           -- , student604854SSASectionIdentifier
           -- , student604854SSASessionName
           -- , student604854SSAStudentUSI);

end $$;