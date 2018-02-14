/***************************************************USO DE CURSORES TRANSACT PARA APLICAR CAMBIOS FILA POR FILA****************************************************/

USE Northwind
GO

SET NOCOUNT ON
GO

--	Declaración de variables de Servidor

DECLARE @ID int, @PrecioUnitario money

-- Declaramos el cursor
DECLARE MisProductos CURSOR LOCAL
	FORWARD_ONLY
	FOR
		SELECT ProductID, UnitPrice
		FROM Products

-- Abrimos el cursor
OPEN MisProductos

-- Recuperamos la primera fila del cursor
FETCH NEXT FROM MisProductos
	INTO @ID, @PrecioUnitario

WHILE @@FETCH_STATUS = 0

-- Mientras tengamos éxito en la lectura
BEGIN

	-- Actualizamos el producto actual
	UPDATE Products
	SET UnitPrice = @PrecioUnitario * 1.05
	WHERE CURRENT OF MyProducts
	
	-- Recuperamos el siguiente producto
	FETCH NEXT FROM MisProductos
		INTO @ID, @PrecioUnitario
		
END

-- Cerramos el cursor
CLOSE MisProductos

-- Liberamos el cursor
DEALLOCATE MisProductos
