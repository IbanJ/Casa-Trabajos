/***************************************************FUNCIONES TABULARESEjemplos de llamadas a funciones tabulares****************************************************/USE Northwind
GO

-- Funci�n tabular_ClientesDelPais()
PRINT CHAR(10) 
	+ 'Uso de tabular_ClientesDelPais(''Mexico'')' 
	+ CHAR(10)
SELECT CustomerID, CompanyName, Country
FROM dbo.tabular_ClientesDelPais('Mexico')

-- Funci�n tabular_ClientesDeUsa()
PRINT CHAR(10) 
	+ 'Uso de tabular_ClientesDeUsa()' 
	+ CHAR(10)
Select CustomerID, CompanyName, Country
FROM dbo.tabular_ClientesDeUsa()

-- Funci�n tabular_ClientesDelPais() con el operador IN
PRINT CHAR(10)
	+ 'Uso de tabular_ClientesDelPais(''Mexico'') con el operador IN'
	+ CHAR(10)
SELECT OrderID,
	CONVERT(varchar(10), OrderDate, 120) AS FechaPedido
FROM Orders
WHERE CustomerID IN
	(
	SELECT CustomerID
	FROM dbo.tabular_ClientesDelPais('Mexico')
	)

-- Funci�n Tabular_PedidosPorImporte()
PRINT CHAR(10)
	+ 'Mezcla Tabular_PedidosPorImporte con Customers'
	+ CHAR(10)
SELECT CompanyName, OrderID, ImporteTotal,
	CONVERT(varchar(10), OrderDate, 120) AS FechaPedido
FROM dbo.Tabular_PedidosPorImporte(10000) AS Tabular
	JOIN Customers C
		ON Tabular.CustomerID = C.CustomerID

-- Funci�n Tabular_DiezPedidosMasImportantes()
PRINT CHAR(10)
	+ 'Mezcla Tabular_DiezPedidosMasImportantes con Customers'
	+ CHAR(10)
SELECT CompanyName, OrderID, ImporteTotal,
	CONVERT(varchar(10), OrderDate, 120) AS FechaPedido
FROM dbo.Tabular_DiezPedidosMasImportantes() AS Tabular
	JOIN Customers C
		ON Tabular.CustomerID = C.CustomerID
