/***************************************************SOLUCIONES ALTERNATIVAS A LOS EJERCICIOS REALIZADOS NO Subconsultas-Matriciales***************************************************/USE Northwind
GO

/******************************************************************************
 1. Recuperamos el nombre del producto y de la categoría de aquellos productos
	cuya categoría está entre 1 y 5 y cuyo nombre empieza por 'M'
******************************************************************************/
SELECT CategoryName, ProductName
FROM Products P
	JOIN Categories AS C
		ON C.CategoryID = P.CategoryID
WHERE P.CategoryID BETWEEN 1 AND 5
	AND ProductName LIKE 'M%'



/******************************************************************************
 2. Mostramos si tenemos registradas ventas de bebidas
******************************************************************************/
DECLARE @Num int

SELECT @Num = COUNT(*)
FROM [Order details] O
	JOIN Products P
		ON O.ProductID = P.ProductID
WHERE P.CategoryID = 1

SELECT 
	CASE
		WHEN ISNULL(@Num, 0) > 0
			THEN  'Hemos vendido bebidas'
		ELSE 'No hemos vendido bebidas'
	END
AS [Venta de Bebidas]




/********************************************************************************
COMENTARIOS
1. A veces puede ocurrir que se obtengan resultados no esperados al convertir una
   consulta que usa una subconsulta en otra que no lo hace. La consulta debe estar
   bien definida.
2. SQL Server recomienda usar IF EXISTS (SELECT * FROM ...), porque el optimizador
   de consultas usa mejor el índice disponible para comprobar la existencia de
   filas.
********************************************************************************/

