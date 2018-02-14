/***************************************************
DESENCADENADORES ANIDADOS

Los triggers se pueden definir para que si se lleva a cabo una
modificaci�n sobre una tabla, dicha tabla tenga un trigger que 
se activar� modificando otra tabla que tiene asociado otro trigger,
y as� sucesivamente.

Se pueden llegar a anidar hasta 32 triggers.

El anidamiento de triggers est� habilitado de forma predeterminada.
Se puede cambiar esta opci�n a nivel de servidor configurando la opci�n
"nested triggers" en 0 mediante el procedimiento sp_configure.

Si durante la ejecuci�n de un trigger, un procedimiento almacenado o
una funci�n definida por el usuario, queremos saber la cantidad de niveles
de anidamiento alcanzada, podemos utilizar la funci�n @@NESTLEVEL.

En una situaci�n de anidamiento de triggers, todos se ejecutan dentro de 
la misma transacci�n. Un error en cualquiera de ellos cancela toda la
transacci�n.

EJEMPLO: Definimos desencadenadores para realizar el mantenimiento de
totales de ventas en diferentes niveles:
	1. Insertamos, modificamos o eliminamos de la tabla "Order Details".
	   Esta modificaci�n de datos hace que se ejecute el trigger
	   AFTER UPDATE.
	2. EL desencadenador AFTER UPDATE de la tabla "Order Details" actualiza 
	   la columna TotalVentas en la tabla Orders.
	3. Como la columna TotalVentas en la tabla Orders ha sufrido modificaciones,
	   el trigger AFTER UPDATE definido en la tabla Orders se ejecuta
	   autom�ticamente y actualiza la columna TotalVentas en las tablas
	   Employees y Customers.
****************************************************/

USE Northwind
GO

-- A�adimos la columna VentasTotales a la tabla Orders 

ALTER TABLE Orders
ADD VentasTotales money NULL

-- A�adimos la columna VentasTotales a la tabla Employees

ALTER TABLE Employees
ADD VentasTotales money NULL

-- A�adimos la columna VentasTotales a la tabla Customers

ALTER TABLE Customers
ADD VentasTotales money NULL

GO

-- Inicializamos los datos

UPDATE Orders
SET VentasTotales =(
	SELECT SUM([Order Details].UnitPrice * Quantity * (1 - Discount))
	FROM [Order Details]
	WHERE [Order Details].OrderID = Orders.OrderID
	)

UPDATE Employees
SET VentasTotales =(
	SELECT SUM(Orders.VentasTotales)
	FROM Orders
	WHERE Orders.EmployeeID = Employees.EmployeeID
	)

UPDATE Customers
SET VentasTotales =(
	SELECT SUM(Orders.VentasTotales)
	FROM Orders
	WHERE Orders.CustomerID = Customers.CustomerID
	)

GO

-- Creamos triggers anidados

CREATE TRIGGER TR_TotalOrderDetails
ON [Order details]
AFTER INSERT, DELETE, UPDATE
AS

	IF @@rowcount = 1
	
		-- Operaci�n sobre una sola fila
		
		UPDATE Orders
		SET VentasTotales = VentasTotales
			+ ISNULL(
				(SELECT UnitPrice * Quantity * (1 - Discount)
				FROM Inserted
				WHERE Inserted.OrderID = Orders.OrderID), 0)
			- ISNULL(
				(SELECT UnitPrice * Quantity * (1 - Discount)
				FROM Deleted
				WHERE Deleted.OrderID = Orders.OrderID), 0)
	
	ELSE
	
		-- Operaci�n sobre varias filas
		
		UPDATE Orders
		SET VentasTotales = VentasTotales
			+ ISNULL(
				(SELECT SUM(UnitPrice * Quantity * (1 - Discount))
				FROM Inserted
				WHERE Inserted.OrderID = Orders.OrderID), 0)
			- ISNULL(
				(SELECT SUM(UnitPrice * Quantity * (1 - Discount))
				FROM Deleted
				WHERE Deleted.OrderID = Orders.OrderID), 0)
	
GO


CREATE TRIGGER TR_TotalOrders
ON Orders
AFTER INSERT, DELETE, UPDATE
AS

	IF @@rowcount = 1
	BEGIN
		-- Operaci�n sobre una sola fila
		
		UPDATE Employees
		SET VentasTotales = VentasTotales
			+ ISNULL(
				(SELECT VentasTotales
				FROM Inserted
				WHERE Inserted.EmployeeID = Employees.EmployeeID), 0)
			- ISNULL(
				(SELECT VentasTotales
				FROM Deleted
				WHERE Deleted.EmployeeID = Employees.EmployeeID), 0)
		
		UPDATE Customers
		SET VentasTotales = VentasTotales
			+ ISNULL(
				(SELECT VentasTotales
				FROM Inserted
				WHERE Inserted.CustomerID = Customers.CustomerID), 0)
		- ISNULL(
				(SELECT VentasTotales
				FROM Deleted
				WHERE Deleted.CustomerID = Customers.CustomerID), 0)
		
	END
	ELSE
	BEGIN
	
		-- Operaci�n sobre varias filas
		
		UPDATE Employees
		SET VentasTotales = VentasTotales
			+ ISNULL(
				(SELECT SUM(VentasTotales)
				FROM Inserted
				WHERE Inserted.EmployeeID = Employees.EmployeeID), 0)
			- ISNULL(
				(SELECT SUM(VentasTotales)
				FROM Deleted
				WHERE Deleted.EmployeeID = Employees.EmployeeID), 0)
		
		UPDATE Customers
		SET VentasTotales = VentasTotales
			+ ISNULL(
				(SELECT SUM(VentasTotales)
				FROM Inserted
				WHERE Inserted.CustomerID = Customers.CustomerID), 0)
			- ISNULL(
				(SELECT SUM(VentasTotales)
				FROM Deleted
				WHERE Deleted.CustomerID = Customers.CustomerID), 0)
	
	END
GO

-- Modificamos Order Details y forzamos la ejecuci�n de los
-- triggers anidados

UPDATE [Order Details]
SET quantity = 100
WHERE orderid = 10248
	AND productid = 11

-- Comprobamos los totales en la tabla Orders

SELECT CustomerID
	, EmployeeID
	, VentasTotales 
FROM orders
WHERE OrderID =  10248

SELECT SUM([Order Details].UnitPrice * Quantity * (1 - Discount))
FROM [Order Details]
WHERE OrderID =  10248

-- Comprobamos los totales en la tabla Employees

SELECT VentasTotales
FROM Employees
WHERE EmployeeID = 5

SELECT SUM(VentasTotales)
FROM Orders
WHERE EmployeeID =  5

-- Comprobamos los totales en la tabla Customers

SELECT VentasTotales
FROM Customers
WHERE CustomerID = 'VINET'

SELECT SUM(VentasTotales)
FROM Orders
WHERE CustomerID =  'VINET'
GO

-- Dropping triggers

DROP TRIGGER isrTotalOrderDetails

DROP TRIGGER isrTotalOrders

/* ***********************************************************************************
COMENTARIOS.
Como se observa, la modificaci�n de los datos solo se produce en la tabla "Order Details" 
y dos desencadenadores anidados mantienen los res�menes en las tablas Orders, Employees y 
Customers.

Este mismo problema se puede resolver sin utilizar triggers anidados. Se pueden crear
tres triggers en la tabla "Order Details". 
*************************************************************************************/