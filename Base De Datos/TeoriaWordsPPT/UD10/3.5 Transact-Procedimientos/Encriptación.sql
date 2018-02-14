/***************************************************Creación de un procedimiento almacenado con la opción WITH ENCRIPTIONSe puede encriptar un procedimiento almacenado con la cláusula WITH ENCRYPTIONque aplica un cifrado a la definición almacenada en syscomments. Nadie podrá leer la definición.****************************************************/USE Northwind
GO

CREATE PROC dbo.cogerusuarioactual
WITH ENCRYPTION
AS
SELECT USER
GO

sp_helptext 'cogerusuarioactual'
GO

