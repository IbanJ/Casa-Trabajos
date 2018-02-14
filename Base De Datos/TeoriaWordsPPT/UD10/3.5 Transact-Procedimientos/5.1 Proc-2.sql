/***************************************************Creación de un procedimiento almacenado con el prefijosp_ en la base de datos master y ejecución del mismo desde la base de datos pubsLos procedimientos almacenados de usuario se crean para implementar la lógica de negocio.Se crean con el mandato DDL CREATE PROCEDURE.Los nombres deben ser únicos dentro de cada base de datos y únicos para el usuarioque los crea (su propietario).Todo procedimiento almacenado creado en la master cuyo nombre comience por "sp_" es acccesibledesde cualquier base de datos.Si se llama a un procedimiento que comience por sp_, SQL Server lo busca en primer lugar en la base de datos actual y si no lo encuentra, lo busca en la master.****************************************************/USE AdventureWorks
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

