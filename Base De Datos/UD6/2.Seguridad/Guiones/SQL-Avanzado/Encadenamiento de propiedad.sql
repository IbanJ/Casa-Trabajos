-- El encadenamiento de pertenencia a través de las bases de datos es usado para permitir
-- el acceso a los recursos de distintas bases de datos sin conceder acceso de forma explícita a
-- los usuarios de la BD de producción o a sus tablas.

-- Para que esto sea posible, debemos activar la configuración en la instancia:
sp_configure 'cross db ownership chaining', 1
GO
RECONFIGURE
GO


CREATE DATABASE DatosComerciales
WITH DB_CHAINING ON
CREATE DATABASE datosPersonales
WITH DB_CHAINING ON
GO

CREATE LOGIN Nere WITH PASSWORD = 'contrasena';

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

CREATE USER Nere FOR LOGIN Nere;
GO



USE datosPersonales
CREATE TABLE DireccionesEmail
(
ContactID int IDENTITY PRIMARY KEY,
Email varchar(255) NOT NULL
);
INSERT INTO DireccionesEmail VALUES('toma@domi.com');
INSERT INTO DireccionesEmail VALUES('daca@domine.com');
GO

CREATE VIEW v_CogerTodosEmails
AS
	SELECT Email FROM DireccionesEmail
	UNION
	SELECT Email FROM DatosComerciales.dbo.Clientes;
GO

CREATE USER Nere FOR LOGIN Nere;
GRANT SELECT ON v_CogerTodosEmails TO Nere;
GO
SETUSER 'Nere'
SELECT * FROM v_CogerTodosEmails
SETUSER