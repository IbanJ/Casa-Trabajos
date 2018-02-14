/***************************************************Uso de la opción TYPE_WARNING****************************************************/

USE Northwind
GO

SET NOCOUNT ON
GO

-- Declaramos el cursor como FAST_FORWARD
-- pero es convertido en un KEYSET
-- ya que usa columnas ntext y la cláusula ORDER BY

DECLARE MyCategories CURSOR
FAST_FORWARD READ_ONLY
TYPE_WARNING
FOR
	SELECT CategoryID, CategoryName, Description
	FROM Categories
	ORDER BY CategoryName ASC

-- Abrimos el cursor
OPEN MyCategories

-- Recuperamos la primera fila
FETCH NEXT FROM MyCategories

-- Cerramos el cursor
CLOSE MyCategories

-- Eliminamos el cursor
DEALLOCATE MyCategories
