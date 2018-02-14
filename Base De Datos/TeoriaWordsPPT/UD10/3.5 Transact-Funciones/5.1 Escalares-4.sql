/***************************************************
LLAMADAS A FUNCIONES ESCALARES DEFINIDAS POR EL USUARIO

Una funci�n escalar definida por el usuario se puede usar
en una instrucci�n Transact-SQL en calquier lugar en el 
que se admita una expresi�n.

Para llamarla, es preciso cualificar el nombre de la
funci�n con el nombre del propietario.

Las funciones definidas por el usuario son locales respecto de 
la base de datos donde se las crea. 

Aqu� tenemos varios formatos de llamada a una funci�n llamada 
MaxProductid propiedad de dbo.
****************************************************/
USE AdventureWorks

-- Sacar el c�digo del �ltimo pedido
SELECT dbo.Max_CodPedido()
GO

-- Sacar cada c�digo de pedido con el c�digo de pedido m�s alto
SELECT SalesOrderID, dbo.Max_CodPedido() AS 'MaxCodPedido'
FROM Sales.SalesOrderHeader
GO

-- Sacar los nombres de los productos vendidos en el �ltimo pedido
SELECT P.ProductID, Name
FROM Production.Product AS P
	JOIN Sales.SalesOrderDetail AS OD
		ON P.ProductID = OD.ProductID
		AND od.SalesOrderID = dbo.Max_CodPedido()
GO
