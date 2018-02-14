/***************************************************
EJEMPLOS DE FUNCIONES EN LINEA DEFINIDAS POR EL USUARIO
Lo que caracteriza a las funciones en línea definidas por
el usuario es la cláusula RETURNS TABLE.

La creación de una función en línea definida por el usuario
no difiere mucho de la creación de una vista, excepto por la
presencia de una lista de parámetros, lo que le da a las funciones
en línea definidas por el usuario una funcionalidad adicional 
que las vistas no tienen.

Lista de funciones creadas:
	ClientesDelPais
	ClientesDeUsa
	PedidosDeLaFecha
	PedidosDeHoy
	PedidosConImporte
	PedidosPorImporte
	DiezPedidosMasImportantes
****************************************************/
USE Northwind
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ImporteTotal]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ImporteTotal]
GO
CREATE FUNCTION dbo.ImporteTotal
(@Cantidad float, @PrecioUnitario money, @Descuento decimal(3,2) = 0.0)
RETURNS money
AS
BEGIN
	RETURN (@Cantidad * @PrecioUnitario * (1.0 - @Descuento))
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClientesDelPais]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ClientesDelPais]
GO
-- Devuelve los clientes de un determinado País
CREATE FUNCTION dbo.ClientesDelPais
	(@country nvarchar(15))
RETURNS TABLE
AS
	RETURN (
		SELECT *
		FROM Customers
		WHERE Country = @country
	)
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClientesDeUsa]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ClientesDeUsa]
GO
-- Devuelve los clientes de USA
CREATE FUNCTION dbo.ClientesDeUsa
	()
RETURNS TABLE
AS
	RETURN (
		SELECT *
		FROM dbo.ClientesDelPais('USA')
	)
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PedidosDeLaFecha]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[PedidosDeLaFecha]
GO
-- Devuelve los pedidos de una fecha particular
CREATE FUNCTION dbo.PedidosDeLaFecha
	(@Fecha as smalldatetime)
RETURNS TABLE
AS
	RETURN (
		SELECT *
		FROM Orders
		WHERE DATEDIFF(day, OrderDate, @Fecha) = 0
	)
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PedidosDeHoy]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[PedidosDeHoy]
GO
-- Devuelve los pedidos de Hoy
CREATE FUNCTION dbo.PedidosDeHoy
()
RETURNS TABLE
AS
	RETURN (
		SELECT *
		FROM Orders
		
		WHERE DATEDIFF(day, OrderDate, GetDate()) = 0
	)
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PedidosConImporte]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[PedidosConImporte]
GO
-- Devuelve los pedidos con el importe total
CREATE FUNCTION dbo.PedidosConImporte
()
RETURNS TABLE
AS
	RETURN (
		SELECT O.*, ImporteTotal
		FROM Orders O
			JOIN (
				SELECT OrderID
					, SUM(dbo.ImporteTotal(Quantity, UnitPrice, Discount))
						AS ImporteTotal
				FROM [Order Details]
				GROUP BY OrderID
			) AS OD
				ON O.OrderID = OD.OrderID
	)
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PedidosPorImporte]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[PedidosPorImporte]
GO
-- Devuelve los pedidos cuyo importe supera un valor dado
CREATE FUNCTION dbo.PedidosPorImporte
	(@total money)
RETURNS TABLE
AS
	RETURN (
		SELECT *
		FROM dbo.PedidosConImporte()
		WHERE ImporteTotal > @total
	)
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DiezPedidosMasImportantes]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[DiezPedidosMasImportantes]
GO
-- Devuelve los 10 pedidos con mayor importe
CREATE FUNCTION dbo.DiezPedidosMasImportantes
	()
RETURNS TABLE
AS
	RETURN (
		SELECT TOP 10 WITH TIES *
		FROM dbo.PedidosConImporte()
		ORDER BY ImporteTotal DESC
	)

GO
