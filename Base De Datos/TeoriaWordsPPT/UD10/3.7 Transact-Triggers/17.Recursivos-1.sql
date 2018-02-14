/***************************************************
TRIGGERS RECURSIVOS
Existen dos tipos de recursividad:
	1. Recursividad indirecta: una sola instrucción obliga a la ejecución
	   repetida del mismo trigger mediante la ejecución de otros triggers.
	   Por ejemplo, si un trigger sobre Products, el trigger definido para
	   esta última tabla volverá a activarse.
	2. Recursividad directa: una tabla base tiene un trigger que vuelve a 
	   modificar algunos datos en la tabla. En este caso, La configuración
	   predetermianda de SQL Server hace que no vuelva a activar el trigger,
	   evitando con ello la recursividad directa.

Para evitar la recursividad de los triggers se debe configurar la opción
'recursive triggers' en 'true' a nivel de base de datos mediante el procedimiento
almacenado de sistema sp_dboption o indicar la opción RECURSIVE_TRIGGERS ON en
la instrucción ALTER DATABASE.

HABILITACIÓN DE TRIGGERS RECURSIVOS
****************************************************/

-- Enable Recursive triggers in Northwind

EXEC sp_dboption 'Northwind', 'recursive triggers', 'true'

-- Disable Recursive triggers in Northwind

ALTER DATABASE Northwind
SET RECURSIVE_TRIGGERS OFF
