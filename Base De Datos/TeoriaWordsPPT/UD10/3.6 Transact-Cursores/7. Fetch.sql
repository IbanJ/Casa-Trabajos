/***************************************************Uso de la sentencia FETCH****************************************************/
USE Northwind
GO

SET NOCOUNT ON
GO

DECLARE Mis_Products CURSOR STATIC
FOR
	SELECT ProductID, ProductName
	FROM Products
	ORDER BY ProductID ASC

OPEN Mis_Products

SELECT @@CURSOR_ROWS 'Número de filas en el cursor'

SELECT @@FETCH_STATUS 'Estado del cursor después de OPEN'

FETCH FROM Mis_Products

SELECT @@FETCH_STATUS 'Estado del cursor después del primer FETCH'

FETCH NEXT FROM Mis_Products

SELECT @@FETCH_STATUS 'Estado del cursor después de FETCH NEXT'

FETCH PRIOR FROM Mis_Products

SELECT @@FETCH_STATUS 'Estado del cursor después de FETCH PRIOR'

FETCH PRIOR FROM Mis_Products

SELECT @@FETCH_STATUS 'Estado del cursor después de FETCH PRIOR desde la primera fila'

FETCH LAST FROM Mis_Products

SELECT @@FETCH_STATUS 'Estado del cursor después de FETCH LAST'

FETCH NEXT FROM Mis_Products

SELECT @@FETCH_STATUS 'Estado del cursor después de FETCH NEXT desde la última fila'

FETCH ABSOLUTE 10 FROM Mis_Products

SELECT @@FETCH_STATUS 'Estado del cursor después de FETCH ABSOLUTE 10'

FETCH ABSOLUTE -5 FROM Mis_Products

SELECT @@FETCH_STATUS 'Estado del cursor después de FETCH ABSOLUTE -5'

FETCH RELATIVE -20 FROM Mis_Products

SELECT @@FETCH_STATUS 'Estado del cursor después de FETCH RELATIVE -20'

FETCH RELATIVE 10 FROM Mis_Products

SELECT @@FETCH_STATUS 'Estado del cursor después de FETCH RELATIVE 10'

CLOSE Mis_Products

SELECT @@FETCH_STATUS 'Estado del cursor después de CLOSE'

DEALLOCATE Mis_Products
