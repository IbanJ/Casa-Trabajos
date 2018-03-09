--Codigo de Prueba
DECLARE @salida as money
EXECUTE PR4 'tacoma', @salida output
Print @salida 
-- PR4  -- BD: Northwind
/*
	Crear un procedimiento que reciba como parametro de entrada
	el nombre de una ciudad y como parametro de salida
	una variable que recibira el salario maximo 
	de los empleados de dicha ciudad.
*/

ALTER Procedure PR4
	@p_ciudad nvarchar(15),
	@p_SalarioMaximo money output

AS
BEGIN
	SELECT @p_SalarioMaximo = MAX(salario)
	FROM Northwind.dbo.Employees
	WHERE City=@p_ciudad

END



-- select * from Northwind.dbo.Employees