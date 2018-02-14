/***************************************************Utilización de la instrucción RETURN en un procedimiento almacenadoLa instrucción RETURN puede ser emitida sin parámetros en cuyo casodevolverá el control al programa que llamó al procedimiento.Si existe valor de retorno éste debe ser un entero.Cuando se usa un tipo de datos devuelto distinto de entero, el procedimiento es creadopero en tiempo de ejecución provoca un error.El valor de retorno predeterminado es 0. (Si se emite un RETURN sin parámetro devolverá un 0).Es lo mismo decir RETURN que RETURN 0.EL VALOR DE RETORNO NO ES UN PARÁMETRO DE SALIDA (son cosas distintas y a veces se confunde). Un procedimiento almacenado puede tener más de un parámetro de salida pero solo un valor de retorno.****************************************************/USE Northwind
GO

CREATE PROC dbo.coger_empleado
   @empleadoid INT
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM Employees WHERE employeeid = @empleadoid)
		RETURN -1
	ELSE
		SELECT * FROM Employees WHERE employeeid = @empleadoid

	RETURN
END

/***************************************************CÓDIGO DE PRUEBAAlmacenamiento en una variable del valor de retorno de un procedimiento almacenado.Es absolutamente necesario si queremos procesar el valor de retorno.****************************************************/DECLARE @existe_empleado INT
EXEC @existe_empleado = coger_empleado 5
SELECT @existe_empleado
GO