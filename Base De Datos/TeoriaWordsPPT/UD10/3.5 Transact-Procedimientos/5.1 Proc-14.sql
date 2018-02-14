/***************************************************Transact nos da dos elementos que permiten controlar y generar erroresdesde el programa. Estos elementos son	- @@ERROR: es una funci�n nil�dica que devuelve un c�digo de error			   (distinto de 0) correspondiente a la �ltima instrucci�n ejecutada. 			   En el caso de que se haya ejecutado sin errores devuelve 0.			   Este valor cambia con cada instrucci�n.	- RAISERROR: se usa para generar un error de forma expl�cita.				  Se puede usar un mensaje ad hoc o un mensaje almacenado en la				  tabla de sistema sysmessages (tabla que contiene todos los				  errores del motor).				  Se pueden a�adir mensajes particulares a esta tabla mediante				  el procedimiento almacenado del sistema sp_addmessage y eliminarlos				  mediante sp_dropmessage.				  Al a�adir un mensaje, el c�digo de mensaje debe ser mayor o igual				  que 50001.				  Primer par�metro: si es el identificador, se debe haber creado previamente el 				                    mensaje.				  Segundo par�metro: el nivel de gravedad del error. Es un n�mero entre 0 y 25.									 El uso de niveles de gravedad mayores que 18 solo es para									 los administradores de sistema (para errores cr�ticos).									 Si est� entre 0 y 10 es un mensaje informativo.									 Entre 10 y 19 para errores capturables.									 Entre 20 y 25 errores cr�ticos (que son los que cierran la conexi�n).				  Tercer par�metro: es el estado del error. un n�mero entero entre 0 y 127.									No tiene importancia.				  Cuarto par�metro: Existen dos opciones:						LOG: guarda la informaci�nrelativa al error en el registro de errores de SQL Server 							 y en el registro de aplicaci�n de  Windows NT. 							 Cuando se usan niveles de gravedad a partir de 19 hay que indicar esta opci�n.						NOWAIT: se env�a el mensaje a la aplicaci�n de forma inmediata.								  Despu�s de ejecutar RAISERROR, la funci�n @@ERROR devuelve el valor del identificador				  del mensaje de error o 50000 cuando se usa un mensaje ad hoc.****************************************************/-- EJEMPLO:USE Northwind
GO

-- Agregamos el mensaje para ingl�s estadounidense
-- De lo contrario, el proceso fallar�a
sp_addmessage 50001,11,'An error occurred', 'us_english'
GO
-- Agregamos el mensaje en espa�ol
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