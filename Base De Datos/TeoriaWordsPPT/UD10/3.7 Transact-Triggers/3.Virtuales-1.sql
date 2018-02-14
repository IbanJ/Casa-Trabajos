/***************************************************
TABLAS INSERTED Y DELETED

Podemos modificar las filas afectadas  por una orden de actualizaci�n
dentro de un trigger.
Podemos controlar los valores de las columnas (en las filas afectadas)
antes y despu�s de la acci�n, mediante la lectura de dos tablas 
virtuales: INSERTED y DELETED. Son tablas virtuales almacenadas en memoria 
y de solo lectura, con las mismas columnas que la tablas base.
INSERTED contiene los valores de las nuevas filas que se han insertado o
modificado como consecuencia de una INSERT o una UPDATE. En el caso de una
orden DELETE esta tabla est� vac�a.
DELETED contiene los valores de las filas eliminadas por una acci�n DELETE
o los valores antiguos de las filas modificadas por una orden UPDATE. En el
caso de una INSERT la tabla DELETED existe pero est� vac�a.
Si la acci�n original modific� varias filas a la vez, el trigger se activar�
sola una vez y las tablas INSERTED y DELETED contendr�n varias filas con
las modificaciones.
Dentro de un trigger se puede volver a modificar la tabla base. En este 
caso, para volver a modificar s�lo las filas afectadas se puede combinar
la tabla base con la tabla INSERTED.


EJEMPLO: Modificar las filas afectadas dentro de un trigger
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

-- Cargamos la tabla con los datos de la tabla Categories

INSERT NuevasCategorias
(CategoryName)
SELECT CategoryName
FROM Categories
GO

-- Creamos un trigger AFTER UPDATE

CREATE TRIGGER Act_NuevasCategorias
ON NuevasCategorias
AFTER UPDATE
AS
	UPDATE NuevasCategorias
	SET Modificada = CURRENT_TIMESTAMP
		, Modificador = SYSTEM_USER
	FROM NuevasCategorias
		JOIN Inserted
			ON Inserted.CategoryID = NuevasCategorias.CategoryID	
GO

-- Mostramos los valores actuales

SELECT *
FROM NuevasCategorias
WHERE CategoryID = 3
GO

PRINT CHAR(10) + 'Esperamos 30 segundos' + CHAR(10)
GO

WAITFOR DELAY '00:00:30'

-- Hacemos que el usuario wbenata tenga permisos para modificar
-- y leer la tabla NuevasCategorias

GRANT ALL ON NuevasCategorias TO wbenata
GO

-- Vamos a asumir la identidad del usuario wbenata

SETUSER 'wbenata'
GO

-- Modificamos el nombre de la categor�a 3

UPDATE NuevasCategorias
SET CategoryName = 'Confecciones'
WHERE CategoryID = 3

-- Mostramos los nuevos valores, en los que el trigger 
-- modific� de forma autom�tica las columnas y el nombre
-- de quien las modific�

SELECT *
FROM NuevasCategorias
WHERE CategoryID = 3
GO

-- Asumimos la identidad del usuario dbo

SETUSER
GO

-- Eliminamos la tabla de ejemplo. Se elimina de forma autom�tica
--  el trigger.

DROP TABLE NuevasCategorias
