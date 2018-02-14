/***************************************************CONVERSIÓN DE UN PROCEDIMIENTO ALMACENADO QUE DEVUELVE UN ÚNICO CONJUNTO DE RESULTADOS EN UNA FUNCIÓN TABULARSi tenemos un procedimiento almacenado que da acceso de lecturay escritura a una tabla a través de una biblioteca de cliente,podemos convertirlo en una función en línea.Procedimiento creado:	sp_DiezMejoresPedidos****************************************************/USE Northwind
GO

CREATE PROCEDURE sp_DiezMejoresPedidos
AS
	DECLARE @lista TABLE (
		  OrderID int
		, CustomerID nchar(5)
		, OrderDate datetime
		, ValorTotal money)
	
	INSERT @Lista
		SELECT O.OrderID, CustomerID, OrderDate, ValorTotal
		FROM Orders O
			JOIN (
				SELECT OrderID
					, SUM(dbo.PrecioTotal(Quantity, UnitPrice, Discount)) AS ValorTotal
				FROM [Order Details]
				GROUP BY OrderID
			) AS OD
				ON O.OrderID = OD.OrderID
	
	SELECT TOP 10 WITH TIES
		OrderID, CustomerID, OrderDate, ValorTotal
	FROM @Lista
	ORDER BY ValorTotal DESC
GO

-- Ejecutamos el procedimiento anterior
EXECUTE sp_DiezMejoresPedidos
GO

-- Ejecutamos la función
SELECT *
FROM Tabular_DiezPedidosMasImportantes()
GO
