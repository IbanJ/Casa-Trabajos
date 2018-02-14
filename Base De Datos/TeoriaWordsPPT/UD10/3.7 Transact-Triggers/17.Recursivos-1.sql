/***************************************************
TRIGGERS RECURSIVOS
Existen dos tipos de recursividad:
	1. Recursividad indirecta: una sola instrucci�n obliga a la ejecuci�n
	   repetida del mismo trigger mediante la ejecuci�n de otros triggers.
	   Por ejemplo, si un trigger sobre Products, el trigger definido para
	   esta �ltima tabla volver� a activarse.
	2. Recursividad directa: una tabla base tiene un trigger que vuelve a 
	   modificar algunos datos en la tabla. En este caso, La configuraci�n
	   predetermianda de SQL Server hace que no vuelva a activar el trigger,
	   evitando con ello la recursividad directa.

Para evitar la recursividad de los triggers se debe configurar la opci�n
'recursive triggers' en 'true' a nivel de base de datos mediante el procedimiento
almacenado de sistema sp_dboption o indicar la opci�n RECURSIVE_TRIGGERS ON en
la instrucci�n ALTER DATABASE.

HABILITACI�N DE TRIGGERS RECURSIVOS
****************************************************/

-- Enable Recursive triggers in Northwind

EXEC sp_dboption 'Northwind', 'recursive triggers', 'true'

-- Disable Recursive triggers in Northwind

ALTER DATABASE Northwind
SET RECURSIVE_TRIGGERS OFF
