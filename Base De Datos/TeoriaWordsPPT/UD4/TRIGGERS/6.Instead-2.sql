/***************************************************
DESENCADENADOR INSTEAD OF
Las vistas basadas en funciones de agregación son de solo lectura
Los desencadenadores INSTEAD OF resuelven este problema.

EJEMPLO.
Este trigger sirve para distribuir cambios realizados en un resumen.
Creamos un trigger sobre la vista resumen que acepte los cambios realizados
al presupuesto total y los distribuya proporcionalmente a cada no de 
los presupuestos individuales.
****************************************************/

USE Northwind
GO

-- Modificamos la tabla Categories para añadir una nueva columna
-- para almacenar el valor presupuestado

ALTER TABLE Categories
ADD Presupuesto money NULL
GO
-- Añadimos un presupuesto aleatorio a cada categoría

UPDATE Categories
SET Presupuesto = ROUND(SIN(CategoryID)* 10000 + 20000, -3)
GO

-- Creamos una vista para el presupuesto total

CREATE VIEW TotalPresupuestado
AS
	SELECT SUM(Presupuesto) AS PTotal
	FROM Categories
GO

-- Creamos un trigger INSTEAD OF para actualizar los presupuestos
-- en una forma proporcional

CREATE TRIGGER Tr_TotalPresupuestado
ON TotalPresupuestado
INSTEAD OF UPDATE
AS

	-- Repartimos proporcionalmente el nuevo presupuesto

	UPDATE Categories
	SET Presupuesto = ROUND(Presupuesto *
			(Inserted.PTotal /
			Deleted.PTotal), -3)
	FROM Inserted, Deleted
	
	-- Ajustamos la diferencia, sumándosela al mayor presupuesto
	
	UPDATE Categories
	SET Presupuesto = Presupuesto +
			Inserted.PTotal -
			(SELECT SUM(Presupuesto)
			FROM Categories)
	FROM Inserted
	WHERE Presupuesto =
		(SELECT MAX(Presupuesto)
		FROM categories)
	
GO

-- Probamos la vista

PRINT CHAR(10) + 'Total presupuestado antes de la actualización' + CHAR(10)

SELECT *
FROM TotalPresupuestado

PRINT CHAR(10) + 'Presupuestos individuales antes de la actualización' + CHAR(10)

SELECT CategoryID, Presupuesto
FROM Categories

-- Aumentamos el presupuesto

UPDATE TotalPresupuestado
SET PTotal = 200000

-- Probamos la actualización

PRINT CHAR(10) + 'Total presupuestado después de la actualización' + CHAR(10)

SELECT *
FROM TotalPresupuestado

PRINT CHAR(10) + 'Presupuestos individuales después de la actualización' + CHAR(10)

SELECT CategoryID, Presupuesto
FROM Categories

-- Eliminamos la vista y la columna Presupuesto

DROP VIEW TotalPresupuestado

ALTER TABLE Categories
DROP COLUMN Presupuesto
