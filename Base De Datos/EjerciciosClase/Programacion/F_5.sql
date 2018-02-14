-- Recuperar las fechas de nacimiento de nuestros
-- empleados y el numero de empleados que nacieron
-- en acda fecha, ordenados en ascendente de fecha.


	SELECT BirthDate, count(*)
	FROM AdventureWorks2014.HumanResources.Employee
	GROUP BY BirthDate
	ORDER BY BirthDate

CREATE FUNCTION F_5 ()

RETURNS TABLE 

AS

	RETURN (SELECT TOP 100 PERCENT BirthDate, COUNT(*) AS Numero
			FROM AdventureWorks2014.HumanResources.Employee
			GROUP BY BirthDate
			ORDER BY BirthDate)
