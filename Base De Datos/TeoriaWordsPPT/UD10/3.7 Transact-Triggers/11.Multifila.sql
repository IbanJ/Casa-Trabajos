/***************************************************
CONTROL DE OPERACIONES CON VARIAS FILAS

La activación de un trigger solo se lleva a cabo como respuesta
a una acción que modifica una sola fila o varias en una misma
instrucción.

Si queremos un trigger que solo se active con operaciones de una
sola fila, debemos rechazar los cambios que afecten a más de una 
fila. Podemos controlarlo con la función de sistema @@ROWCOUNT.

Si queremos un trigger que solo se active con operaciones de
varias filas, podríamos usar funciones de agregación o cursores.

La situación ideal sería crear un trigger condicional que pudiera 
trabajar con operaciones de una fila o de varias, de acuerdo con
el valor devuelto por @@ROWCOUNT.

EJEMPLO: detección de una operación de varias filas

****************************************************/

USE Northwind
GO

-----------------------------
-- Creamos un trigger para insert
-----------------------------

CREATE TRIGGER TRINSERT_OrderDetails
ON [Order Details]
AFTER INSERT
AS
	IF @@ROWCOUNT = 1
	BEGIN

		-- Operación de una sola fila
		
		UPDATE TC
		SET TotalSales = TotalSales
				+ I.UnitPrice * Quantity * (1 - Discount)
		FROM TotalCategoriesSales TC
			JOIN Products P
				ON P.CategoryID = TC.CategoryID
			JOIN Inserted I
				ON I.ProductID = P.productID
	
	END
	ELSE
	BEGIN
	
		-- Operación multifila
		
		UPDATE TC
		SET TotalSales = TotalSales
				+ (SELECT SUM(I.UnitPrice * Quantity * (1 - Discount))
					FROM Inserted I
					WHERE I.ProductID = P.productID)
		FROM TotalCategoriesSales TC
			JOIN Products P
				ON P.CategoryID = TC.CategoryID
	
	END
GO

-----------------------------
-- Creamos un trigger para DELETE
-----------------------------

CREATE TRIGGER TRDEL_OrderDetails
ON [Order Details]
AFTER DELETE
AS
	IF @@ROWCOUNT = 1
	BEGIN
	
		-- Operación de una sola fila
		
		UPDATE TC
		SET TotalSales = TotalSales
				- D.UnitPrice * Quantity * (1 - Discount)
		FROM TotalCategoriesSales TC
			JOIN Products P
				ON P.CategoryID = TC.CategoryID
			JOIN Deleted D
				ON D.ProductID = P.productID
	
	END
	ELSE
	BEGIN
	
		-- Operación multifila
		
		UPDATE TC
		SET TotalSales = TotalSales
				- (SELECT SUM(D.UnitPrice * Quantity * (1 - Discount))
					FROM Deleted D
					WHERE D.ProductID = P.productID)
		FROM TotalCategoriesSales TC
			JOIN Products P
				ON P.CategoryID = TC.CategoryID
	
	END
GO

-----------------------------
-- Creamos un trigger para UPDATE
-----------------------------

CREATE TRIGGER TRUPD_OrderDetails
ON [Order Details]
AFTER UPDATE
AS
	IF @@ROWCOUNT = 1
	BEGIN
	
		-- Operación de una sola fila
		
		UPDATE TC
		SET TotalSales = TotalSales
				+ I.UnitPrice * I.Quantity * (1 - I.Discount)
		FROM TotalCategoriesSales TC
			JOIN Products P
				ON P.CategoryID = TC.CategoryID
			JOIN Inserted I
				ON I.ProductID = P.productID
		
		UPDATE TC
		SET TotalSales = TotalSales
				- D.UnitPrice * D.Quantity * (1 - D.Discount)
		FROM TotalCategoriesSales TC
			JOIN Products P
				ON P.CategoryID = TC.CategoryID
			JOIN Deleted D
				ON D.ProductID = P.productID
		
	END
	ELSE
	BEGIN
	
		-- Operación multifila
		
		UPDATE TC
		SET TotalSales = TotalSales
				+ (SELECT SUM(I.UnitPrice * Quantity * (1 - Discount))
					FROM Inserted I
					WHERE I.ProductID = P.productID)
		FROM TotalCategoriesSales TC
			JOIN Products P
				ON P.CategoryID = TC.CategoryID
		
		UPDATE TC
		SET TotalSales = TotalSales
				- (SELECT SUM(D.UnitPrice * Quantity * (1 - Discount))
					FROM Deleted D
					WHERE D.ProductID = P.productID)
		FROM TotalCategoriesSales TC
			JOIN Products P
				ON P.CategoryID = TC.CategoryID
		
	END
GO
