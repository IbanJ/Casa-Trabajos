-- Consulta para detectar usuarios huérfanos.
USE AdventureWorks2014
GO
sp_change_users_login @Action='Report';


/* 
Asignamos al usuario denominado us_prueba un inicio de sesión
denominado  "prueba" 
*/
USE AdventureWorks2014
GO
sp_change_users_login @Action='update_one', @UserNamePattern='usu_prueba', 
   @LoginName='prueba';
GO

-- Eliminamos el inicio de sesión prueba
use master
go
drop login prueba

-- Consultamos para detectar usuarios huérfanos
USE AdventureWorks2014
GO
sp_change_users_login @Action='Report';

/* 
Asignamos al usuario huérfano "usu_prueba"
otra cuenta de inicio de sesión denominada "Juan"
*/
USE AdventureWorks2014
GO
sp_change_users_login @Action='update_one', @UserNamePattern='prueba', 
   @LoginName='Izquierda';
GO
