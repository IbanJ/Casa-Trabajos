-- Crear un procedimiento: PR1 que recibe como parametro una fecha 
-- y nos devuelve los datos de todos los 
-- empleados nacidos en una fecha anterior
-- si no hay requisito el programa devuelve -1
-- si hay devuelve 0
ALTER PROCEDURE PR1
   @p_BirthDate datetime
   
AS

BEGIN
	IF NOT EXISTS (SELECT count(*)
				   FROM Northwind.dbo.Employees
				   WHERE BirthDate<=@p_BirthDate)
		RETURN -1
	SELECT FirstName, LastName, BirthDate
	FROM Northwind.dbo.Employees
	WHERE BirthDate<=@p_BirthDate


END