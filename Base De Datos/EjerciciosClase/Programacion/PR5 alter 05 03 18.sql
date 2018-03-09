declare @salida1 as varchar(50)
declare @salida2 as varchar(50)
declare @salida3 as money
exec PR5 5, @salida1 output ,@salida2 output ,@salida3 output
print @salida1
print @salida2
print @salida3
-- PR5
/*
	Tabla Sales.SalesPerson de AdventureWorks2014

	En este programa queremos recuperar la informacion
	de la persona que mas ha vendido en el ultimo año
	(SalesLastYear) en un determinado territorio.
	El programa recibira:
		* El codigo de territorio
		* la direccion de una variable en donde
		  almacenaremos el nombre de la persona
		* la direccion de una variable en donde
		  almacenaremos el apellido de la persona
		* la direccion de una variable en donde
		  almacenaremos las ventas de dicho año



*/
ALTER PROCEDURE PR5
	@p_codTerritorio int,
	@p_nombre varchar(50) OUTPUT,
	@p_apellido varchar(50) OUTPUT,
	@p_ventas money OUTPUT


AS
BEGIN
	SELECT	@p_nombre = per.FirstName,
			@p_apellido = per.LastName,
			@p_ventas = ventas.SalesLastYear
	FROM AdventureWorks2014.Sales.SalesPerson as Ventas
		JOIN AdventureWorks2014.HumanResources.Employee as Empleado
		ON ventas.BusinessEntityID=Empleado.BusinessEntityID
		JOIN AdventureWorks2014.person.Person as per
		ON per.BusinessEntityID=Empleado.BusinessEntityID
	WHERE Ventas.TerritoryID = @p_codTerritorio
		AND Ventas.SalesLastYear =
			(
				SELECT MAX(SalesLastYear)
				FROM AdventureWorks2014.Sales.SalesPerson
				WHERE TerritoryID=1
			)
	
END

--SELECT * FROM AdventureWorks2014.sales.SalesPerson