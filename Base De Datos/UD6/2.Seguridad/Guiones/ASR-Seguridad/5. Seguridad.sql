-- Vista de las cuentas de inicio de sesión con un rol a nivel de servidor
select * from sys.server_role_members as rol
join sys.server_principals as prin
on rol.member_principal_id = prin.principal_id
