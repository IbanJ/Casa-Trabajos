/***************************************************Creaci�n de un procedimiento almacenado con la opci�n WITH ENCRIPTIONSe puede encriptar un procedimiento almacenado con la cl�usula WITH ENCRYPTIONque aplica un cifrado a la definici�n almacenada en syscomments. Nadie podr� leer la definici�n.****************************************************/USE Northwind
GO

CREATE PROC dbo.cogerusuarioactual
WITH ENCRYPTION
AS
SELECT USER
GO

sp_helptext 'cogerusuarioactual'
GO

