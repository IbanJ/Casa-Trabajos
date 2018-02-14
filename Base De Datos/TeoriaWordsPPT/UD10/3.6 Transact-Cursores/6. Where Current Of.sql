/***************************************************Uso de WHERE CURRENT OF para aplicar modificacionesa la fila actual del cursor****************************************************/
USE Northwind
GO
--Antes de empezar vemos el estado de los productos
SELECT *
FROM Products
WHERE ProductID > 70
GO

BEGIN TRAN
	-- Declaramos el cursor
	DECLARE Mis_Products CURSOR FORWARD_ONLY
	FOR
		SELECT ProductID, ProductName
		FROM Products
		WHERE ProductID > 70
		ORDER BY ProductID
	FOR UPDATE
	 
	-- Abrimos el cursor
	OPEN Mis_Products
	
	-- Recuperamos la primera fila
	FETCH NEXT FROM Mis_Products
	
	-- Actualizamos el nombre del Producto (ProductName)
	-- y su precio (UnitPrice) en la posición actual del cursor
	UPDATE Products
	SET ProductName = ProductName + ' (está en estado dicontinued)'
		, UnitPrice = UnitPrice * (1.0 + CategoryID / 100.0)
	WHERE CURRENT OF Mis_Products
	
	SELECT *
	FROM Products
	WHERE ProductID > 70
	-- Cerramos el cursor
	CLOSE Mis_Products
	
	-- Liberamos el cursor
	DEALLOCATE Mis_Products	

ROLLBACK TRAN
