/***************************************************
DETERMINACIÓN DEL ORDEN DE EJECUCIÓN
Es imposible determinar el orden de ejecución para los triggers definidos 
para una misma acción.
Sin embargo, se puede seleccionarf qué trigger se ejecutará en primer
lugar y cuál lo hará al final. Para ello se emplea el procedimiento de sistema
sp_settriggerorder.

EJEMPLO: Modificación del orden de ejecución de los triggers
****************************************************/

USE Northwind
GO

-- Creamos varios triggers sobre la tabla customers para controlar
-- las opciones UPDATE

CREATE TRIGGER tr1_Customers
ON clientes
AFTER UPDATE
AS
-- Código
PRINT 'Este es el trigger tr1'
GO

CREATE TRIGGER tr2_Customers
ON clientes
AFTER UPDATE
AS
-- Código
PRINT 'Este es el trigger tr2'
GO

CREATE TRIGGER tr3_Customers
ON clientes
AFTER UPDATE
AS
-- Código
PRINT 'Este es el trigger tr3'
GO

-- Probamos el orden de ejecución mediante una operación simulada

UPDATE clientes
SET ContactName = ContactName
GO

-- Especificamos el trigger tr3 como el primer trigger a ejecutar

EXEC sp_settriggerorder 'tr3_Customers', 'FIRST', 'UPDATE'

-- Especificamos el trigger tr2 como el último trigger a ejecutar

EXEC sp_settriggerorder 'tr2_Customers', 'LAST', 'UPDATE'

-- Especificamos que el trigger tr1 se ejecute en cualquier orden

EXEC sp_settriggerorder 'tr1_Customers', 'NONE', 'UPDATE'

GO

-- Probamos el orden de ejecución mediante una operación simulada

PRINT CHAR(10) + 'After reordering' + CHAR(10)

UPDATE clientes
SET ContactName = ContactName
GO


/* ******************************************************************
Recuerda que los triggers INSTEAD OF siempre que se ejecutan antes de
modificar los datos. En consecuencia, su ejecución precede a la de todos 
los desencadenadores AFTER.
******************************************************************* */