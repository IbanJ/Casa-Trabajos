/*
	El objetivo de este codigo es crear
	objeto en la base de datos (Schema Collection)
	que contenga el contenido archivo xsd
*/

-- 1. Declaramos una variable (memoria RAM del
--    servidor de datos) en la que vamos a 
--    almacenar el contenido del archivo .xsd
--    en formato binario
DECLARE @x XML

-- 2. En este paso, transformamos el contenido
--	  del archivo .xsd a formato binario, dejandolo
--	  en la variable @x
SELECT @x = s
FROM OPENROWSET (
BULK 'D:\ASIR\TRABAJOS\IbánJuarros\Marcas\XML\Enfermedades_XSD.xsd',SINGLE_BLOB) 
	AS TEMP(s)
-- BULK es un comando de cargas masivas, 
-- para poder ejecutar este tipo de mandatos debes pertenecer al server role BULKADMIN.

-- select @x -- para testeo

-- Este mandato DDL crea en la base de datos el objeto
-- que contendra el contenido del XSD en formato binario
CREATE XML SCHEMA COLLECTION SCH_Enfermedades AS @x
-- El objeto creado se ubica dentro de la Base de Datos
-- en Programability --> Types --> XML Schema Collections


