-- Transferimos la propiedad de la base de datos
-- BD_Aritz (antes pertenec�a a egela\aritzmurua)
-- al inicio de sesi�n sa
ALTER AUTHORIZATION ON DATABASE::BD_ARITZ TO SA;
GO

/*
   Podemos transferir la propiedad a inicios de sesi�n basados en cuentas.
   No valen roles, grupos o inicios de sesi�n basados en certificados.
*/
ALTER AUTHORIZATION ON DATABASE::BD_Jesus TO "EGELA\jesusseco";
go


/*
   Ejemplo de transferencia de una tabla
*/
USE BD_�lvaroVargas
go
ALTER AUTHORIZATION ON OBJECT::dbo.clientes TO Itsaso;
GO

