/***************************************************CONSULTAS ESCALARESDevuelven un solo valor que puede ser:	- Una constante individual	- Un resultado devuelto por una función de sistema	- Un resultado de una consulta normal****************************************************/

USE Northwind
GO

SET NOCOUNT ON
GO

-- Selección de un valor constante
SELECT 1

-- Selección de una función de sistema escalar dinámica
SELECT SYSTEM_USER

-- Selección de una función de sistema escalar
SELECT db_ID('Northwind')

-- Selecciona el resultado de una función definida por el usuario
-- Esta función no existe
 SELECT fn_capturaProductNameDesdeID(123)

-- Selección del resultado de una función agregada
SELECT COUNT(*) as Numfilas
FROM Northwind.dbo.Products

-- Selección de una sola columna de una sola fila en una tabla
SELECT ProductName
FROM Northwind.dbo.Products
WHERE ProductID = 5
