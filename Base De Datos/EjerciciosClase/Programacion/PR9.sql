-- Codigo de prueba
DECLARE @v1 int,
		@v2 varchar(30)
EXEC dbo.PR9 13261, @v1 OUTPUT,@v2 OUTPUT
PRINT @v1
PRINT @v2
/*
	Hacer un procedimiento que reciba como parametros un codigo y
	dos parametros output:
	-El primer parametro output recogera el numero de veces 
	que nos ha pedido el cliente
	-El segundo parametro recibira el nombre del cliente
*/

ALTER PROCEDURE PR9
	@p_codigoCliente smallint,
	@p_pedidosVeces smallint OUTPUT,
	@p_nombreCliente varchar(30) OUTPUT
AS
BEGIN
	SELECT @p_pedidosveces = Count(*)
	FROM AdventureWorks2014.Sales.SalesOrderHeader
	where CustomerID=@p_codigoCliente

	SELECT @p_nombreCliente=FirstName
	FROM AdventureWorks2014.Sales.vIndividualCustomer
	WHERE BusinessEntityID=@p_codigoCliente
END