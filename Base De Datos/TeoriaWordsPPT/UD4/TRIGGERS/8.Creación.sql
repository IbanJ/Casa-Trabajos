/***************************************************
Los triggers AFTER se ejecutan una vez modificados los datos.
Sin embargo, como la transacci�n todav�a est� en curso, podemos
decidir la cancelaci�n de la aci�n.
A diferencia de los INSTEAD OF, para confirmar la transacci�n no hace falta
hacer nada especial; se completar� autom�ticamente a menos que decidamos
descartarla.
Podemos crear un n�mero indefinido de triggers AFTER para cada tabla y acci�n.

Si queremos evitar que el trigger se ejecute cuando se reciben datos por
duplicaci�n se puede usar la opci�n NOT FOR REPLICATION.
****************************************************/
-- EJEMPLO: Creaci�n de un trigger en la tabla Customers
-- para controlar las acciones INSERT, UPDATE y DELETE
-- Creamos un trigger sobre la tabla customers para actuar con las
-- las �rdenes INSERT, UPDATE y DELETE 

CREATE TRIGGER tr_Customers
ON Customers
AFTER INSERT, UPDATE, DELETE
AS
-- C�digo
GO

-- Creamos un trigger sobre la tabla customers para actuar con las
-- las �rdenes INSERT, UPDATE y DELETE usando la palabra clave FOR 

CREATE TRIGGER tr_Customers
ON Customers
FOR INSERT, UPDATE, DELETE
AS
-- C�digo
GO

-- Creamos un trigger sobre la tabla customers para actuar con las
-- las �rdenes INSERT 

CREATE TRIGGER isr_Customers
ON Customers
AFTER INSERT
AS
-- C�digo
GO

-- Creamos un trigger sobre la tabla customers para actuar con las
-- las �rdenes INSERT, UPDATE y DELETE usando la palabra clave 
-- With ENCRYPTION. El c�digo queda cifrado.

CREATE TRIGGER tr_Customers
ON Customers
WITH ENCRYPTION
AFTER INSERT, UPDATE, DELETE
AS
-- C�digo
GO

-- Creamos un trigger sobre la tabla customers para actuar con las
-- las �rdenes INSERT, UPDATE y DELETE.
-- El trigger no se ejecuta cuando los datso que llegan proceden
-- de una duplicaci�n.

CREATE TRIGGER tr_Customers
ON Customers
AFTER INSERT, UPDATE, DELETE
NOT FOR REPLICATION
AS
-- C�digo
GO

-- Creamos un trigger INSTEAD OF sobre la vista NewCustomers 
-- ejecut�ndose cuando se intenta actualizar datos a trav�s de la vista
CREATE TRIGGER tr_Customers
ON NewCustomers
INSTEAD OF INSERT, UPDATE, DELETE
AS
-- C�digo
GO

-- Creamos un trigger INSTEAD OF sobre la vista NewCustomers 
-- ejecut�ndose cuando se intenta insertar datos a trav�s de la vista
CREATE TRIGGER tr_Customers
ON NewCustomers
INSTEAD OF INSERT
AS
-- C�digo
GO

/* ****************************************************************************************
COMENTARIOS
No es recomendable usar instrucciones SELECT dentro de un trigger.
Si dentro del trigger  hay instrucciones cuya ejecuci�n no es necesaria cuando
la operaci�n no ha afectado a filas y queremos impedir la ejecuci�n de esas
instrucciones, se debe usar la funci�n @@ROWCOUNT comprobando que su valor
es mayor que 0.
Al crear un trigger no se comprueban los nombres de los objetos. La comprobaci�n
se lleva a cabo en el momento de la ejecuci�n (RESOLUCI�N DIFERIDA DE NOMBRES).
**********************************************************************************/