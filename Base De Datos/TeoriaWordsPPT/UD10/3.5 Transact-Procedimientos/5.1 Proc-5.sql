/***************************************************
GO

CREATE PROC dbo.CogerApellidosEmpleados
    @empapellido VARCHAR(40)
AS
	SELECT *
	FROM Employees
	WHERE lastname LIKE '%' + @empapellido + '%'
GO
