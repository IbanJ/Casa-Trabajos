/***************************************************
FUNCIONES ESCALARES
Se crean con CREATE FUNCTION.
Lista de funciones creadas:
	Max_CodPedido
	Quien
	EmpleadoJoven	
****************************************************/
USE AdventureWorks
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Max_CodPedido]'))
DROP FUNCTION [dbo].[Max_CodPedido]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Quien]')) 
DROP FUNCTION [dbo].[Quien]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmpleadoJoven]')) 
DROP FUNCTION [dbo].[EmpleadoJoven]
GO

-- Devuelve el último código de pedido
CREATE FUNCTION dbo.Max_CodPedido
()
RETURNS int
AS
BEGIN
	RETURN (
		SELECT MAX(SalesOrderID)
		FROM Sales.SalesOrderHeader
	)
END
GO


-- Devuelve el nombre del usuario y de la aplicación que ejecuta la consulta
CREATE FUNCTION dbo.Quien
()
RETURNS varchar(256)
AS
BEGIN
	RETURN SYSTEM_USER
		+ ' FROM '
		+ APP_NAME()
END
GO


-- Devuelve la edad del empleado más joven
CREATE FUNCTION dbo.EmpleadoJoven
()
RETURNS tinyint
AS
BEGIN
	DECLARE @edad tinyint
		
	SELECT @edad = ( select min(DATEDIFF(yy,BirthDate,getdate()))
					FROM HumanResources.Employee)
	
	RETURN @edad
END
GO


