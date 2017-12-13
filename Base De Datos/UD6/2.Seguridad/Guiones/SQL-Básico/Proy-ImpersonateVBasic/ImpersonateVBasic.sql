USE [master]
GO


/****** Object:  StoredProcedure [dbo].[impersonal_VBasic]    Script Date: 04/08/2011 18:29:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter procedure [dbo].impersonalVBasic
     @iniciosesion as varchar(20),
     @contrasena as varchar(20)
as
begin
    declare @consulta as varchar(1000)
    
	-- Pepe asumirá temporalmente el contexto de ejecución de [DIRECCION\Ignacio]
	EXECUTE AS LOGIN = 'Kevin'
    
	-- pepe crea el nuevo login
	set @consulta = N'CREATE LOGIN ' + Ltrim(rtrim((@iniciosesion))) + 
	        ' WITH PASSWORD = ' + '''' + LTRIM(rtrim((@contrasena)) + '''' + 
	         ', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF')
	print @consulta
    exec (@consulta)
	-- Revierte el anterior contexto de ejecución.
	REVERT;
end

grant execute on dbo.impersonalVBasic to pepe