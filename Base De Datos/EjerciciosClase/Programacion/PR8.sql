Declare @salida decimal(5,2)
EXEC dbo.PR8 1980,@salida output
PRINT @salida

-- Crear un procedimiento PR7
/* 
	Este procedimiento recibe los siguientes parametros:
		->Numero de año / HumanResources.Employee.BirthDate
		->Direccion de una variable (OUTPUT) en donde
		  almacenaremos la media de horas de vacaciones
		  de los empleados que nacieron en dicho año

	Utilizamos la tabla AdventureWorks2014.HumanResources.Employee
*/

ALTER PROCEDURE PR8
	@p_numAgno SMALLINT,
	@p_horasMedia decimal(5,2) OUTPUT
AS
BEGIN
	SELECT @p_horasMedia=avg(VacationHours*1.0)
	FROM AdventureWorks2014.HumanResources.Employee
	WHERE year(BirthDate)=@p_numAgno

END
