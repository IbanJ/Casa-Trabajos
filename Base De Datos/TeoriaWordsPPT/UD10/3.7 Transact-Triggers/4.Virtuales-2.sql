/***************************************************
Las tablas INSERTED y DELETED se pueden usar en cualquier lugar.

En este ejemplo podemos examinar las tablas inserted y deleted.
****************************************************/

USE Northwind
GO

-- Creamos una nueva tabla

CREATE TABLE NuevasCategorias (
	  CategoryID int NOT NULL
		IDENTITY(1,1) 
		PRIMARY KEY
	, CategoryName nvarchar(15) NOT NULL 
	, Modificada smalldatetime
		DEFAULT CURRENT_TIMESTAMP
	, Modificador nchar(128)
		DEFAULT SYSTEM_USER
)
GO

--Creamos un trigger AFTER UPDATE

CREATE TRIGGER tr_NuevasCategorias
ON NuevasCategorias
AFTER UPDATE, INSERT, DELETE
AS

	DECLARE @s varchar(80)
	DECLARE @ni int, @nd int

	SELECT @ni = COUNT(*)
	FROM Inserted
	
	SELECT @nd = COUNT(*)
	FROM Deleted
	
	SET @s = CASE
		WHEN (@ni = @nd) AND @ni > 0
			THEN 'Trigger AFTER UPDATE  (compara las tablas Deleted e Inserted)'
		WHEN @ni > @nd
			THEN 'Trigger AFTER INSERT  (mira la tabla Inserted)'
		WHEN @ni < @nd
			THEN 'Trigger AFTER DELETE  (mira la tabla Deleted)'
		ELSE 'TRIGGER lanzado por una acción Null (Inserted y Deleted están vacías)' END
	
	PRINT CHAR(10) + '#######################################################'
	PRINT @s
	PRINT '#######################################################' + CHAR(10)
	
	PRINT CHAR(10) + 'Tabla Inserted' + CHAR(10)
	
	SELECT *
	FROM Inserted
	
	PRINT CHAR(10) + 'Tabla Deleted' + CHAR(10)
	
	SELECT *
	FROM Deleted
GO

-- Operación Insert

INSERT NuevasCategorias (CategoryName)
VALUES ('Food')

-- Múltiples operaciones Insert

INSERT NuevasCategorias (CategoryName)
SELECT CategoryName
FROM Categories

-- Borra una fila

DELETE NuevasCategorias
WHERE CategoryID = 7

-- Borra varias filas

DELETE NuevasCategorias
WHERE CategoryID BETWEEN 1 AND 4

-- Actualiza una fila

UPDATE NuevasCategorias
SET CategoryName = 'Products'
WHERE CategoryID = 8

-- Actualiza varias filas

UPDATE NuevasCategorias
SET CategoryName = UPPER(CategoryName)

-- La operación es nula ya que no devuelve ninguna fila

UPDATE Trigger
SET CategoryName = UPPER(CategoryName)
WHERE CategoryID > 1000

-- Eliminamos la tabla de ejemplo eliminándose
-- automáticamente el trigger

DROP TABLE NuevasCategorias
