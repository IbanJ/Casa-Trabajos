/***************************************************

USE Northwind
GO

SET NOCOUNT ON
GO

-- Recuperamos la lista de las ciudades en donde hay m�s de un cliente
-- ordenado por City y CompanyName

--1. Con subconsultas correlacionadas
SELECT City, CompanyName
FROM Customers C1
WHERE City IN (
		SELECT City
		FROM Customers C2
		WHERE C2.CustomerID <> C1.CustomerID
	)
	AND Country = 'Argentina'
ORDER BY City, CompanyName



--2. Sin subconsultas correlacionadas
SELECT DISTINCT C1.City, C1.CompanyName
FROM Customers C1
	JOIN Customers AS C2
		ON C2.City = C1.City
WHERE C2.CustomerID <> C1.CustomerID
	AND C1.Country = 'Argentina'
ORDER BY C1.City, C1.CompanyName