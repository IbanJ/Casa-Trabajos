/***************************************************
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_MostrarBaseDeDatos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_MostrarBaseDeDatos]
GO
CREATE PROCEDURE sp_MostrarBaseDeDatos
AS
   PRINT 'AdventureWorks'
GO

USE master
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_MostrarBaseDeDatos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_MostrarBaseDeDatos]
GO
CREATE PROCEDURE sp_MostrarBaseDeDatos
AS
   PRINT 'Master'
GO

--  SQL Server Ejecuta el almacenado en AdventureWorks
USE AdventureWorks
EXEC sp_MostrarBaseDeDatos
GO

-- SQL Server ejecuta el almacenado en la Master
USE Northwind
EXEC sp_MostrarBaseDeDatos
GO

