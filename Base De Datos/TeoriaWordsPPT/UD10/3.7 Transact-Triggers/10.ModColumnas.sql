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
		PRINT 'Los cambios sobre la PRIMARY KEY no están permitidos'
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
-- Test de trigger:
PRINT CHAR(10) + 'Actualizando ProductID y UnitPrice'
--Actualizamos el campo [order Details].ProductID y [order Details].UnitPrice
UPDATE [Order Details]
SET ProductID = ProductID
	, UnitPrice = UnitPrice
--Actualizamos el campo [order Details].Quantity
PRINT CHAR(10) + 'Actualizando Quantity'

UPDATE [Order Details]
SET Quantity = Quantity
--Actualizamos el campo [order Details].OrderID
PRINT CHAR(10) + 'Actualizando OrderID'

UPDATE [Order Details]
SET OrderID = OrderID

--deshacer ejemplo
IF EXISTS (SELECT name FROM sys.objects
      WHERE name = 'tr_OrderDetails' AND type = 'TR')
   DROP TRIGGER tr_OrderDetails;
GO


--Ejemplo 2
--El ejemplo siguiente crea un desencadenador que imprime un mensaje si alguien intenta actualizar (UPDATE) las columnas StateProvinceID o PostalCode de la tabla Address. Levantará una excepción. RAISERROR. 
	
--Razón por la que crear el trigger:
--No se quiere evitar el cumplimiento de la instrucción si no que se quiere enviar un mensaje.

USE AdventureWorks;
GO
IF EXISTS (SELECT name FROM sys.objects
      WHERE name = 'reminder' AND type = 'TR')
   DROP TRIGGER Person.reminder;
GO
CREATE TRIGGER reminder
ON Person.Address
AFTER UPDATE 
AS 
--En caso de que se actualicen las columnas (StateProvinceID) o (PostalCode)
IF ( UPDATE (StateProvinceID) OR UPDATE (PostalCode) )
BEGIN
--enviar mensaje mediante un raiserror
RAISERROR (50009, 16, 10)
END;
GO
select * FROM Person.Address 
WHERE PostalCode = '19107';


-- Test de trigger.
UPDATE Person.Address
SET PostalCode = 99999
WHERE PostalCode = '19107';
select * FROM Person.Address 
where PostalCode = '19107' or PostalCode = '99999'
GO
 
 --deshacer ejemplo
 UPDATE Person.Address
SET PostalCode = 19107
WHERE PostalCode = '99999';
USE AdventureWorks;
GO
IF EXISTS (SELECT name FROM sys.objects
      WHERE name = 'reminder' AND type = 'TR')
   DROP TRIGGER Person.reminder;
GO
