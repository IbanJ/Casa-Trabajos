/***************************************************
MANTENIMIENTO DE DATOS DESNORMALIZADOS
Usamos funciones de agregación para obtener resúmenes de datos.
Ejemplo: Tenemos que obtener los totales de venta por categoría de producto
en cualquier momento (tiempo real).
Tenemos cinco formas:
****************************************************/

-- 1. MEDIANTE FUNCIONES DE AGREGACIÓN.
--    Solución aceptable si estas consultas se realizan con poca frecuencia.
USE Northwind
GO

SELECT P.CategoryID
	, C.CategoryName
	, SUM(OD.UnitPrice * Quantity * (1 - Discount)) as Total
FROM [Order Details] OD
	JOIN Products P
		ON P.ProductID = OD.ProductID
	JOIN Categories C
		ON C.CategoryID = P.CategoryID
WHERE CategoryName = 'Confections'
GROUP BY P.CategoryID, C.categoryName




-- 2. MEDIANTE UNA VISTA.
--    Esta solución permite un buen control de la seguridad pero no nos da un
--	  aumento de la velocidad, ya que SQL Server debe combinar las definiciones de la
--	  vista y de la consulta, por lo que el plan de ejecución final se ejecutará cada 
--	  vez que se utilice la vista.

--    Solución aceptable si estas consultas se realizan con poca frecuencia.

USE Northwind
GO

-- Creamos la vista

CREATE VIEW TotalSalesPorCategoria
AS
	SELECT P.CategoryID
		, C.CategoryName
		, SUM(OD.UnitPrice * Quantity * (1 - Discount)) as Total
	FROM [Order Details] OD
		JOIN Products P
			ON P.ProductID = OD.ProductID
		JOIN Categories C
			ON C.CategoryID = P.CategoryID
	GROUP BY P.CategoryID, C.categoryName
GO

-- Usamos la vista para obtener los totales para la Categoría 'Confections'
SELECT *
FROM TotalSalesPorCategoria
WHERE CategoryName = 'Confections'




--3. MEDIANTE UN PROCEDIMIENTO ALMACENADO
--	 Puede ser más rápida que las opciones 1 y 2 por la reutilización del
--	 plan de consulta.
--	 Si la frecuencia de utilización es baja, en comparación con las operaciones
--	 de inserción y modificación en las tablas subyacentes, es una solución eficaz.
USE Northwind
GO

-- Crea el procedimiento

CREATE PROCEDURE CogerVentasPorCategoria
@NombreCat nvarchar(15)
AS
	SELECT P.CategoryID
		, C.CategoryName
		, SUM(OD.UnitPrice * Quantity * (1 - Discount)) as Total
	FROM [Order Details] OD
		JOIN Products P
			ON P.ProductID = OD.ProductID
		JOIN Categories C
			ON C.CategoryID = P.CategoryID
	WHERE CategoryName = @NombreCat
	GROUP BY P.CategoryID, C.categoryName
GO

-- Usa el procedimiento para calcular los totales de 
-- la categoría 'Confections' 

EXEC CogerVentasPorCategoria 'Confections'

/* *******************************************************************************************
NOTA
	El plan de consulta de los supuestos 1,2 y 3 es el mismo. El más eficiente es el 3 ya 
	que en casos de ejecución repetida se ahorra la necesidad de analizar, compilar y 
	optimizar la consulta. Es más fácil reutilizar el plan de consulta que procesar una
	consulta directa, y además se genera menos tráfico de red.
*********************************************************************************************/




--4. MEDIANTE DESENCADENADORES
--   Es la forma más rápida.
--	 Crearemos una tabla desnormalizada en la que almacenaremos los totales calculados, y crearemos
--	 triggers que se encargarán de mantener la información automáticamente, cada vez que 
--	 se produzcan cambios en los datos almacenados en la tabla "Order Details".
--	 En este caso, la lectura de los datos es muy eficiente, a diferencia de la actualización, que
--	 es menos eficiente porque después de cada modificación SQL Server debe ejecutar el trigger.

USE Northwind
GO

-- Creamos una tabla desnormalizada

CREATE TABLE VentasPorCategoria(
	  CategoryID int NOT NULL 
		PRIMARY KEY
	, CategoryName nvarchar(15) NOT NULL
	, TotalSales money DEFAULT 0
)
GO

-- Procedimiento de sincronización que incluye la carga inicial de los datos

CREATE PROCEDURE SyncVentasPorCategoria
AS
	TRUNCATE TABLE VentasPorCategoria

	INSERT VentasPorCategoria
	SELECT CategoryID
		, CategoryName
		, 0
	FROM Categories

	UPDATE TC
	SET TotalSales =
		(SELECT SUM(OD.UnitPrice * Quantity * (1 - Discount))
		FROM [Order Details] OD
			JOIN Products P
				ON P.ProductID = OD.ProductID
		WHERE P.CategoryID = TC.categoryID)
	FROM TotalCategoriesSales TC
GO

-- Sincronizamos los totales
-- Podemos ejecutar este procedimiento siempre que sea necesario
EXEC SyncVentasPorCategoria

GO


CREATE TRIGGER modOrderDetails
ON [Order Details]
AFTER INSERT, UPDATE, DELETE
AS

	UPDATE TC
	SET TotalSales = TotalSales
		- D.UnitPrice * Quantity * (1 - Discount)
	FROM VentasPorCategoria TC
		JOIN Products P
			ON P.CategoryID = TC.CategoryID
		JOIN Deleted D
			ON D.ProductID = P.productID

	UPDATE TC
	SET TotalSales = TotalSales
		+ I.UnitPrice * Quantity * (1 - Discount)
	FROM VentasPorCategoria TC
		JOIN Products P
			ON P.CategoryID = TC.CategoryID
		JOIN Inserted I
			ON I.ProductID = P.productID
GO

-- Selecciona los valores iniciales

PRINT CHAR(10) + 'Resumen de valores iniciales' + CHAR(10)

SELECT *
FROM VentasPorCategoria

-- Inserta un nuevo pedido

INSERT Orders (CustomerID)
SELECT 'ALFKI'

DECLARE @id int

SET @id = @@IDENTITY

-- Mostramos @@identity para futura referencia

SELECT @id AS OrderID

-- Vendemos 10 unidades de Ikura (cat 8) por $30.00 y un 10% de descuento

PRINT CHAR(10) + 'Inserción del pedido de Ikura (cat 8)' + CHAR(10)

INSERT [Order Details]
(orderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (@id, 10, 30, 10, 0.1)

-- Sell 20 units of Tofu (cat 7) at $20.00 and 20% discount

PRINT CHAR(10) + 'Insert Tofu (cat 7) Order' + CHAR(10)

INSERT [Order Details]
(orderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (@id, 14, 20, 100, 0.2)

-- Vendemos 5 unidades de Queso Cabrales (cat 4) por $20.00 y sin descuento

PRINT CHAR(10) + 'Insert Queso Cabrales (cat 4) Order' + CHAR(10)

INSERT [Order Details]
(orderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (@id, 11, 20, 5, 0.0)

-- Comprobamos los nuevos totales

SELECT *
FROM VentasPorCategoria

-- Actualizamos la cantidad de Queso Cabrales incrementando la cantidad en 100 unidades

PRINT CHAR(10) + 'Incremento de Queso Cabrales (cat 4) en 100' + CHAR(10)

UPDATE [Order Details]
SET Quantity = 100
WHERE OrderID = @id
	AND ProductID = 11

-- Comprobamos los nuevos totales

SELECT *
FROM VentasPorCategoria

-- Eliminamos Tofu de este pedido

PRINT CHAR(10) + 'Eliminación del pedido Tofu (cat 7)' + CHAR(10)

DELETE [Order Details]
WHERE OrderID = @id
	AND ProductID = 14

-- Comprobamos los nuevos totales

SELECT *
FROM VentasPorCategoria

-- Eliminamos completamente todo el pedido

PRINT CHAR(10) + 'Eliminamos el pedido de Ikura (cat 8)' + CHAR(10)

DELETE [Order Details]
WHERE OrderID = @id
	AND ProductID = 10

PRINT CHAR(10) + 'Eliminamos el pedido de Queso Cabrales (cat 4)' + CHAR(10)

DELETE [Order Details]
WHERE OrderID = @id
	AND ProductID = 11

DELETE Orders
WHERE OrderID = @id

-- Comprobamos los nuevos totales

SELECT *
FROM VentasPorCategoria

/* *****************************************************************************************
Este trigger solo funciona con operaciones que afectan una sola fila.
No funciona en el caso de operaciones sobre más de una fila.

Para completar la tarea deberíamos crear también triggers para las tablas Products 
y Categories, ya que puede ocurrir que un producto se pase a otra categoría o que 
una categoría cambie de nombre.
La columna Categoryname de la tabla TotalVentasPorCategoria se podría eliminar,
pero en ese caso deberíamos combinar esta tabla con la tabla Categories para filtrar
por el nombre de categoría.
*******************************************************************************************/




--5. MEDIANTE VISTAS INDEXADAS
/* *****************************************************************************************
Podríamos crear un índice sobre la vista TotalVentasPorCateg. En este caso no necesitamos 
triggers para mantener la información actualizada y el analizador de consultas puede optar
por usar esta vista para resolver las consultas que requieran datos compatibles con los que
genera la vista, incluso si estas consultas no hacen referencia a la vista.
Esta es la situación mejor para obtener resúmenes, pero es menos eficaz que los triggers (si
pensamos que se pueden producir muchas modificaciones en los datos).

EJEMPLO: Uso de vistas indexadas para obtener resúmenes calculados de antemano
*******************************************************************************************/


USE Northwind
GO

-- Eliminamos la vista existente

IF OBJECT_ID('TotalVentasPorCategoria') IS NOT NULL
	DROP VIEW TotalVentasPorCategoria
GO

-- Configuración necesaria para crear una vista indexada

SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF
GO

-- Creamos la vista con Schemabinding
-- y usamos nombres con dos partes para los objetos

CREATE VIEW TotalVentasPorCategoria
WITH SCHEMABINDING
AS
	SELECT P.CategoryID
		, C.CategoryName
		, SUM(OD.UnitPrice * Quantity * (1 - Discount)) as Total
		, COUNT_BIG(*) as CB
	FROM dbo.[Order Details] OD
		JOIN dbo.Products P
			ON P.ProductID = OD.ProductID
		JOIN dbo.Categories C
			ON C.CategoryID = P.CategoryID
	GROUP BY P.CategoryID
		, C.categoryName
GO

-- Creamos el índice sobre la vista

CREATE UNIQUE CLUSTERED INDEX ndx_CatTotales
ON TotalVentasPorCategoria (CategoryName)
GO

-- Usamos la vista para buscar el total correspondiente a 'Confections'
-- Activamos la opción SHOWPLAN_TEXT
-- para mostrar que la vista es usada en lugar de las tablas base

SET SHOWPLAN_TEXT ON
GO

SELECT CategoryID
	, CategoryName
	, Total
FROM TotalVentasPorCategoria (NOEXPAND)
WHERE CategoryName = 'Confections'
