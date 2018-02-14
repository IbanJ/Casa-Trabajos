/***************************************************
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
EXEC InsertarProveedor 'AAAA','Ram�n Trueba','Sales Manager'
PRINT '5) El nivel de anidamiento es  ' + CAST(@@nestlevel AS VARCHAR(5))
GO


/***************************************************
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

-- Ejecutamos el c�digo de prueba
PRINT '1) El nivel de anidamiento es ' + CAST(@@nestlevel AS VARCHAR(5))
EXEC MostrarSeguridad
PRINT '4) El nivel de anidamiento es ' + CAST(@@nestlevel AS VARCHAR(5))
GO


/* **************************************************
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