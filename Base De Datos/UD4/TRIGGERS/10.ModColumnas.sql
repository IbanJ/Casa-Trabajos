/***************************************************
CONTROLAR LA MODIFICACIÓN DE COLUMNAS ESPECÍFICAS

Para saber dentro de un trigger si se ha modificado alguna columna
usaremos la función UPDATE().
Para controlar los cambios en varias columnas en una sola instrucción,
podemos usar la función COLUMNS_UPDATED(). Esta función devuelve un
mapa de bits con el estado de actualización de cada columna en la
tabla base. COLUMNS_UPDATED() devuelve una secuencia de bits, uno para
cada columna, donde cada bit es 1 si la columna sufrió cambios o 0 en
caso contrario.

EJEMPLO: Es posible controlar qué columnas han sido modificadas dentro
de un trigger.
****************************************************/

USE Northwind
GO

CREATE TRIGGER tr_OrderDetails
ON [Order Details]
AFTER UPDATE
AS
	-- Miramos si se han realizado cambios en la PRIMARY KEY
	IF UPDATE(OrderID)
	BEGIN
		PRINT 'Los cambios sobre la PRIMARY KEY nom están permitidos'
		ROLLBACK TRAN
	END
	
	-- Miramos si se han realizado cambios en las columnas 2, 3 y 4
	IF ((COLUMNS_UPDATED() & (2 + 4 + 8)) > 0)
	BEGIN
		IF ((COLUMNS_UPDATED() & 2) = 2)
			PRINT 'ProductID actualizado'
		IF ((COLUMNS_UPDATED() & 4) = 4)
			PRINT 'UnitPrice actualizado'
		IF ((COLUMNS_UPDATED() & 8) = 8)
			PRINT 'Quantity actualizada'
	END
GO

PRINT CHAR(10) + 'Actualizando ProductID y UnitPrice'

UPDATE [Order Details]
SET ProductID = ProductID
	, UnitPrice = UnitPrice

PRINT CHAR(10) + 'Actualizando Quantity only'

UPDATE [Order Details]
SET Quantity = Quantity

PRINT CHAR(10) + 'Actualizando OrderID'

UPDATE [Order Details]
SET OrderID = OrderID
