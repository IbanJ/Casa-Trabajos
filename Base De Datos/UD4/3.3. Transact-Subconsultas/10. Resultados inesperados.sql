/***************************************************PROBLEMAS EN LA REESCRITURA DE CONSULTAS QUE USAN SUBCONSULTAS PARA EVITAR EL USO DE SUBCONSULTAS****************************************************/USE Northwind
GO

SET NOCOUNT ON
GO

-- Recuperamos todas las categorías que tienen algún producto
-- con la palabra 'pasta'
PRINT 'Usando una subconsulta' + CHAR(10)

SELECT CategoryName
FROM Categories
WHERE CategoryID IN
	(
		SELECT CategoryID
		FROM Products
                WHERE Description LIKE '%pasta%'
	)
	

-- Esta solución no usa una subconsulta pero devuelve 7 filas
PRINT 'Sin usar una subconsulta' + CHAR(10)

SELECT CategoryName
FROM Categories
	JOIN Products
		ON Products.categoryID = Categories.CategoryID
WHERE Description LIKE '%pasta%'


-- Esta solución no usa una subconsulta pero de nuevo una fila
PRINT 'Usando DISTINCT sin una subconsulta' + CHAR(10)

SELECT DISTINCT CategoryName
FROM Categories
	JOIN Products
		ON Products.categoryID = Categories.CategoryID
WHERE Description LIKE '%pasta%'


/********************************************************************************
COMENTARIOS
Todas las consultas que usan subconsultas se pueden definir como consultas
estándares sin subconsultas.
Sin embargo, hay algunos problemas que tienen una solución más sencilla cuando
se usan subconsultas.
********************************************************************************/








