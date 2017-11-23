/***************************************************
Los triggers AFTER se ejecutan una vez modificados los datos.
Sin embargo, como la transacción todavía está en curso, podemos
decidir la cancelación de la ación.
A diferencia de los INSTEAD OF, para confirmar la transacción no hace falta
hacer nada especial; se completará automáticamente a menos que decidamos
descartarla.
Podemos crear un número indefinido de triggers AFTER para cada tabla y acción.

Si queremos evitar que el trigger se ejecute cuando se reciben datos por
duplicación se puede usar la opción NOT FOR REPLICATION.
****************************************************/
-- EJEMPLO: Creación de un trigger en la tabla Customers
-- para controlar las acciones INSERT, UPDATE y DELETE
-- Creamos un trigger sobre la tabla customers para actuar con las
-- las órdenes INSERT, UPDATE y DELETE 

CREATE TRIGGER tr_Customers
ON Customers
AFTER INSERT, UPDATE, DELETE
AS
-- Código
GO

-- Creamos un trigger sobre la tabla customers para actuar con las
-- las órdenes INSERT, UPDATE y DELETE usando la palabra clave FOR 

CREATE TRIGGER tr_Customers
ON Customers
FOR INSERT, UPDATE, DELETE
AS
-- Código
GO

-- Creamos un trigger sobre la tabla customers para actuar con las
-- las órdenes INSERT 

CREATE TRIGGER isr_Customers
ON Customers
AFTER INSERT
AS
-- Código
GO

-- Creamos un trigger sobre la tabla customers para actuar con las
-- las órdenes INSERT, UPDATE y DELETE usando la palabra clave 
-- With ENCRYPTION. El código queda cifrado.

CREATE TRIGGER tr_Customers
ON Customers
WITH ENCRYPTION
AFTER INSERT, UPDATE, DELETE
AS
-- Código
GO

-- Creamos un trigger sobre la tabla customers para actuar con las
-- las órdenes INSERT, UPDATE y DELETE.
-- El trigger no se ejecuta cuando los datso que llegan proceden
-- de una duplicación.

CREATE TRIGGER tr_Customers
ON Customers
AFTER INSERT, UPDATE, DELETE
NOT FOR REPLICATION
AS
-- Código
GO

-- Creamos un trigger INSTEAD OF sobre la vista NewCustomers 
-- ejecutándose cuando se intenta actualizar datos a través de la vista
CREATE TRIGGER tr_Customers
ON NewCustomers
INSTEAD OF INSERT, UPDATE, DELETE
AS
-- Código
GO

-- Creamos un trigger INSTEAD OF sobre la vista NewCustomers 
-- ejecutándose cuando se intenta insertar datos a través de la vista
CREATE TRIGGER tr_Customers
ON NewCustomers
INSTEAD OF INSERT
AS
-- Código
GO

/* ****************************************************************************************
COMENTARIOS
No es recomendable usar instrucciones SELECT dentro de un trigger.
Si dentro del trigger  hay instrucciones cuya ejecución no es necesaria cuando
la operación no ha afectado a filas y queremos impedir la ejecución de esas
instrucciones, se debe usar la función @@ROWCOUNT comprobando que su valor
es mayor que 0.
Al crear un trigger no se comprueban los nombres de los objetos. La comprobación
se lleva a cabo en el momento de la ejecución (RESOLUCIÓN DIFERIDA DE NOMBRES).
**********************************************************************************/