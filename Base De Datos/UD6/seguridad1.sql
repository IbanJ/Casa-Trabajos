/*
   TODO COMENZÓ CON ESTA ORDEN

  ***** DROP LOGIN 'SEGUNDO\ASIR-1' ****
  Se eliminó el login y todas las cuentas de windows 
  pertenecientes al grupo de windows ASIR-1 dejaron
  de poder entrar al MOTOR primero100\primero.

  Dado que son creadores de BD's, crearon al inicio 
  del curso su propia base de datos, de la cuál eran
  y son propietarios con su cuenta de Windows individual.

  Por ese motivo, siguen figurando como propietarios
  de su base de datos, pero no pueden acceder al MOTOR.

  En realidad, el LOGIN se pudo eliminar, dado que NO ERA 
  PROPIETARIO DE NADA.

  El problema es que queremos recrear el login ejecutando
  el mandato
	***** CREATE LOGIN 'SEGUNDO\ASIR-1' ****
  y nos dice que el login ya existe. Sin embargo, consultamos 
  sys.logins y el nodo logins en el explorador de SSMS 
  y no está.
*/

/* ***************************************************
   *********************   SOLUCIÓN   ****************
   *************************************************** */
-- Comprobamos que existe el login en la tabla 
-- sys.server_principals.
-- Si existe lo eliminamos
IF EXISTS (SELECT * FROM sys.server_principals 
           WHERE name = N'segundo\asir-1') 
	DROP LOGIN [segundo\asir-1]

-- Comprobamos que lo ha hecho
SELECT * 
FROM sys.server_principals 
WHERE name = N'segundo\asir-1'

-- CREAMOS EL LOGIN
USE [master]
GO
CREATE LOGIN [SEGUNDO\ASIR-1] FROM WINDOWS 
WITH DEFAULT_DATABASE=[master]
GO
ALTER SERVER ROLE [dbcreator] ADD MEMBER [SEGUNDO\ASIR-1]
GO

/* ***************************************************
   **************  Otras operaciones  ****************
   *************************************************** */

-- Listado de todas las bases de datos con sus propietarios
SELECT name, suser_sname(owner_sid) AS DBOwner 
FROM sys.databases

-- Cambio de propietario de una base de datos
use ASIR_AitorGonzalez 
GO
ALTER AUTHORIZATION ON database::[ASIR_aitorGonzalez] 
       TO [segundo\AitorGonzalez]

-- cambiar de propietario de un esquema de una base de datos
USE ASIR_AitorGonzalez 
GO
ALTER AUTHORIZATION ON SCHEMA::[cine] TO [db_accessadmin]
GO

-- Eliminacion de un usuario propietario de un esquema
-- que contiene uno o varios objetos (imaginemos tablas).
-- Paso	1 (asignamos la propiedad del objeto(s) a otro usuario)
	 sp_changeobjectowner 'cine.actores','dbo' -- OBSOLETO
   -- Continuaríamos haciéndolo con el resto de tablas
   -- contenidas en el esquema.

-- Paso	2 (eliminamos el esquema)
     drop schema cine

-- Paso 3 Eliminamos el usuario
     drop user usuario

