/***************************************************SUBCONSULTAS MATRICIALESUna consulta matricial o consulta estándar, se puede usar como subconsultadentro de otra consulta en los siguientes casos:	- En la cláusula FROM de una instrucción SELECT, como tabla derivada	  con varias filas y columnas.	- En la cláusula WHERE , cuado se usan las palabras clave EXISTS o NOT	  EXISTS para verfificar la existencia de valores en la lista. La función	  EXISTS no devuelve ninguna fila; su valor es TRUE cuando la subconsulta 	  devuelve al menos una fila y FALSE en caso contrario.****************************************************/

USE Northwind
GO

SET NOCOUNT ON
GO


/******************************************************************************
 1. SUBCONSULTA MATRICIAL COMO TABLA DERIVADA
	Recuperamos el nombre del producto y de la categoría de aquellos productos
	cuya categoría está entre 1 y 5 y cuyo nombre empieza por 'M'
******************************************************************************/
SELECT CategoryName, ProductName
FROM Products P
	JOIN (
			SELECT CategoryID, CategoryName
			FROM Categories
			WHERE CategoryID BETWEEN 1 AND 5
		) AS C
		ON C.CategoryID = P.CategoryID
WHERE ProductName LIKE 'M%'



/******************************************************************************
 2. SUBCONSULTA MATRICIAL UTILIZANDO EL OPERADOR UNION
	Mostramos si tenemos registradas ventas de bebidas
******************************************************************************/
SELECT 'Hemos vendido bebidas'
AS [Ventas de bebidas]
WHERE EXISTS(
		SELECT *
		FROM [Order details] O
			JOIN Products P
				ON O.ProductID = P.ProductID
		WHERE P.CategoryID = 1
	)

UNION

SELECT 'No hemos vendido bebidas'
WHERE NOT EXISTS(
		SELECT *
		FROM [Order details] O
			JOIN Products P
				ON O.ProductID = P.ProductID
		WHERE P.CategoryID = 1
	)
