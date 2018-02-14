/***************************************************Uso de un CURSOR ESTÁTICOAl usar un cursor estático tenemos un conjunto de resultadostotalmente aislado.En este ejemplo vemos que las modificaciones no se reflejan en elcursor estático.****************************************************/
USE Northwind
GO

-- Iniciamos una nueva transacción para poder descartar los cambios
BEGIN TRAN
	DECLARE @ID int, @name nvarchar(40)
	
	-- Declaramos el cursor
	DECLARE MisProductos CURSOR STATIC
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
		FETCH NEXT FROM MisProductos INTO @ID, @Name
	END
	
	-- Cerramos el cursor
	CLOSE MisProductos
	
	-- Destruimos el cursor
	DEALLOCATE MisProductos

-- Deshacemos los cambios realizados
ROLLBACK TRAN

/* *****************************************************************************************
Nota 1.
En Sql Server los cursores estáticos son de sólo lectura.

Nota 2.
Se les suele llamar también snapshots (instantáneas) o insensitive.

Nota 3.
Ya que SQL Server los almacena en la base de datos tempdb, el tamaño total de las columnas
seleccionadas no puede exceder el número máximo de bytes en una fila estándar.

Precaución.
Si tenemos una aplicación que hace un uso extensivo de cursores debemos asegurarnos de tener
suficiente espacio libre en la base de datos tempdb.
*******************************************************************************************/
