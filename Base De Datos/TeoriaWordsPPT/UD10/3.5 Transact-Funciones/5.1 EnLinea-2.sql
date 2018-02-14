/***************************************************Para estas funciones en línea existen las mismas RESTRICCIONESque para las vistas.Una de estas restricciones es que no se puede usar ORDER BY.Lista de funciones creadas:	ProductosOrdenados****************************************************/USE Northwind
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductosOrdenados]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ProductosOrdenados]
GO
-- Recupera los productos ordenados por el nombre
CREATE FUNCTION dbo.ProductosOrdenados()
RETURNS TABLE
AS
	RETURN (
		SELECT TOP 100 PERCENT *
		FROM Products
		ORDER BY ProductName ASC
		)
GO

-- Prueba de la función
SELECT TOP 10 ProductID, ProductName
FROM dbo.ProductosOrdenados()
