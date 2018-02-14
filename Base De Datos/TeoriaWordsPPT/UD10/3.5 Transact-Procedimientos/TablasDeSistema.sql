/***************************************************Creación de un procedimiento almacenado y lectura de sus propiedadesy de su código.Cuando se crea un procedimiento almacenado sus propiedades quedan almacenadas en sysobjectsy su definición en syscomments.Se pueden mostrar sus propiedades y su código mediantes sendos procedimientos almacenados de sistema como vemos en el ejemplo.****************************************************/USE AdventureWorks
GO

-- Creamos un procedimiento
CREATE PROC dbo.HoraActual
AS
	SELECT CURRENT_TIMESTAMP
GO

-- Consultamos las tablas del sistema a través de dos procedimientos
almacenados del sistema
EXEC sp_help 'HoraActual'
EXEC sp_helptext 'HoraActual'
GO

