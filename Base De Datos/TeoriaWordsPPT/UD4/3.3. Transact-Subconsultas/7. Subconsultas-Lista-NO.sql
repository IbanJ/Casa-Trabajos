/***************************************************SOLUCIONES ALTERNATIVAS A LOS EJERCICIOS REALIZADOS NO Subconsultas-Lista****************************************************/
USE Northwind
GO

SET NOCOUNT ON
GO

/******************************************************************************
 1. Pedidos efectuados por clientes de Londres y tramitados por el empleado 1
******************************************************************************/
SELECT O.OrderID, O.CustomerID, O.EmployeeID, O.OrderDate
FROM Orders O
	JOIN Customers C
		ON O.CustomerID = C.CustomerID
WHERE City = 'London'
	AND EmployeeID = 1


/******************************************************************************
 2. Selección de todos los productos cuyo precio unitario es mayor que el de todos
    los productos de la categoría 3
******************************************************************************/
DECLARE @MAX money

SELECT @MAX = MAX(Unitprice)
FROM Products
WHERE CategoryID = 3

SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > @MAX



/******************************************************************************
 3. Recuperar todas las lineas de pedidos relacionados con productos de la categoría
    3 y cuyo código de pedido esté entre 10250 y 10030
******************************************************************************/
SELECT OD.OrderID, OD.ProductID, OD.UnitPrice
FROM [Order Details] OD
	JOIN Products P
		ON P.ProductID = OD.ProductID
WHERE CategoryID = 3
	AND OrderID BETWEEN 10250 AND 10300



/******************************************************************************
 4. Listar todos los productos pero solo en el caso de que haya alguno que no
    haya sido pedido
******************************************************************************/
DECLARE @numero int

SELECT @numero = COUNT(*)
FROM Products
	LEFT OUTER JOIN [Order Details]
		ON Products.ProductID = [Order Details].ProductID
WHERE [Order Details].ProductID IS NULL

SELECT ProductID, ProductName
FROM Products
WHERE ISNULL(@numero, 0) > 0

-- O

IF EXISTS(
		SELECT Products.ProductID
		FROM Products
			LEFT OUTER JOIN [Order Details]
				ON Products.ProductID = [Order Details].ProductID
		WHERE [Order Details].ProductID IS NULL
	)
	SELECT ProductID, ProductName
	FROM Products
