USE [master]
GO
/****** Object:  StoredProcedure [dbo].[impersonal_VBasic]    Script Date: 04/08/2011 18:21:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure impersonal_VBasic
     @iniciosesion as varchar(20),
     @contrasena as varchar(20)
as
begin
    declare @consulta as varchar(1000)
	-- Pepe asumirá temporalmente el contexto de ejecución de [DIRECCION\Ignacio]
	EXECUTE AS LOGIN = 'Kevin';

	-- pepe crea el nuevo login
	set @consulta = N'CREATE LOGIN @iniciosesion WITH PASSWORD = @contrasena'
    exec (@consulta)
	-- Revierte el anterior contexto de ejecución.
	REVERT;
end