/***************************************************
GO

-- Creamos un procedimiento
CREATE PROC dbo.HoraActual
AS
	SELECT CURRENT_TIMESTAMP
GO

-- Consultamos las tablas del sistema a trav�s de dos procedimientos
almacenados del sistema
EXEC sp_help 'HoraActual'
EXEC sp_helptext 'HoraActual'
GO
