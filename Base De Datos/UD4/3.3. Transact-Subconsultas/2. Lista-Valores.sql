/***************************************************LISTAS DE VALORESTRES EJEMPLOS****************************************************/
USE Northwind
GO

SET NOCOUNT ON
GO

--1. Selecci�n de una columna de una tabla
SELECT CategoryName
FROM Northwind.dbo.Categories

-- Selecci�n de valores agregados de una sola columna de una tabla con GROUP BY
SELECT COUNT(*) AS "N� de productos por proveedor"
FROM Northwind.dbo.products
GROUP BY SupplierID

-- Selecci�n de valores constantes usando el operador UNION
SELECT 1 AS "Numeros"
UNION
	SELECT 2
UNION
	SELECT 3
