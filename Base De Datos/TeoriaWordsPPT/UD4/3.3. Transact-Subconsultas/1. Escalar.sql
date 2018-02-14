/***************************************************CONSULTAS ESCALARESDevuelven un solo valor que puede ser:	- Una constante individual	- Un resultado devuelto por una funci�n de sistema	- Un resultado de una consulta normal****************************************************/

USE Northwind
GO

SET NOCOUNT ON
GO

-- Selecci�n de un valor constante
SELECT 1

-- Selecci�n de una funci�n de sistema escalar din�mica
SELECT SYSTEM_USER

-- Selecci�n de una funci�n de sistema escalar
SELECT db_ID('Northwind')

-- Selecciona el resultado de una funci�n definida por el usuario
-- Esta funci�n no existe
 SELECT fn_capturaProductNameDesdeID(123)

-- Selecci�n del resultado de una funci�n agregada
SELECT COUNT(*) as Numfilas
FROM Northwind.dbo.Products

-- Selecci�n de una sola columna de una sola fila en una tabla
SELECT ProductName
FROM Northwind.dbo.Products
WHERE ProductID = 5
