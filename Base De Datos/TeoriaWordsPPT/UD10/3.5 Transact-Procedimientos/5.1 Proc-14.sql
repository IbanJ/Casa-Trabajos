/***************************************************Transact nos da dos elementos que permiten controlar y generar erroresdesde el programa. Estos elementos son	- @@ERROR: es una función niládica que devuelve un código de error			   (distinto de 0) correspondiente a la última instrucción ejecutada. 			   En el caso de que se haya ejecutado sin errores devuelve 0.			   Este valor cambia con cada instrucción.	- RAISERROR: se usa para generar un error de forma explícita.				  Se puede usar un mensaje ad hoc o un mensaje almacenado en la				  tabla de sistema sysmessages (tabla que contiene todos los				  errores del motor).				  Se pueden añadir mensajes particulares a esta tabla mediante				  el procedimiento almacenado del sistema sp_addmessage y eliminarlos				  mediante sp_dropmessage.				  Al añadir un mensaje, el código de mensaje debe ser mayor o igual				  que 50001.				  Primer parámetro: si es el identificador, se debe haber creado previamente el 				                    mensaje.				  Segundo parámetro: el nivel de gravedad del error. Es un número entre 0 y 25.									 El uso de niveles de gravedad mayores que 18 solo es para									 los administradores de sistema (para errores críticos).									 Si está entre 0 y 10 es un mensaje informativo.									 Entre 10 y 19 para errores capturables.									 Entre 20 y 25 errores críticos (que son los que cierran la conexión).				  Tercer parámetro: es el estado del error. un número entero entre 0 y 127.									No tiene importancia.				  Cuarto parámetro: Existen dos opciones:						LOG: guarda la informaciónrelativa al error en el registro de errores de SQL Server 							 y en el registro de aplicación de  Windows NT. 							 Cuando se usan niveles de gravedad a partir de 19 hay que indicar esta opción.						NOWAIT: se envía el mensaje a la aplicación de forma inmediata.								  Después de ejecutar RAISERROR, la función @@ERROR devuelve el valor del identificador				  del mensaje de error o 50000 cuando se usa un mensaje ad hoc.****************************************************/-- EJEMPLO:USE Northwind
GO

-- Agregamos el mensaje para inglés estadounidense
-- De lo contrario, el proceso fallaría
sp_addmessage 50001,11,'An error occurred', 'us_english'
GO
-- Agregamos el mensaje en español
sp_addmessage 50001,11,'Ha habido un error', 'spanish'
GO

-- Creamos un procedimiento almacenado
CREATE PROC genera_error
AS
BEGIN
	RAISERROR (50001,11,1) WITH LOG
	SELECT @@ERROR
END

-- Llamamos al procedimiento para probarlo
genera_error
GO