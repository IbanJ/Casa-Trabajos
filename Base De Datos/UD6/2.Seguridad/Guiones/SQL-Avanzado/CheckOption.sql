/***************************************************
En ocasiones, interesa evitar la actualizaci�n de datos que no forman parte del rango
de datos pertenecientes a la vista.
Para resolver este problema utilizamos la cl�usula WITH CHECK OPTION
****************************************************/
USE Northwind
GO

CREATE VIEW Braziliancustomers
AS
SELECT *
FROM Customers
WHERE country = 'Brazil'
WITH CHECK OPTION
GO

UPDATE Braziliancustomers
SET country = 'USA'
WHERE customerid = 'WELLI'
GO

