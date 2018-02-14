/***************************************************Uso de la opción READ_ONLY para proteger el cursorcontra las actualizaciones****************************************************/
USE Northwind
GO

SET NOCOUNT ON
GO

BEGIN TRAN

	-- Declaramos el cursor
	DECLARE MisProductos CURSOR
	FORWARD_ONLY READ_ONLY
	FOR
		SELECT ProductID, ProductName
		FROM Products
		WHERE ProductID > 70
		ORDER BY ProductID
	
	-- Abrimos el cursor
	OPEN MisProductos
	
	-- Recuperamos la primera fila
	FETCH NEXT FROM MisProductos
	
	-- Intentamos modificar los datos de la fila actual
	-- y se produce un error cuando el cursor es READ_ONLY 
	
	UPDATE Products
	SET productname = 'Nombre modificado'
	WHERE CURRENT OF MisProductos
		
	-- Cerramos el cursor
	CLOSE MisProductos
	
	-- Eliminamos el cursor
	DEALLOCATE MisProductos

ROLLBACK TRAN
