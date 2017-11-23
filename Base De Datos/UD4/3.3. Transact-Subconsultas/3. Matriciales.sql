/***************************************************CONSULTAS MATRICIALESDevuelven conjuntos de resultados con varias columnasEJEMPLOS****************************************************/

USE Northwind
GO

SET NOCOUNT ON
GO

--1. Selecci�n de varias columnas de una tabla
SELECT ProductName, UnitPrice
FROM Northwind.dbo.Products
WHERE CategoryID = 1

--2. Selecci�n de varias constantes
SELECT 1 AS 'Menor'
	, 2 AS 'Mayor'
	, 'Dani' AS 'Responsable'

--3. Selecci�n de valores de funciones de sistema
SELECT CURRENT_TIMESTAMP AS 'Ahora'
	, CURRENT_USER AS 'Usuario de la Base de datos'
	, SYSTEM_USER AS 'Cuenta de sistema'

--4. Selecci�n de datos de varias tablas usando el operador UNION 
	SELECT CompanyName, ContactName
	FROM Northwind.dbo.Customers
	WHERE Country = 'Brazil'
		UNION
	SELECT CompanyName, ContactName
	FROM Northwind.dbo.Suppliers
