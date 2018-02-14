/***************************************************ACTUALIZACIONES DE TABLAS CON FUNCIONES EN LINEA DEFINIDASPOR EL USUARIOLas funciones en línea definidas por el usuario pueden ser utilizadaspara actualizar tablas, con las mismas limitaciones qeu implica el usode vistas para esta finalidad.EJEMPLOS:Estos ejemplos actualizan la tabla "ORDERS" mediante la función en línea definida por el usuario llamada "PedidosConImporte"****************************************************/USE Northwind
GO

/* ***************************************************************
   Actualización a través de la función ClientesDeUsa()
*****************************************************************/
PRINT CHAR(10) + 'Antes del alta' + CHAR(10)
SELECT CustomerID, CompanyName, Country
FROM dbo.ClientesDeUsa()
WHERE CustomerID > 'W'

INSERT dbo.ClientesDeUsa() 
	(CustomerID, CompanyName, Country)
VALUES ('ZXXXX', 'Paga bien', 'USA')

PRINT CHAR(10) + 'Después del alta' + CHAR(10)
SELECT CustomerID, CompanyName, Country
FROM dbo.ClientesDeUsa()
WHERE CustomerID > 'W'

UPDATE dbo.ClientesDeUsa()
SET CompanyName = 'Nuevo cliente'
WHERE CustomerID = 'ZXXXX'

PRINT CHAR(10) + 'Después de la actualización' + CHAR(10)
SELECT CustomerID, CompanyName, Country
FROM dbo.ClientesDeUsa()
WHERE CustomerID > 'W'

DELETE dbo.ClientesDeUsa()
WHERE CustomerID = 'ZXXXX'

PRINT CHAR(10) + 'Después del borrado' + CHAR(10)
SELECT CustomerID, CompanyName, Country
FROM dbo.ClientesDeUsa()
WHERE CustomerID > 'W'
GO

/* ***************************************************************
   Actualización a través de la función PedidosConImporte()
*****************************************************************/
DECLARE @ID int

PRINT CHAR(10) + 'Antes del alta' + CHAR(10)
SELECT CustomerID, OrderID, ImporteTotal, OrderDate
FROM dbo.PedidosConImporte()
WHERE CustomerID = 'WARTH'

INSERT dbo.PedidosConImporte() 
	(CustomerID, OrderDate)
SELECT 'WARTH', GETDATE()

-- Recuperamos el último valor de identidad generado en la sesión
SET @ID = SCOPE_IDENTITY()

INSERT INTO [Order Details]
	(OrderID, ProductID, Quantity, UnitPrice, Discount)
SELECT @ID, 28, 10, UnitPrice, 0.1
FROM Products
WHERE ProductID = 28

PRINT CHAR(10) + 'Después del alta' + CHAR(10)
SELECT CustomerID, OrderID, ImporteTotal, OrderDate
FROM dbo.PedidosConImporte()
WHERE CustomerID = 'WARTH'

DELETE [Order Details]
WHERE OrderID = @ID

DELETE Orders
WHERE OrderID = @ID

PRINT CHAR(10) + 'Después del borrado' + CHAR(10)
SELECT CustomerID, OrderID, ImporteTotal, OrderDate
FROM dbo.PedidosConImporte()
WHERE CustomerID = 'WARTH'
