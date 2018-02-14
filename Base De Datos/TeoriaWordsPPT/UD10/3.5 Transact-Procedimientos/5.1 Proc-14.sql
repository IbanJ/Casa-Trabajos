/***************************************************
GO

-- Agregamos el mensaje para ingl�s estadounidense
-- De lo contrario, el proceso fallar�a
sp_addmessage 50001,11,'An error occurred', 'us_english'
GO
-- Agregamos el mensaje en espa�ol
sp_addmessage 50001,11,'Ha habido un error', 'spanish'
GO

-- Creamos un procedimiento almacenado
CREATE PROC genera_error
AS
BEGIN
	RAISERROR (50001,11,1) WITH LOG
	SELECT @@ERROR
END

-- Llamamos al procedimiento para probarlo
genera_error
GO