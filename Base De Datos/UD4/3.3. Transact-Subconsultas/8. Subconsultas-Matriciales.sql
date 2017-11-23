/***************************************************SUBCONSULTAS MATRICIALESUna consulta matricial o consulta est�ndar, se puede usar como subconsultadentro de otra consulta en los siguientes casos:	- En la cl�usula FROM de una instrucci�n SELECT, como tabla derivada	  con varias filas y columnas.	- En la cl�usula WHERE , cuado se usan las palabras clave EXISTS o NOT	  EXISTS para verfificar la existencia de valores en la lista. La funci�n	  EXISTS no devuelve ninguna fila; su valor es TRUE cuando la subconsulta 	  devuelve al menos una fila y FALSE en caso contrario.****************************************************/

USE Northwind
GO

SET NOCOUNT ON
GO


/******************************************************************************
 1. SUBCONSULTA MATRICIAL COMO TABLA DERIVADA
	Recuperamos el nombre del producto y de la categor�a de aquellos productos
	cuya categor�a est� entre 1 y 5 y cuyo nombre empieza por 'M'
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
