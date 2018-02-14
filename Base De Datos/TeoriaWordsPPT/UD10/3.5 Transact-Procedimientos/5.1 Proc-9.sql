/***************************************************Creaci�n de un procedimiento almacenado con par�metros predeterminados.Se puede hacer que existan valores predeterminados e incluso que dichovalor predeterminado sean NULL.La aplicaci�n que llama a un procedimiento de estas caracter�siticas puede no enviar el par�metro(s) correspondiente(s).****************************************************/USE Northwind
GO

CREATE PROC dbo.cogerapellidoempleado_default
     @empapellido VARCHAR(40) = 'a'
AS
	SELECT *
	FROM Employees
	WHERE lastname LIKE '%' + @empapellido + '%'
GO

