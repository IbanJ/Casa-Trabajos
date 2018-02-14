-- Creación de una clave maestra en la BD AdventureWorks
USE AdventureWorks;
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'seim';

-- Creación del certificado
USE AdventureWorks; 
CREATE CERTIFICATE certificado WITH SUBJECT = 'DIRECCION\ignacio',
 EXPIRY_DATE = '31/12/2011'; 
GO 
CREATE CERTIFICATE certificado_2 WITH SUBJECT = 'patata',
 EXPIRY_DATE = '31/12/2011'; 
GO 


-- Creación de una clave maestra en la BD master
USE Master;
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'seim';

-- Creación del certificado
USE master; 
CREATE CERTIFICATE certificadomaster WITH SUBJECT = 'DIRECCION\ignacio',
 EXPIRY_DATE = '31/12/2011'; 
GO 
use master
-- crear un login basado en el certificado
CREATE LOGIN usuario_certificado FROM CERTIFICATE certificadomaster;
 GO
 
-- Creamos un usuario basado en un certificado
USE [AdventureWorks]
GO
CREATE USER [usua_certificadomaster] FOR LOGIN [usuario_certificado]
GO