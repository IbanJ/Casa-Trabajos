/***************************************************Creaci�n de un procedimiento almacenado con uso de par�metros deentrada y de salidaUn par�metro de entrada recoge un valor (recoge una copia de los datos).Un par�metro de salida recoge la direcci�n de una variable (un puntero a la cariable). Cualquier cambio sobre la variable en el procedimiento modificar� el valor de la variableoriginal. Se debe especificar OUTPUT en la creaci�n del procedimiento y tambi�ncuando se llama al procedimiento.****************************************************/USE Northwind
GO

-- Creamos el procedimiento
CREATE PROC dbo.CogerDireccionEmpleado
	@empleadoid INT,
	@empleadodireccion NVARCHAR(120) OUTPUT
AS
BEGIN
	SELECT @empleadodireccion = address + '. ' + city + '. ' + region + '. ' + 
		   postalcode + '. ' + country
	FROM Employees
	WHERE employeeid = @empleadoid
END

-- C�digo de prueba
DECLARE @direccion VARCHAR(120)
EXEC CogerDireccionEmpleado 3, @direccion
PRINT @direccion
