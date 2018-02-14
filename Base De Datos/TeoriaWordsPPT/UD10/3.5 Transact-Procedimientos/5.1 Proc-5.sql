/***************************************************Creación de un procedimiento almacenado con parámetrosLa cantidad máxima de parámetros es 2.100 (una exageración).Una vez dada la información sobre sus parámetros, ésta queda almacenada en la tabla de sistema syscolumns, la información general en sysobjects y el código en syscomments.****************************************************/USE Northwind
GO

CREATE PROC dbo.CogerApellidosEmpleados
    @empapellido VARCHAR(40)
AS
	SELECT *
	FROM Employees
	WHERE lastname LIKE '%' + @empapellido + '%'
GO

