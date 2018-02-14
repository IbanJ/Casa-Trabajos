-- Una funcion que recibe como parametro:
-- Una Fecha
-- Y devulve : el numero de empleados que nacieron en esa fecha.
-- AdventureWorks2014

Create function F_4 (
	@p_fecha date			)

returns smallint

as

begin
	return(
	SELECT count(*)
	FROM AdventureWorks2014.HumanResources.Employee
	WHERE BirthDate = @p_fecha)

end



