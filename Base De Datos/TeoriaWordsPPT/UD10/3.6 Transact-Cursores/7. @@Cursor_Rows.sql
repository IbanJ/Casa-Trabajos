/***************************************************Uso de la función de sistema @@CURSOR_ROWSSería interesante modificar el tipo de cursor (STATIC / KEYSET / DYNAMIC)declarado sobre la tabla "CATEGORIES" en el procedimiento "CogerCategories"****************************************************/
USE Northwind
GO

-- Creamos un procedimiento para abrir un cursor sobre Categories
ALTER PROCEDURE CogerCategories
AS
	DECLARE Mis_Categories CURSOR STATIC
	FOR
		SELECT CategoryID, CategoryName
		FROM Categories
	
	OPEN Mis_Categories
		-- Mostramos el número de filas del cursor
	
	SELECT @@CURSOR_ROWS 'Filas del cursor sobre la tabla Categories después de abrirlo'
	
	CLOSE Mis_Categories
	
	DEALLOCATE Mis_Categories
GO

-- Creamos un cursor basado en la tabla Products
DECLARE Mis_Products CURSOR STATIC
FOR
	SELECT ProductID, ProductName
	FROM Products

OPEN Mis_Products

-- Muestra la cantidad de filas existentes en el último cursor abierto
SELECT @@CURSOR_ROWS 'Filas del cursor basado en la tabla Products'

EXEC CogerCategories

-- Muestra la cantidad de filas existentes en el último cursor abierto
-- (Mis_Categories) en la conexión actual
SELECT @@CURSOR_ROWS 'Filas del cursor basado en la tabla Categories después de cerrarlo y liberarlo'

CLOSE Mis_Products

DEALLOCATE Mis_Products
