-- Vista de las cuentas de inicio de sesión 
-- que pertenecen a un rol con nivel de servidor
select rol.* , prin.* from sys.server_role_members as rol
join sys.server_principals as prin
on rol.member_principal_id = prin.principal_id
ORDER BY prin.type

