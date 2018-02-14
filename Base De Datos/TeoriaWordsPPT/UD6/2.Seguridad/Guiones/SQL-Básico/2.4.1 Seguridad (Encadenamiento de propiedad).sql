-- El encadenamiento de pertenencia a través de las bases de datos es usado para permitir
-- el acceso a los recursos de distintas bases de datos sin conceder acceso de forma explícita a
-- los usuarios de la BD de producción o a sus tablas.

-- Para que esto sea posible, debemos activar la configuración en la instancia:

/* ****************************  OPERACIONES A NIVEL SERVIDOR  ***************************************** */
sp_configure 'cross db ownership chaining', 1
GO
RECONFIGURE
GO

-- Creamos dos Bases de Datos
CREATE DATABASE DatosComerciales
WITH DB_CHAINING ON
CREATE DATABASE DatosPersonales
WITH DB_CHAINING ON
GO

-- Creamos un inicio de sesión de SQL Server
CREATE LOGIN [Nere] WITH PASSWORD=N'contrasena', 
 DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO


/* ****************************  OPERACIONES EN LA BASE DE DATOS DatosComerciales  ***************************************** */
-- Creamos una tabla "Clientes" en la Base de Datos "DatosComerciales"
USE DatosComerciales
CREATE TABLE Clientes
(
CustomerID int IDENTITY PRIMARY KEY,
FirstName nvarchar(255) NOT NULL,
LastName nvarchar(255) NOT NULL,
Email varchar(255) NOT NULL
);
INSERT INTO Clientes VALUES ('ana', 'zabala', 'ana.zabala@salgo.com');
INSERT INTO Clientes VALUES ('adelaida', 'Mendia', 'adelaida.Mendia@salgo.com');
GO

-- Creamos el usuario "Nere" asociado a la cuenta de inicio de sesión "Nere"
CREATE USER Nere FOR LOGIN Nere;
GO

/* ****************************  OPERACIONES EN LA BASE DE DATOS DatosPersonales  ***************************************** */
-- Creamos una tabla "DireccionesEmail" en la Base de Datos "DatosPersonales"
USE DatosPersonales
CREATE TABLE DireccionesEmail
(
ContactID int IDENTITY PRIMARY KEY,
Email varchar(255) NOT NULL
);
INSERT INTO DireccionesEmail VALUES('toma@domi.com');
INSERT INTO DireccionesEmail VALUES('daca@domine.com');
GO

-- Creamos la vista "v_CogerTodosEmails"
CREATE VIEW v_CogerTodosEmails
AS
	SELECT Email FROM DireccionesEmail
	UNION
	SELECT Email FROM DatosComerciales.dbo.Clientes;
GO

-- Creamos el usuario "Nere" asociado a la cuenta de inicio de sesión "Nere"
CREATE USER Nere FOR LOGIN Nere;

-- Le concedemos el permiso de lectura al usuario "Nere" sobre la vista
GRANT SELECT ON v_CogerTodosEmails TO Nere;
GO

-- Consultamos como usuario "Nere"
SETUSER 'Nere'
SELECT * FROM v_CogerTodosEmails
SETUSER