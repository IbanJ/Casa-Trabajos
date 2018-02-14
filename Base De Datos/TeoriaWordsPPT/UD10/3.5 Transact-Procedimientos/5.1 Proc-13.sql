/***************************************************Creación de un procedimiento almacenado con uso de parámetros deentrada y de salidaUn parámetro de entrada recoge un valor (recoge una copia de los datos).Un parámetro de salida recoge la dirección de una variable (un puntero a la cariable). Cualquier cambio sobre la variable en el procedimiento modificará el valor de la variableoriginal. Se debe especificar OUTPUT en la creación del procedimiento y tambiéncuando se llama al procedimiento.****************************************************/USE Northwind
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

-- Código de prueba
DECLARE @direccion VARCHAR(120)
EXEC CogerDireccionEmpleado 3, @direccion
PRINT @direccion
