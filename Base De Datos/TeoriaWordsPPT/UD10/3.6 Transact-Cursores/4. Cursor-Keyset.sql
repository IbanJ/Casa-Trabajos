/***************************************************Uso de CURSORES controlados por CONJUNTOS DE CLAVES.La salida producida si llevamos a cabo las mismas actuaciones queen el ejemplo "2. Cursores estáticos" sería el siguiente:	- Muestra el cambio en ProductName	- Produce un mensaje de error en la fila eliminada (ProductId=35)	- No muestra la fila insertada (ProductName='Nuevo Producto')****************************************************/USE Northwind
GO

-- Declaramos el cursor
DECLARE MisProductos CURSOR KEYSET
FOR
	SELECT ProductID, ProductName
	FROM Products
	WHERE ProductID > 70
	ORDER BY ProductID

-- Abrimos el cursor
	OPEN MisProductos
	
	-- Recuperamos la primera fila del cursor
	FETCH NEXT FROM MisProductos INTO @ID, @name
	
	-- Modificamos directamente la tabla Products
	UPDATE Products
	SET  ProductName= 'Nuevo nombre'
	WHERE ProductID =32
	
	-- Eliminamos una fila de la tabla Products
	DELETE Products
	WHERE ProductID = 35
	
	-- Añadimos una nueva fila a la tabla Products 
	INSERT Products (ProductName,Discontinued)
	VALUES ('Nuevo Producto',1)
	
	-- Mientras recuperemos datos del cursor
	WHILE @@FETCH_STATUS <> -1
	BEGIN
	
		IF @@FETCH_STATUS = -2
			-- Nos enteramos de que La fila ha sido eliminada
			PRINT CHAR(10) + 'Fila inexistente' + CHAR(10)
		ELSE
			-- Mostramos los valores desde el cursor
			SELECT @ID, @Name
		
		-- Recuperamos la siguiente fila del cursor
		FETCH NEXT FROM MisProductos
			INTO @ID, @Name
	END
	
	-- Cerramos el cursor
	CLOSE MisProductos
	
	-- Destruimos el cursor
	DEALLOCATE MisProductos

-- Deshacemos los cambios realizados
ROLLBACK TRAN
