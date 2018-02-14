/***************************************************MODIFICACIÓN DE LOS OBJETOS RELACIONADOS CON UNA FUNCIÓNY LA OPCIÓN SCHEMABINDINGLista de funciones creadas:	CogerClientes sin SCHEMABINDING	CogerClientes con SCHEMABINDING****************************************************/

USE Northwind
GO

IF OBJECT_ID('CogerClientes') IS NOT NULL
	DROP FUNCTION CogerClienteds
GO

IF OBJECT_ID('NuevosClientes') IS NOT NULL
	DROP TABLE NuevosClientes
GO

SELECT *
INTO NuevosClientes
FROM Customers
GO

CREATE  FUNCTION dbo.CogerClientes()
RETURNS @List TABLE
	(CustomerID nchar(5)
	, CompanyName nvarchar(40))
AS
BEGIN
	INSERT @List
		SELECT CustomerID, CompanyName
		FROM NuevosClientes
	
	RETURN
END
GO

ALTER TABLE NuevosClientes
   DROP COLUMN CompanyName

PRINT CHAR(10)
	+ 'ALTER TABLE: mandato satisfactorio sin SCHEMABINDING'
	+ CHAR(10)
GO

SELECT *
FROM CogerClientes()
GO

PRINT CHAR(10)
	+ 'La ejecución de la función CogerClientes no ha sido satisfactoria'
	+ CHAR(10)
	+ 'ya que hace referencia a una columna que no existe'
	+ CHAR(10)
GO

IF OBJECT_ID('CogerClientes') IS NOT NULL
	DROP FUNCTION CogerClientes
GO

IF OBJECT_ID('NuevosClientes') IS NOT NULL
	DROP TABLE NuevosClientes
GO

SELECT *
INTO NuevosClientes
FROM Customers
GO

CREATE  FUNCTION dbo.CogerClientes()
RETURNS @Lista TABLE
	(CustomerID nchar(5)
	, CompanyName nvarchar(40))
WITH SCHEMABINDING
AS
BEGIN
	INSERT @Lista
		SELECT CustomerID, CompanyName
		FROM NuevosClientes
	
	RETURN
END
GO

PRINT CHAR(10)
	+ 'CREATE FUNCTION: ha fallado con la opción SCHEMABINDING'
	+ CHAR(10)
	+ 'ya que no usamos los nombres de dos partes'
	+ CHAR(10)
GO

CREATE  FUNCTION dbo.CogerClientes()
RETURNS @Lista TABLE
	(CustomerID nchar(5)
	, CompanyName nvarchar(40))
WITH SCHEMABINDING
AS
BEGIN
	INSERT @Lista
		SELECT CustomerID, CompanyName
		FROM dbo.NuevosClientes
	
	RETURN
END
GO

PRINT CHAR(10)
	+ 'CREATE FUNCTION: ha tenido éxito con laopción SCHEMABINDING'
	+ CHAR(10)
	+ 'ya que se ha usado un nombre con las dos partes'
	+ CHAR(10)
GO

ALTER TABLE NuevosClientes
   DROP COLUMN CompanyName
GO

PRINT CHAR(10)
	+ 'ALTER TABLE: mandato fallido con la opción SCHEMABINDING'
	+ CHAR(10)
GO
