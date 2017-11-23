/***************************************************SUBCONSULTAS CORRELACIONADASSon las subconsultas que dependen de valores tomados de la consulta exterior.En esta situación la subconsulta se ejecuta una vez para cada fila devueltapor la consulta exterior.Las subconsultas correlacionadas son fáciles de identificar porque:	- Van encerradas entre paréntesis.	- No es posible ejecutarlas de forma independiente de la consulta exterior.Las subconsultas correlacionadas pueden devolver:	- Un único valor escalar.	- Una lista de valores.	- Una disposición de valores.EJEMPLO:Queremos conocer el precio unitario sugerido para cada producto, junto con los preciosde venta promedio y máximo.****************************************************/

USE Northwind
GO

SET NOCOUNT ON
GO

-- Seleccionamos el precio unitario buscado, el precio mínimo, el precio máximo
-- y el precio medio para cada producto.
-- Sacamos además los productos que no tienen pedidos asociados.

/********************************************************************
1. Con una subconsulta correlacionada
********************************************************************/
SELECT ProductID
	, UnitPrice
	, (
			SELECT AVG(UnitPrice)
			FROM [Order Details]
			WHERE [Order Details].ProductID =
			Products.ProductID
		) AS PrecioMedio
	, (
			SELECT MIN(UnitPrice)
			FROM [Order Details]
			WHERE [Order Details].ProductID =
			Products.ProductID
		) AS PrecioMinimo
	, (
			SELECT MAX(UnitPrice)
			FROM [Order Details]
			WHERE [Order Details].ProductID =
			Products.ProductID
		) AS PrecioMaximo
	, ProductName
FROM Products
WHERE CategoryID = 1



/********************************************************************
2. Con una subconsulta estándar
********************************************************************/
SELECT P.ProductID
	, P.UnitPrice
	, MMP.PrecioMedio
	, MMP.PrecioMinimo
	, MMP.PrecioMaximo
	, P.ProductName
FROM Products P
	LEFT OUTER JOIN (
			SELECT ProductID
				, MIN(UnitPrice) AS PrecioMinimo
				, AVG(UnitPrice) AS PrecioMedio
				, MAX(UnitPrice) AS PrecioMaximo
			FROM [Order Details]
			GROUP BY ProductID
		) AS MMP
		ON MMP.ProductID = P.ProductID
WHERE CategoryID = 1



/********************************************************************
3. Sin subconsultas
********************************************************************/
SELECT P.ProductID
	, P.UnitPrice
	, AVG(OD.UnitPrice) AS PrecioMedio
	, MIN(OD.UnitPrice) AS PrecioMinimo
	, MAX(OD.UnitPrice) AS PrecioMaximo
	, P.ProductName
FROM Products P
	LEFT OUTER JOIN [Order Details] OD
		ON OD.ProductID = P.ProductID
WHERE CategoryID = 1
GROUP BY P.productID, P.UnitPrice, P.ProductName


/********************************************************************
NOTAS
Es importante cualificar los nombres de las columnas con el nombre de la tabla
dentro de las subconsultas. Si no cualificamos SQL Server intentará resolverlos
primero desde la subconsulta y luego desde la tabla exterior.
********************************************************************/
