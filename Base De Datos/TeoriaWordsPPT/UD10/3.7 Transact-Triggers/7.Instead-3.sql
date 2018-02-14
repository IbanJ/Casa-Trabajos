/***************************************************
DESENCADENADOR INSTEAD OF
Si una vista se define como una consulta que combina varias tablas,
solo se puede ejecutar una instrucci�n UPDATE para realizar actualizaciones
a trav�s de la vista cuando las modificaciones afectan a columnas de
una sola tabla.

EJEMPLO.
Este trigger sirve para realizar modificaciones a trav�s de vistas definidas
a partir de varias tablas
****************************************************/

USE Northwind
GO

-- Creamos una nueva tabla para almacenar el presupuesto

CREATE TABLE Presupuesto_Categories(
	  CategoryID int NOT NULL
		PRIMARY KEY
		REFERENCES Categories (CategoryID)
	, Presupuesto money NOT NULL
		DEFAULT 0
)
GO
-- A�adimos un presupuesto aleatorio a cada categor�a

INSERT Presupuesto_Categories
SELECT CategoryID
	, ROUND(SIN(CategoryID)* 10000 + 20000, -3)
FROM Categories

GO

-- Creamos una vista para ver el nombre y el presupuesto de cada categor�a

CREATE VIEW NombreYpresupuestoCategorias
AS
	SELECT C.CategoryID
		, C.CategoryName
		, CB.Presupuesto
	FROM Categories C
		JOIN Presupuesto_Categories CB
			ON C.categoryID = CB.categoryID

GO

-- Creamos un trigger INSTEAD OF para actualizar los presupuestos proporcionalmente

CREATE TRIGGER TR_NombreYpresupuestoCategorias
ON NombreYpresupuestoCategorias
INSTEAD OF UPDATE
AS

	-- Actualizamos el nombre de la categor�a
	
	UPDATE C
	SET C.CategoryName = I.CategoryName
	FROM Inserted I
		JOIN Categories C
			ON C.CategoryID = I.CategoryID
	
	-- Actualizamos el presupuesto
	
	UPDATE CB
	SET CB.Presupuesto = I.Presupuesto
	FROM Inserted I
		JOIN Presupuesto_Categories CB
			ON CB.CategoryID = I.CategoryID
	
GO

-- Probamos la vista

PRINT CHAR(10) + 'Nombres y presupuestos antes de la actualizaci�n' + CHAR(10)

SELECT *
FROM NombreYpresupuestoCategorias

-- Cambiamos el nombre y el presupuesto de la categor�a 7

UPDATE NombreYpresupuestoCategorias
SET Presupuesto = 35000.0000
	, CategoryName = 'Miscellaneous'
WHERE CategoryID = 7

-- Probamos la actualizaci�n

PRINT CHAR(10) + 'Nombres y presupuestos despu�s de la actualizaci�n' + CHAR(10)

SELECT *
FROM NombreYpresupuestoCategorias

-- Dejamos la categor�a 7 tal como estaba

UPDATE Categories
SET CategoryName = 'Produce'
WHERE CategoryID = 7

DROP VIEW NombreYpresupuestoCategorias

DROP TABLE Presupuesto_Categories


/* ***********************************************************************************
NOTA:
No se puede crear un trigger INSTEAD OF en una vista definida con la opci�n WITH CHECK
*/ ***********************************************************************************