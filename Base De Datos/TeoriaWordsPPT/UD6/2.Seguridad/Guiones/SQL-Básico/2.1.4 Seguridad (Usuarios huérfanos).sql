-- Consulta para detectar usuarios hu�rfanos.
USE AdventureWorks2014
GO
sp_change_users_login @Action='Report';


/* 
Asignamos al usuario denominado us_prueba un inicio de sesi�n
denominado  "prueba" 
*/
USE AdventureWorks2014
GO
sp_change_users_login @Action='update_one', @UserNamePattern='usu_prueba', 
   @LoginName='prueba';
GO

-- Eliminamos el inicio de sesi�n prueba
use master
go
drop login prueba

-- Consultamos para detectar usuarios hu�rfanos
USE AdventureWorks2014
GO
sp_change_users_login @Action='Report';

/* 
Asignamos al usuario hu�rfano "usu_prueba"
otra cuenta de inicio de sesi�n denominada "Juan"
*/
USE AdventureWorks2014
GO
sp_change_users_login @Action='update_one', @UserNamePattern='prueba', 
   @LoginName='Izquierda';
GO
