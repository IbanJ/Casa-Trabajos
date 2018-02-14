/***************************************************
DIFERENTES TIPOS DE LLAMADAS A LAS FUNCIONES
CREADAS EN LOS GUIONES ANTERIORES
****************************************************/

USE AdventureWorks
GO

/* *************************************************
   Uso de la función Quien()
***************************************************/
-- dbo.Quien
SELECT dbo.Quien() AS [Quién y de dónde]
GO

-- Creación de una tabla que usa "Quien" como una restricción DEFAULT 
IF OBJECT_ID('TestQuien') IS NOT NULL
	DROP TABLE TestQuien
GO

CREATE TABLE TestQuien(
		  ID int IDENTITY (1,1)
			PRIMARY KEY
		, Nombre nvarchar(40)
		, QuienDonde nvarchar(256) 
			DEFAULT dbo.Quien()
		)
GO

INSERT INTO TestQuien (Nombre) VALUES ('Nuevo registro')

SELECT * FROM TestQuien
GO

-- Creamos un trigger para saber quién y desde dónde se hace un cambio
CREATE TRIGGER trQuien
ON TestQuien
AFTER INSERT, UPDATE
AS
    UPDATE TestQuien
    SET QuienDonde = dbo.Quien()
    FROM TestQuien T
    	JOIN Inserted I
    		ON T.ID = I.ID
GO

-- Probamos la funcionalidad del trigger
INSERT INTO TestQuien (Nombre, QuienDonde)
    VALUES ('Más registros', 'Nadie de ningún sitio')

-- Coprobamos que lo ha hecho
SELECT * FROM TestQuien

/* *************************************************
   Uso de la función ValorFuturo()
***************************************************/
-- dbo.ValorFuturo
SELECT 0.05 AS Interes
	, 48 AS NPagos
	, 1000 AS Pago
	, 10000 AS Vactual
	, 0 AS Tipo
	, dbo.ValorFuturo(0.05, 48, 1000, 10000, 0) AS FV

