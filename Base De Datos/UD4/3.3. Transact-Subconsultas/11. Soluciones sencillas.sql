/***************************************************SOLUCIONES SENCILLASAlgunos problemas tienen una solución más sencilla cuando
se usan subconsultas.EJEMPLONos interesa saber cuáles son los productos que mejor se venden, sea en cantidad de unidades o en importe total de la venta.****************************************************/

USE Northwind
GO

SET NOCOUNT ON
GO

-- Recuperamos los productos que mejor se venden en unidades o en importe
-- Esta solución USA SUBCONSULTAS
	SELECT 'Por unidades' AS CriteriO
		, ProductName as 'Mejor Vendido'
	FROM Products
	WHERE ProductID = 
		(
			SELECT ProductID
			FROM [Order Details]
			GROUP BY ProductID
			HAVING SUM(Quantity) = 
				(
					SELECT MAX(Unidades)
					FROM 
						(
							SELECT SUM(Quantity) as Unidades
							FROM [Order Details]
							GROUP BY ProductID
						) AS OD
				)
		)

UNION

	SELECT 'Por importe' AS Criterio
		, ProductName as 'Mejor vendido'
	FROM Products
	WHERE ProductID = 
		(
			SELECT ProductID
			FROM [Order Details]
			GROUP BY ProductID
			HAVING SUM(UnitPrice * Quantity * (1-Discount)) = 
				(
					SELECT MAX(Unidades)
					FROM 
						(
							SELECT SUM(UnitPrice * Quantity * (1-Discount)) as Unidades
							FROM [Order Details]
							GROUP BY ProductID
						) AS OD
				)
		)

-- Esta solución también usa subconsultas
	SELECT 'Por unidades' AS Criterio
		, ProductName as 'Mejor vendido'
	FROM Products P
		JOIN 
			(
				SELECT TOP 1 ProductID
					, SUM(Quantity) AS Unidades
				FROM [Order Details]
				GROUP BY productID
				ORDER BY Unidades DESC
			) AS OD
	ON OD.ProductID = P.ProductID
	
    UNION

	SELECT 'Por importe' AS Criterio
		, ProductName as 'Por importe'
	FROM Products P
		JOIN 
			(
				SELECT TOP 1 ProductID
					, SUM(UnitPrice * Quantity * (1-Discount)) AS Importe
				FROM [Order Details]
				GROUP BY ProductID
				ORDER BY Importe DESC
			) AS OD
	ON OD.ProductID = P.ProductID

-- Esta solución no usa subconsultas. 
-- Sin embargo su ejecución es similar a la de la consulta que usa subconsultas
SELECT ProductID
	, SUM(Quantity) AS Unidades
	, CAST(SUM(UnitPrice * Quantity * (1.0-Discount))AS money) as Importe
INTO #MejorVendidos
FROM [Order Details]
WHERE ProductID IS NOT NULL
GROUP BY productID

DECLARE @MaxUnidades int, @MaxImporte money
DECLARE @Cod_prod_uni int, @Cod_prod_imp int

SELECT @MaxUnidades = MAX(Unidades)
	, @MaxImporte = MAX(Importe)
FROM #MejorVendidos

SELECT @Cod_prod_uni = ProductID
FROM #MejorVendidos
WHERE Unidades = @MaxUnidades

SELECT @Cod_prod_imp = ProductID
FROM #MejorVendidos
WHERE Importe = @MaxImporte

-- Se inicia la consulta UNION
	SELECT 'Unidades' AS Criterio
		, ProductName as 'Por importe'
	FROM Products
	WHERE ProductID = @Cod_prod_uni

UNION

	SELECT 'Por importe' AS Criterio
		, ProductName as 'Por importe'
	FROM Products
	WHERE ProductID = @Cod_prod_imp

-- La consulta UNION finaliza
-- Eliminamos la tabla temporal
DROP TABLE #MejorVendidos
