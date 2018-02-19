-- Guión para eliminar las tablas del esquema HR
USE [ASIR_IgnacioGonzalo]
GO

-- Eliminación de FK's de Departments
ALTER TABLE [HR].[Departments] DROP CONSTRAINT [FK_Departments_Employees]
GO
ALTER TABLE [HR].[Departments] DROP CONSTRAINT [FK_Departments_Locations]
GO
-- Eliminación de FK's de Employees
ALTER TABLE [HR].[Employees] DROP CONSTRAINT [FK_Employees_Departments]
GO
ALTER TABLE [HR].[Employees] DROP CONSTRAINT [FK_Employees_Employees]
GO
ALTER TABLE [HR].[Employees] DROP CONSTRAINT [FK_Employees_Jobs]
GO
ALTER TABLE [HR].[Employees] DROP CONSTRAINT [FK_Employees_Locations]
GO
-- Eliminación de FK's de job_history
ALTER TABLE [HR].[Job_History] DROP CONSTRAINT [FK_Job_History_Departments]
GO
ALTER TABLE [HR].[Job_History] DROP CONSTRAINT [FK_Job_History_Employees]
GO
ALTER TABLE [HR].[Job_History] DROP CONSTRAINT [FK_Job_History_Jobs]
GO
-- Eliminación de FK's de Regions
ALTER TABLE [HR].[Regions] DROP CONSTRAINT [FK_Regions_Countries]
GO

-- Eliminación de las tablas
drop table hr.Job_History;
drop table hr.Regions;
drop table hr.Countries;
drop table hr.Departments;
drop table hr.Employees;
drop table hr.Jobs;
drop table hr.Locations;