/***************************************************
LLAMADAS A FUNCIONES ESCALARES DEFINIDAS POR EL USUARIO

Una función escalar definida por el usuario se puede usar
en una instrucción Transact-SQL en calquier lugar en el 
que se admita una expresión.

Para llamarla, es preciso cualificar el nombre de la
función con el nombre del propietario.

Las funciones definidas por el usuario son locales respecto de 
la base de datos donde se las crea. 

Aquí tenemos varios formatos de llamada a una función llamada 
MaxProductid propiedad de dbo.
****************************************************/
USE AdventureWorks

-- Sacar el código del último pedido
SELECT dbo.Max_CodPedido()
GO

-- Sacar cada código de pedido con el código de pedido más alto
SELECT SalesOrderID, dbo.Max_CodPedido() AS 'MaxCodPedido'
FROM Sales.SalesOrderHeader
GO

-- Sacar los nombres de los productos vendidos en el último pedido
SELECT P.ProductID, Name
FROM Production.Product AS P
	JOIN Sales.SalesOrderDetail AS OD
		ON P.ProductID = OD.ProductID
		AND od.SalesOrderID = dbo.Max_CodPedido()
GO
