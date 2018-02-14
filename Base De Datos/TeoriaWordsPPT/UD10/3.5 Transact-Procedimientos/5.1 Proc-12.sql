/***************************************************Utilización de los parámetros de salida****************************************************/USE Northwind
GO
/* 
   Creamos el procedimiento almacenado
*/
CREATE PROC dbo.CogerInformacionCliente
	@codigo NCHAR(10),
	@contacto NVARCHAR(60) OUTPUT,
	@company NVARCHAR(80) OUTPUT
AS
	SELECT @contacto = contactname,
		   @company = companyname
	FROM    Customers
	WHERE    customerid = @codigo
/* Llamamos al procedimiento almacenado desde el SSMS */DECLARE @cod_cli CHAR(5), @nombre VARCHAR(40), @compa VARCHAR(30)
SET @cod_cli = 'ALFKI'
EXEC CogerInformacionCliente @cod_cli, @nombre OUTPUT, @compa OUTPUT
SELECT @nombre + ' - ' + @compa


/***************************************************Utilización de los parámetros de salida sin la palabra clave OUTPUTEn esta situación los valores se pierden****************************************************/DECLARE @cod_cliente NCHAR(10),@nombre NVARCHAR(60), 
        @compania NVARCHAR(80)
SET @cod_cliente = 'BERGS'
EXEC CogerInformacionCliente @cod_cliente, @nombre, @compania
SELECT @nombre + ' - ' + @compania
GO


