-- Esta consulta nos entrega información de los 
-- "Principales" (Usuarios/Roles) de la base
-- de datos AdventureWorks.
-- Primero salen los usuarios y a continuación los roles
select principales.name, principales.uid from sys.sysusers as principales

ORDER BY principales.uid

-- Esta consulta nos entrega información de los roles actualmente
-- asignados a usuarios u otros roles de AdventureWorks
select prin.name as NombreRol,prin.type_desc as DescripcionRol,usu.name as NombreUsuario
FROM sys.database_role_members roles
join   sys.database_principals prin
on roles.role_principal_id = prin.principal_id
join sys.sysusers as usu
on roles.member_principal_id = usu.uid
ORDER BY NombreUsuario