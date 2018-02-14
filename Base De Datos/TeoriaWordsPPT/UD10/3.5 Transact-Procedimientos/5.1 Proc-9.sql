/***************************************************Creación de un procedimiento almacenado con parámetros predeterminados.Se puede hacer que existan valores predeterminados e incluso que dichovalor predeterminado sean NULL.La aplicación que llama a un procedimiento de estas caracterísiticas puede no enviar el parámetro(s) correspondiente(s).****************************************************/USE Northwind
GO

CREATE PROC dbo.cogerapellidoempleado_default
     @empapellido VARCHAR(40) = 'a'
AS
	SELECT *
	FROM Employees
	WHERE lastname LIKE '%' + @empapellido + '%'
GO

