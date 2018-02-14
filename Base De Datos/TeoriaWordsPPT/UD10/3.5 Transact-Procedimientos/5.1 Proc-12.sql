/***************************************************
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

SET @cod_cli = 'ALFKI'
EXEC CogerInformacionCliente @cod_cli, @nombre OUTPUT, @compa OUTPUT
SELECT @nombre + ' - ' + @compa


/***************************************************
        @compania NVARCHAR(80)
SET @cod_cliente = 'BERGS'
EXEC CogerInformacionCliente @cod_cliente, @nombre, @compania
SELECT @nombre + ' - ' + @compania
GO

