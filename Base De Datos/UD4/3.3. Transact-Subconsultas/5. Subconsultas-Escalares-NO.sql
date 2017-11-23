/***************************************************SOLUCIONES ALTERNATIVAS A LOS EJERCICIOS REALIZADOS NO ESCALARES****************************************************/
USE Northwind
GO

SET NOCOUNT ON
GO

-- Obtención del precio medio
SELECT (
	MIN(UnitPrice) +
	MAX(UnitPrice)
	)/2 AS NuevoPrecio
FROM Products

-- Selecciona tres constantes
SELECT 1, 2, 3
GO

-- Recuperamos una sola fila con el precio máximo y el precio medio
SELECT AVG(Unitprice) as PrecioMedio,
	MAX(Unitprice) as PrecioMaximo
FROM Products

GO

-- Compara el precio de cada producto con el precio medio
DECLARE @MEDIO money

SELECT @MEDIO = AVG(Unitprice)
FROM Products

SELECT ProductName, UnitPrice, @MEDIO AS PrecioMedio
FROM Products
WHERE CategoryID = 2
GO


-- Actualiza  el precio del producto 11 con un valor  
-- un 20% más alto que el precio unitario máximo.
DECLARE @MAXIMO money

SELECT @MAXIMO = MAX(Unitprice)
FROM Products

UPDATE Products
SET UnitPrice = @MAXIMO * 1.2
WHERE ProductID = 11


GO
-- Muestra el producto con el precio unitario máximo
DECLARE @MAXIMO money

SELECT @MAXIMO = MAX(Unitprice)
FROM Products

SELECT ProductName, UnitPrice
FROM Products P
WHERE Unitprice = @MAXIMO

GO

-- Recuperamos las Categorías cuyo precio medio sea mayor
-- que el precio medio general
DECLARE @MEDIO money

SELECT @MEDIO = AVG(Unitprice)
FROM Products

SELECT CategoryID, AVG(UnitPrice)
FROM Products P
GROUP BY CategoryID
HAVING AVG(UnitPrice) > @MEDIO
