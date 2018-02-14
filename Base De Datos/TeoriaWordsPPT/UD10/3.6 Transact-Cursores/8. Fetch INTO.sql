/***************************************************Uso de FETCH INTO para cargar las columnas en variables****************************************************/
USE Northwind
GO

SET NOCOUNT ON
GO

DECLARE @ProductID int
	, @ProductName nvarchar(40)
	, @CategoryID int

DECLARE Mis_Productos CURSOR STATIC
FOR
	SELECT ProductID, ProductName, CategoryID
	FROM Products
	WHERE CategoryID BETWEEN 6 AND 8
	ORDER BY ProductID ASC

OPEN Mis_Productos

FETCH FROM Mis_Productos
	INTO @ProductID, @ProductName, @CategoryID

WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT @ProductName as 'Producto'
		, CategoryName AS 'Categoria'
	FROM Categories
	WHERE CategoryID = @CategoryID
	
	FETCH FROM Mis_Productos
		INTO @ProductID, @ProductName, @CategoryID
	
END

CLOSE Mis_Productos

DEALLOCATE Mis_Productos
