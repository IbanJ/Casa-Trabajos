/***************************************************Los procedimientos anidados pueden alcanzar 32 niveles.Se puede controlar el nivel de anidamiento mediante la función @@nestlevel.Cuando un procedimiento almacenado llama a otro, la función anterior seincrementa en 1 y se decrementa cuando termina de ejecutarse un procedimiento.EJEMPLO:El primer procedimiento (ChequearSupplier) devuelve -1 si existe el proveedory 0 en caso contrario.El segundo procedimiento (InsertarSupplier) llama al primer procedimiento para saber si los datos están almacenados y, si no es así, los inserta.Observar el nivel de anidamiento.****************************************************/USE Northwind
GO

-- Creamos el Procedimiento almacenado "ChequearProveedor"
CREATE PROC dbo.ChequearProveedor
       @nombre_proveedor VARCHAR(40)
AS
	PRINT '3) El nivel de anidamiento es ' + CAST(@@nestlevel AS VARCHAR(5))
	IF EXISTS (SELECT * FROM Suppliers WHERE companyname = @nombre_proveedor)
		RETURN -1
	ELSE
		RETURN 0
	GO

-- Creamos el Procedimiento almacenado "InsertarProveedor"
CREATE PROC dbo.InsertarProveedor
	@nombre_proveedor NVARCHAR(40),
	@contacto NVARCHAR(30),
	@contactitulo NVARCHAR(30)
AS
	DECLARE @Existe_Proveedor INT
	PRINT '2) El nivel de anidamiento es ' + CAST(@@nestlevel AS VARCHAR(5))

	EXEC @Existe_Proveedor = ChequearProveedor @nombre_proveedor
	PRINT '4) El nivel de anidamiento es  ' + CAST(@@nestlevel AS VARCHAR(5))
	IF @Existe_Proveedor = 0
		INSERT INTO dbo.Suppliers (companyname,contactname,contacttitle)
			VALUES (@nombre_proveedor,@contacto,@contactitulo)
	ELSE
		PRINT 'Este proveedor ya existe en la base de datos'
	GO

-- PRUEBA EN EL SSMS
PRINT '1) El nivel de anidamiento es ' + CAST(@@nestlevel AS VARCHAR(5))
EXEC InsertarProveedor 'AAAA','Ramón Trueba','Sales Manager'
PRINT '5) El nivel de anidamiento es  ' + CAST(@@nestlevel AS VARCHAR(5))
GO


/***************************************************Cuando un procedimiento principal llama a otros procedimientos debehacerlo uno detrás de otro; esto no se considera anidamiento.Por tanto, desde un procedimiento principal podemos llamar más de 32 procedimientos almacenados.Ejemplo: el máximo valor alcanzado es 1.****************************************************/USE AdventureWorks
GO

-- Creamos el procedimiento almacenado con dos
-- procedimientos almacenados de sistema cualesquiera
CREATE PROC dbo.MostrarSeguridad
AS
	EXEC sp_help
	PRINT '2) El nivel de anidamiento es ' + CAST(@@nestlevel AS VARCHAR(5))
	EXEC sp_helpuser
	PRINT '3) El nivel de anidamiento es ' + CAST(@@nestlevel AS VARCHAR(5))
	GO

-- Ejecutamos el código de prueba
PRINT '1) El nivel de anidamiento es ' + CAST(@@nestlevel AS VARCHAR(5))
EXEC MostrarSeguridad
PRINT '4) El nivel de anidamiento es ' + CAST(@@nestlevel AS VARCHAR(5))
GO


/* **************************************************Una ventaja del anidamiento es que cuando desde un procedimiento se llama a otro,el procedimiento interior puede acceder a todos los objetos creados por el procedimientoalmacenado exterior. Veamos este ejemplo.*************************************************** */USE Northwind
GO

-- Creamos el procedimiento que va a ser llamado en la prueba
CREATE PROC procedimiento_externo
AS
	SELECT orderid, orderdate INTO #Spain_orders
	FROM Orders
	WHERE Shipcountry = 'Spain'
		AND Shipcity = 'Barcelona'
	
	EXEC procedimiento_interno
	GO

-- Creamos el procedimiento que va a ser llamado desde el 
-- otro procedimiento
CREATE PROC procedimiento_interno
AS
	SELECT *
	FROM #Spain_orders
	GO

-- Hacemos la prueba
EXEC procedimiento_externo