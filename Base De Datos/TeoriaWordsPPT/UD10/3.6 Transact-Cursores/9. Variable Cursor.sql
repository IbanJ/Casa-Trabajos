/***************************************************Uso de variables cursor****************************************************/
USE Northwind
GO

-- Declaramos una variable de tipo cursor
DECLARE @Products AS CURSOR

-- Asignación de una definición de cursor a 
-- la variable de cursor
SET @Products = CURSOR STATIC
FOR
	SELECT ProductID, ProductName
	FROM Products

-- Abrimos cursor
OPEN @Products

-- Recuperamos la primera fila del cursor
FETCH NEXT FROM @Products

-- Cerramos el cursor
CLOSE @Products

-- Destruimos el cursor
DEALLOCATE @Products
