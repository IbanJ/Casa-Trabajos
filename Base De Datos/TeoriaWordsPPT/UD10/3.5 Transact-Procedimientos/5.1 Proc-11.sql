/***************************************************Utilizaci�n de la instrucci�n RETURN en un procedimiento almacenadoLa instrucci�n RETURN puede ser emitida sin par�metros en cuyo casodevolver� el control al programa que llam� al procedimiento.Si existe valor de retorno �ste debe ser un entero.Cuando se usa un tipo de datos devuelto distinto de entero, el procedimiento es creadopero en tiempo de ejecuci�n provoca un error.El valor de retorno predeterminado es 0. (Si se emite un RETURN sin par�metro devolver� un 0).Es lo mismo decir RETURN que RETURN 0.EL VALOR DE RETORNO NO ES UN PAR�METRO DE SALIDA (son cosas distintas y a veces se confunde). Un procedimiento almacenado puede tener m�s de un par�metro de salida pero solo un valor de retorno.****************************************************/USE Northwind
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

/***************************************************C�DIGO DE PRUEBAAlmacenamiento en una variable del valor de retorno de un procedimiento almacenado.Es absolutamente necesario si queremos procesar el valor de retorno.****************************************************/DECLARE @existe_empleado INT
EXEC @existe_empleado = coger_empleado 5
SELECT @existe_empleado
GO