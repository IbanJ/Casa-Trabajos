/***************************************************LISTAS DE VALORESTRES EJEMPLOS****************************************************/
USE Northwind
GO

SET NOCOUNT ON
GO

--1. Selección de una columna de una tabla
SELECT CategoryName
FROM Northwind.dbo.Categories

-- Selección de valores agregados de una sola columna de una tabla con GROUP BY
SELECT COUNT(*) AS "Nº de productos por proveedor"
FROM Northwind.dbo.products
GROUP BY SupplierID

-- Selección de valores constantes usando el operador UNION
SELECT 1 AS "Numeros"
UNION
	SELECT 2
UNION
	SELECT 3
