/***************************************************SUBCONSULTAS CORRELACIONADAS SIMULANDO UNA CONDICIÓN INNER JOIN****************************************************/
USE Northwind
GO

SET NOCOUNT ON
GO

-- Seleccionamos los productos que estén en algún pedido
SELECT ProductID
	, UnitPrice
	, (
			SELECT AVG(UnitPrice)
			FROM [Order Details]
			WHERE [Order Details].ProductID = Products.ProductID
	) AS PrecioMedio
	, (
			SELECT MIN(UnitPrice)
			FROM [Order Details]
			WHERE [Order Details].ProductID = Products.ProductID
	) AS PrecioMinimo
	, ProductName
FROM Products
WHERE EXISTS (
		SELECT *
		FROM [Order Details]
		WHERE [Order Details].ProductID = Products.productID
	)
	AND CategoryID = 1
