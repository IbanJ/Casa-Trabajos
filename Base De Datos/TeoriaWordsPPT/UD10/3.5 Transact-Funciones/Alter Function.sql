/***************************************************USO DE ALTER FUNCTION para encriptar****************************************************/USE AdventureWorks
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Max_CodPedido]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Max_CodPedido]
GO

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

-- Modificamos la función "Max_CodPedido" encriptándola
ALTER FUNCTION dbo.Max_CodPedido
()
WITH ENCRYPTION
RETURNS int
AS
BEGIN
	RETURN (
		SELECT MAX(SalesOrderID)
		FROM Sales.SalesOrderHeader
	)
END
GO