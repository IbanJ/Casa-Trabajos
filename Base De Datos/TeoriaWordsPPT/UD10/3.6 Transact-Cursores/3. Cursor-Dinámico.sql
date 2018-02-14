/***************************************************Uso de CURSORES DINÁMICOS para ver los cambios producidos en otrasconexiones.La salida producida si llevamos a cabo las mismas actuaciones queen el ejemplo "2. Cursores estáticos" sería el siguiente:	- Muestra el cambio en ProductName	- Produce un mensaje de error en la fila eliminada (ProductId=35)	- Muestra la fila insertada (ProductName='Nuevo Producto')****************************************************/USE Northwind
GO

-- Iniciamos una nueva transacción para poder descartar los cambios
BEGIN TRAN
	DECLARE @ID int, @name nvarchar(40)
	
-- Declaramos el cursor
DECLARE MisProductos CURSOR DYNAMIC
FOR
	SELECT ProductID,ProductName
	FROM Products
	WHERE ProductID BETWEEN 30 AND 50
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

/***************************************************Los cambios a los datos realizados desde la misma conexión siempre son visibles para el cursor dinámico.Por el contrario, los cambios realizados por otras conexiones no son visibleshasta que se confirmen las transacciones que modificaron los datos, a menos que se especifique un nivel de aislamiento "Lecturas de no confirmadas" (read uncommited) para la transacción que contiene el cursor.****************************************************/