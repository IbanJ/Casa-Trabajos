/***************************************************CREACIÓN DE FUNCIONES TABULARESEJEMPLOS: Cómo crear funciones tabulares similares a las que creamos en las funciones en líneaFunciones creadas:	tabular_ClientesDelPais	tabular_ClientesDeUsa	Tabular_PedidosDeLaFecha	Tabular_PedidosDeHoy	Tabular_PedidosConImporte	Tabular_PedidosPorImporte	Tabular_DiezPedidosMasImportantes****************************************************/
USE Northwind
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tabular_ClientesDelPais]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[tabular_ClientesDelPais]
GO

-- Devuelve los clientes del país enviado como parámetro
CREATE FUNCTION dbo.tabular_ClientesDelPais
	(@Pais nvarchar(15))
RETURNS @Lista TABLE
	(CustomerID nchar(5)
	, CompanyName nvarchar(40)
	, Country nvarchar(15))
AS
BEGIN
	INSERT @Lista
		SELECT CustomerID, CompanyName, Country
		FROM Customers
		WHERE Country = @Pais
	
	RETURN
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tabular_ClientesDeUsa]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[tabular_ClientesDeUsa]
GO
-- Devuelve los clientes de USA
CREATE FUNCTION dbo.tabular_ClientesDeUsa
()
RETURNS @Lista TABLE
	(CustomerID nchar(5)
	, CompanyName nvarchar(40)
	, Country nvarchar(15))
AS
BEGIN
	INSERT @Lista
		SELECT CustomerID, CompanyName, Country
		FROM dbo.ClientesDelPais(N'USA')
		
	RETURN
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tabular_PedidosDeLaFecha]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Tabular_PedidosDeLaFecha]
GO
-- Devuelve los pedidos de una fecha particular
CREATE FUNCTION dbo.Tabular_PedidosDeLaFecha
	(@fecha as smalldatetime)
RETURNS @list TABLE
	(OrderID int
	, OrderDate datetime)
AS
BEGIN
	INSERT @List
		SELECT OrderID, OrderDate
		FROM Orders
		WHERE DATEDIFF(day, OrderDate, @fecha) = 0
		
	RETURN
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tabular_PedidosDeHoy]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Tabular_PedidosDeHoy]
GO
-- Devuelve los pedidos del día actual
CREATE FUNCTION dbo.Tabular_PedidosDeHoy
()
RETURNS @list TABLE
	(OrderID int
	, OrderDate datetime)
AS
BEGIN
	INSERT @List
		SELECT OrderID, OrderDate
		FROM Orders
		WHERE DATEDIFF(day, OrderDate, GETDATE()) = 0
	
	RETURN
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tabular_PedidosConImporte]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Tabular_PedidosConImporte]
GO
-- Devuelve los pedidos con el importe total
CREATE FUNCTION dbo.Tabular_PedidosConImporte
()
RETURNS @lista TABLE
	(OrderID int
	, CustomerID nchar(5)
	, OrderDate datetime
	, ImporteTotal money)
AS
BEGIN
	INSERT @Lista
		SELECT O.OrderID, CustomerID, OrderDate, ValorTotal
		FROM Orders O
		JOIN (
			SELECT OrderID
				, SUM(dbo.ImporteTotal(Quantity, UnitPrice, Discount))
			AS ValorTotal
			FROM [Order Details]
			GROUP BY OrderID
			) AS OD
			ON O.OrderID = OD.OrderID
	
	RETURN
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tabular_PedidosPorImporte]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Tabular_PedidosPorImporte]
GO
-- Devuelve los pedidos cuyo importe supera un valor dado
CREATE FUNCTION dbo.Tabular_PedidosPorImporte
	(@total money)
RETURNS @lista TABLE
	(OrderID int
	, CustomerID nchar(5)
	, OrderDate datetime
	, ImporteTotal money)
AS
BEGIN
	INSERT @Lista
		SELECT OrderID, CustomerID, OrderDate, ImporteTotal
		FROM dbo.PedidosConImporte()
		WHERE ImporteTotal > @total
	
	RETURN
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tabular_DiezPedidosMasImportantes]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Tabular_DiezPedidosMasImportantes]
GO
-- Devuelve los 10 pedidos con mayor importe
CREATE FUNCTION dbo.Tabular_DiezPedidosMasImportantes
()
RETURNS @lista TABLE
	(OrderID int
	, CustomerID nchar(5)
	, OrderDate datetime
	, ImporteTotal money)
AS
BEGIN
	INSERT @Lista
		SELECT TOP 10 WITH TIES
			OrderID, CustomerID, OrderDate, ImporteTotal
		FROM dbo.PedidosConImporte()
		ORDER BY ImporteTotal DESC
	
	RETURN
END
GO
