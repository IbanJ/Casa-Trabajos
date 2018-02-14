/***************************************************UTILIZACI�N DE LOS DATOS PROVENIENTES DE FUNCIONES EN LINEAEn una instrucci�n DML se puede usar una funci�n en l�nea de la misma forma que una tabla o una vista, salvo que despu�sdel nombre de la funci�n debemos usar par�ntesis, incluso si no se requiere usar ning�n par�metro.SQL Server combina la definisci�n de la funci�n con la definici�nde la consulta, con el fin de crear un �nico plan de consulta.EJEMPLOS que muestran las diferentes formas de llamar a lasfunciones en l�nea definidas por el usuario.****************************************************/USE Northwind
GO

-- Funci�n ClientesDelPais
PRINT CHAR(10) 
	+ 'Uso de ClientesDelPais(''Mexico'')' 
	+ CHAR(10)
SELECT CustomerID, CompanyName, City
FROM dbo.ClientesDelPais('Mexico')

-- Funci�n ClientesDeUsa
PRINT CHAR(10) + 'Uso de ClientesDeUsa()' + CHAR(10)
SELECT CustomerID, CompanyName, City
FROM dbo.ClientesDeUsa()

-- Funci�n ClientesDelPais con el operador IN
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

-- Funci�n PedidosPorImporte
PRINT CHAR(10)
	+ 'Combinaci�n de PedidosPorImporte con Customers'
	+ CHAR(10)
SELECT CompanyName
	, OrderID
	, ImporteTotal
	, CONVERT(varchar(10), OrderDate, 120) AS FechaDePedido
FROM dbo.PedidosPorImporte(10000) AS OBV
	JOIN Customers C
		ON OBV.CustomerID = C.CustomerID

-- Funci�n DiezPedidosMasImportantes
PRINT CHAR(10)
	+ 'Combinaci�n de los 10 mejores pedidos con la tabla Customers'
	+ CHAR(10)
SELECT CompanyName
	, OrderID
	, ImporteTotal
	, CONVERT(varchar(10), OrderDate, 120) AS FechaDePedido
FROM dbo.DiezPedidosMasImportantes() AS OBV
JOIN Customers C
	ON OBV.CustomerID = C.CustomerID
