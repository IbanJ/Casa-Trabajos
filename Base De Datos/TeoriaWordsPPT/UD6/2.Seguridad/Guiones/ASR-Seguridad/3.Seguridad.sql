-- Transferimos la propiedad de la base de datos
-- BD_Aritz (antes pertenecía a egela\aritzmurua)
-- al inicio de sesión sa
ALTER AUTHORIZATION ON DATABASE::BD_ARITZ TO SA;
GO

/*
   Podemos transferir la propiedad a inicios de sesión basados en cuentas.
   No valen roles, grupos o inicios de sesión basados en certificados.
*/
ALTER AUTHORIZATION ON DATABASE::BD_Jesus TO "EGELA\jesusseco";
go


/*
   Ejemplo de transferencia de una tabla
*/
USE BD_ÁlvaroVargas
go
ALTER AUTHORIZATION ON OBJECT::dbo.clientes TO Itsaso;
GO

