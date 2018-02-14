/***************************************************UTILIZACIÓN DE LOS DATOS PROVENIENTES DE FUNCIONES EN LINEAEn una instrucción DML se puede usar una función en línea de la misma forma que una tabla o una vista, salvo que despuésdel nombre de la función debemos usar paréntesis, incluso si no se requiere usar ningún parámetro.SQL Server combina la definisción de la función con la definiciónde la consulta, con el fin de crear un único plan de consulta.EJEMPLOS que muestran las diferentes formas de llamar a lasfunciones en línea definidas por el usuario.****************************************************/USE Northwind
GO

-- Función ClientesDelPais
PRINT CHAR(10) 
	+ 'Uso de ClientesDelPais(''Mexico'')' 
	+ CHAR(10)
SELECT CustomerID, CompanyName, City
FROM dbo.ClientesDelPais('Mexico')

-- Función ClientesDeUsa
PRINT CHAR(10) + 'Uso de ClientesDeUsa()' + CHAR(10)
SELECT CustomerID, CompanyName, City
FROM dbo.ClientesDeUsa()

-- Función ClientesDelPais con el operador IN
PRINT CHAR(10)
	+ 'Uso ClientesDelPais(''Mexico'') con el operador IN'
	+ CHAR(10)
SELECT OrderID
	, CONVERT(varchar(10), OrderDate, 120) AS FechaDePedido
FROM Orders
WHERE CustomerID IN
	(
	SELECT CustomerID
	FROM dbo.ClientesDelPais('Mexico')
	)

-- Función PedidosPorImporte
PRINT CHAR(10)
	+ 'Combinación de PedidosPorImporte con Customers'
	+ CHAR(10)
SELECT CompanyName
	, OrderID
	, ImporteTotal
	, CONVERT(varchar(10), OrderDate, 120) AS FechaDePedido
FROM dbo.PedidosPorImporte(10000) AS OBV
	JOIN Customers C
		ON OBV.CustomerID = C.CustomerID

-- Función DiezPedidosMasImportantes
PRINT CHAR(10)
	+ 'Combinación de los 10 mejores pedidos con la tabla Customers'
	+ CHAR(10)
SELECT CompanyName
	, OrderID
	, ImporteTotal
	, CONVERT(varchar(10), OrderDate, 120) AS FechaDePedido
FROM dbo.DiezPedidosMasImportantes() AS OBV
JOIN Customers C
	ON OBV.CustomerID = C.CustomerID
