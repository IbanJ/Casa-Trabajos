/***************************************************Creaci�n de un procedimiento almacenado con par�metrosLa cantidad m�xima de par�metros es 2.100 (una exageraci�n).Una vez dada la informaci�n sobre sus par�metros, �sta queda almacenada en la tabla de sistema syscolumns, la informaci�n general en sysobjects y el c�digo en syscomments.****************************************************/USE Northwind
GO

CREATE PROC dbo.CogerApellidosEmpleados
    @empapellido VARCHAR(40)
AS
	SELECT *
	FROM Employees
	WHERE lastname LIKE '%' + @empapellido + '%'
GO

