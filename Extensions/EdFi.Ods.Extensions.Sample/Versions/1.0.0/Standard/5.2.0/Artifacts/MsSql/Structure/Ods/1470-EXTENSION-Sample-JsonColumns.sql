-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

ALTER TABLE sample.Bus ADD Json varbinary(8000);
ALTER TABLE sample.BusRoute ADD Json varbinary(8000);
ALTER TABLE sample.StudentGraduationPlanAssociation ADD Json varbinary(8000);
