/***************************************************Demostración de la ejecución de un procedimiento almacenadocon parámetros por defecto****************************************************/USE Northwind
GO

-- Creamos un procedimiento para dar de alta a un cliente
CREATE PROC dbo.AltaCliente
	@customerid NCHAR(10),
	@companyname NVARCHAR(80),
	@contactname NVARCHAR(60),
	@contacttitle NVARCHAR(60) = 'Owner',
	@address NVARCHAR(120) = NULL,
	@city NVARCHAR(30) = 'Miranda de Ebro',
	@region NVARCHAR(30) = 'SP',
	@postalcode NVARCHAR(20) = '20300',
	@country NVARCHAR(30) = 'ESP',
	@phone NVARCHAR(48) = NULL,
	@fax NVARCHAR(48) = NULL
AS
	INSERT INTO Customers (customerid,companyname,contactname,contacttitle,address,
				city,region,postalcode,country,phone,fax)
	VALUES (@customerid,@companyname,@contactname,@contacttitle,@address,@city,
		   @region,@postalcode,@country,@phone,@fax)
	GO


-- Probamos el procedimiento almacenado anterior (envío por posición y por nombre)
AltaCliente @customerid='CLI01', @contactname='Eva García', @companyname = 'Trigos Castilla'

-- Esta es otra forma de enviar los argumentos (envío por posición)
AltaCliente 'CLI02','Kepa Segurola','Seguros y Cía'

/***************************************************Probamos usando variables locales como parámetros al llamar al  procedimiento almacenado****************************************************/DECLARE @Codigo CHAR(5), @contacto VARCHAR(30), @compa VARCHAR(40)
SET  @Codigo = 'CLI03'
SET @contacto = 'Ramón Zulaica'
SET  @compa = 'Zulaica Hnos'
EXEC AltaCliente @Codigo, @contacto, @compa
GO
