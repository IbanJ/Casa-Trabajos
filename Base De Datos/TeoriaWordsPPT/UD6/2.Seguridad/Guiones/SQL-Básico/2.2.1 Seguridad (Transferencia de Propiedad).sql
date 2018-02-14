-- Transferimos la propiedad de la base de datos
-- BD_Aritz (antes pertenec�a al usuario egela\aritz)
-- al inicio de sesi�n sa
USE AdventureWorks
go
ALTER AUTHORIZATION ON DATABASE::BD_ARITZ TO sa;
GO

/*
   Podemos transferir la propiedad a inicios de sesi�n basados en cuentas.
   No vale hacerlo con roles, grupos o inicios de sesi�n 
   basados en certificados.
*/
USE AdventureWorks
go
ALTER AUTHORIZATION ON DATABASE::BD_Jesus TO "EGELA\jesus";
go


/*
   Ejemplo de transferencia de propiedad de una tabla a otro usuario
*/
USE AdventureWorks
go
ALTER AUTHORIZATION ON OBJECT::Sales.Store TO Itsaso;
GO

