/***************************************************
USO DE TRIGGERS PARA MANTENIMIENTOS DE DATOS ORDENADOS
JERÁRQUICAMENTE

EJEMPLO
Imaginemos una tabla en la que guardamos los costos y presupuestos
de un sistema de control de costos de proyectos.
Cada fila en la tabla tiene un identificador único como clave 
principal, pero hace referencia a otra fila como fila madre, excepto
la fila raíz, que representa al propio proyecto.
Cada vez que se cambian los valores en las columnas COSTO o 
PRESUPUESTO en una fila dada, hay que trasladar estos cambios hacia 
arriba, hasta el nivel más alto; los costos solo se introducen en las filas
que no tienen filas hijas.

Veamos el código.
****************************************************/

USE Northwind
GO

-- Create the base table

CREATE TABLE CostBudgetControl (
	  ID int NOT NULL
		PRIMARY KEY
	, Name nvarchar(100) NOT NULL
	, ParentID int NULL
		REFERENCES CostBudgetControl(ID)
	, Cost money NOT NULL 
		DEFAULT 0
	, Budget money NOT NULL 
		DEFAULT 0
	, HasChildren bit 
		DEFAULT 0
)

-- Insert Cost Structure
-- Create a text file (Gas.txt)
-- with the following contents:
/*
1, Gas Pipeline Project, 0, 85601000.0000, 117500000.0000, 1
2, Engineering, 1, 800000.0000, 950000.0000, 1
3, Materials, 1, 23400000.0000, 28000000.0000, 1
4, Construction, 1, 61000000.0000, 88000000.0000, 1
5, Supervision, 1, 401000.0000, 550000.0000, 1
6, Line, 2, 300000.0000, 400000.0000, 0
7, Stations, 2, 500000.0000, 550000.0000, 0
8, Pipes, 3, 14500000.0000, 16000000.0000, 0
9, Machinery, 3, 8900000.0000, 12000000.0000, 0
10, Section A, 4, 31000000.0000, 47000000.0000, 1
11, Section B, 4, 30000000.0000, 41000000.0000, 1
12, Welding, 5, 200000.0000, 250000.0000, 0
13, Civil, 5, 145000.0000, 200000.0000, 0
14, Buildings, 5, 56000.0000, 100000.0000, 0
15, Civil works, 10, 20000000.0000, 30000000.0000, 0
16, Civil works, 11, 18000000.0000, 25000000.0000, 0
17, Pipeline, 10, 11000000.0000, 17000000.0000, 0
18, Pipeline, 11, 12000000.0000, 16000000.0000, 0
*/

BULK INSERT Northwind.dbo.CostBudgetControl
   FROM 'C:\Gas.txt'
   WITH
      (
           FIELDTERMINATOR = ', '
			, ROWTERMINATOR = '\n'
      )
GO

UPDATE CostBudgetControl
SET ParentID = NULL
WHERE ID = 1
GO

-- Create the recursive trigger

CREATE TRIGGER udtCostBudget
ON CostBudgetControl
AFTER UPDATE
AS
	IF @@rowcount>0
		UPDATE CostBudgetControl
		SET Cost = Cost
				+ ISNULL(
					(SELECT SUM(Cost)
					FROM Inserted
					WHERE Inserted.ParentID = CostBudgetControl.ID), 0)
				- ISNULL(
					(SELECT SUM(Cost)
					FROM Deleted
					WHERE Deleted.ParentID = CostBudgetControl.ID), 0)
			, Budget = Budget
				+ ISNULL(
					(SELECT SUM(Budget)
					FROM Inserted
					WHERE Inserted.ParentID = CostBudgetControl.ID), 0)
				- ISNULL(
					(SELECT SUM(Budget)
					FROM Deleted
					WHERE Deleted.ParentID = CostBudgetControl.ID), 0)
		WHERE ID IN
			(SELECT ParentID
			FROM Inserted
			UNION
			SELECT ParentID
			FROM Deleted)
GO

-- Enable Recursive triggers

ALTER DATABASE Northwind
SET RECURSIVE_TRIGGERS ON
GO

-- Total Cost and Budget
-- Before the update

SELECT Cost, Budget
FROM CostBudgetControl
WHERE ID = 1

-- Update some cost

UPDATE CostBudgetControl
SET Cost = 12500000.0000
WHERE ID = 17

-- Total Cost and Budget
-- After the update

SELECT Cost, Budget
FROM CostBudgetControl
WHERE ID = 1

GO

DROP TABLE CostBudgetControl
