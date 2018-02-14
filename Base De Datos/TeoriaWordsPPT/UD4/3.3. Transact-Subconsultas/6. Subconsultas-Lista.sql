/***************************************************SUBCONSULTAS DE LISTAUna consulta de lista se puede usar como subconsulta dentro de una consulta en los casos siguientes:	- En la cl�usula WHERE de cualquier consulta que use el operador	  IN, donde la subconsulta undicar� una lista de valores posibles.	- En la cl�usula WHERE cuando se use cualquier operador de comparaci�n	  con los operadores ALL, SOME o ANY.	- En la cl�usula FROM de una instrucci�n SELECT, como tabla derivada	  con varias filas y columnas.	- En la cl�usula WHERE, cuando usan las palabras clave EXISTS o NOT EXISTS	  para verificar la existencia de valores en la lista.EJEMPLOS****************************************************/

USE Northwind
GO

SET NOCOUNT ON
GO
/******************************************************************************
 1. Con el operador IN
    Pedidos efectuados por clientes de Londres y tramitados por el empleado 1
******************************************************************************/

SELECT OrderID, CustomerID, EmployeeID, OrderDate 
FROM Orders
WHERE CustomerID IN (
		SELECT CustomerID
		FROM Customers
		WHERE City = 'London'
	)
	AND EmployeeID = 1



/******************************************************************************
 2. Con el operador ALL
    Selecci�n de todos los productos cuyo precio unitario es mayor que el de todos
    los productos de la categor�a 3
******************************************************************************/

SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > ALL (
		SELECT UnitPrice
		FROM Products
		WHERE CategoryID = 3
	)



/******************************************************************************
 3. Con tablas derivadas
    Recuperar todas las lineas de pedidos relacionados con productos de la categor�a
    3 y cuyo c�digo de pedido est� entre 10250 y 10030
******************************************************************************/

SELECT OD.OrderID, OD.ProductID, OD.UnitPrice
FROM [Order Details] OD
	JOIN (
			SELECT ProductID
			FROM Products
			WHERE CategoryID = 3
		) AS P
		ON P.ProductID = OD.ProductID
WHERE OrderID BETWEEN 10250 AND 10300



/******************************************************************************
 4. Con la palabra clave EXISTS
    Listar todos los productos pero solo en el caso de que haya alguno que no
    haya sido pedido
******************************************************************************/

SELECT ProductID, ProductName
FROM Products
WHERE EXISTS (
		SELECT Products.ProductID
		FROM Products
			LEFT OUTER JOIN [Order Details]
				ON Products.ProductID = [Order Details].ProductID
		WHERE [Order Details].ProductID IS NULL
	)
