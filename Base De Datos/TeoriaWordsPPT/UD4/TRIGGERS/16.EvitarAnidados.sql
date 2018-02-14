/***************************************************
EVITAR TRIGGERS ANIDADOS

Deber�amos evitar el uso de los triggers anidados.
Es m�s recomendable crear un trigger para cada acci�n l�gica.

EJEMPLO: cada tabla puede tener varios triggers para cada acci�n.
****************************************************/

USE Northwind
GO

CREATE TRIGGER tr_OrderDetails_TotalOrders
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


CREATE TRIGGER tr_OrderDetails_TotalEmployees
ON [Order details]
AFTER INSERT, DELETE, UPDATE
AS

	IF @@rowcount = 1
	
		-- Operaci�n sobre una sola fila
		
		UPDATE Employees
		SET VentasTotales = VentasTotales
			+ ISNULL(
				(SELECT UnitPrice * Quantity * (1 - Discount)
				FROM Inserted
					JOIN Orders
						ON Inserted.OrderID = Orders.OrderID
				WHERE Orders.EmployeeID = Employees.EmployeeID), 0)
			- ISNULL(
				(SELECT UnitPrice * Quantity * (1 - Discount)
				FROM Deleted
					JOIN Orders
						ON Deleted.OrderID = Orders.OrderID
				WHERE Orders.EmployeeID = Employees.EmployeeID), 0)
	
	ELSE
	
		-- Operaci�n sobre varias filas
		
		UPDATE Employees
		SET VentasTotales = VentasTotales
			+ ISNULL(
				(SELECT SUM(UnitPrice * Quantity * (1 - Discount))
				FROM Inserted
					JOIN Orders
						ON Inserted.OrderID = Orders.OrderID
				WHERE Orders.EmployeeID = Employees.EmployeeID), 0)
			- ISNULL(
				(SELECT SUM(UnitPrice * Quantity * (1 - Discount))
				FROM Deleted
					JOIN Orders
						ON Deleted.OrderID = Orders.OrderID
				WHERE Orders.EmployeeID = Employees.EmployeeID), 0)

GO

CREATE TRIGGER tr_OrderDetails_TotalCustomers
ON [Order details]
AFTER INSERT, DELETE, UPDATE
AS

	IF @@rowcount = 1
	
		-- Operaci�n sobre una sola fila
		
		UPDATE Customers
		SET VentasTotales = VentasTotales
			+ ISNULL(
				(SELECT UnitPrice * Quantity * (1 - Discount)
				FROM Inserted
					JOIN Orders
						ON Inserted.OrderID = Orders.OrderID
				WHERE Orders.CustomerID = Customers.CustomerID), 0)
			- ISNULL(
				(SELECT UnitPrice * Quantity * (1 - Discount)
				FROM Deleted
					JOIN Orders
						ON Deleted.OrderID = Orders.OrderID
				WHERE Orders.CustomerID = Customers.CustomerID), 0)
		
	ELSE
	
		-- Operaci�n sobre varias filas
		
		UPDATE Customers
		SET VentasTotales = VentasTotales
			+ ISNULL(
				(SELECT SUM(UnitPrice * Quantity * (1 - Discount))
				FROM Inserted
					JOIN Orders
						ON Inserted.OrderID = Orders.OrderID
				WHERE Orders.CustomerID = Customers.CustomerID), 0)
			- ISNULL(
				(SELECT SUM(UnitPrice * Quantity * (1 - Discount))
				FROM Deleted
					JOIN Orders
						ON Deleted.OrderID = Orders.OrderID
				WHERE Orders.CustomerID = Customers.CustomerID), 0)
GO

DROP TRIGGER tr_OrderDetails_TotalOrders

DROP TRIGGER tr_OrderDetails_TotalCustomers

DROP TRIGGER tr_OrderDetails_TotalEmployees

GO


/* ***********************************************************************************
Los ejemplos del Tema 15. y 16. crean un �nico trigger para tres acciones (INSERT, UPDATE Y DELETE).
En t�rminos de rendimiento, es m�s eficiente crear triggers individuales para cada acci�n.
*************************************************************************************/