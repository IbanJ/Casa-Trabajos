/***************************************************Uso de procedimientos almacenados para obtener informaciónacerca de los cursores****************************************************/
USE Northwind
GO

SET NOCOUNT ON
GO

-- Declaramos varios cursores
DECLARE C_Categories CURSOR LOCAL DYNAMIC
FOR
	SELECT CategoryName
	FROM Categories

DECLARE C_Customers CURSOR LOCAL FAST_FORWARD
FOR
	SELECT CompanyName
	FROM Customers

DECLARE C_OrdersCompleto CURSOR GLOBAL KEYSET
FOR
	SELECT O.OrderID
		, OrderDate
		, C.CustomerID
		, CompanyName
		, P.ProductID
		, ProductName
		, Quantity
		, OD.UnitPrice
		, Discount
	FROM Orders O
		JOIN [Order Details] OD
			ON OD.OrderID = O.OrderID
		JOIN Customers C
			ON C.CustomerID = O.CustomerID
		JOIN Products P
			ON P.ProductID = OD.ProductID

-- Declaramos una variable de cursor que almacene los
-- resultados de los procedimientos almacenados
DECLARE @OutputCursor AS CURSOR

-- Obtenemos información sobre los cursores locales declarados
EXEC sp_cursor_list @OutputCursor OUTPUT, 1

-- Liberamos el cursor para poder reutilizar la variable de cursor
DEALLOCATE @OutputCursor

-- Obtenemos información sobre los cursores globales declarados
EXEC sp_cursor_list @OutputCursor OUTPUT, 2

-- Liberamos el cursor para poder reutilizar la variable cursor
DEALLOCATE @OutputCursor

-- Obtenemos información sobre los cursores globales y locales.
-- Observa que status = -1 indica que el cursor está cerrado
PRINT CHAR(10) 
	+ 'sp_cursor_list cursor OUTPUT' 
	+ CHAR(10)

EXEC sp_cursor_list @OutputCursor OUTPUT, 3

FETCH NEXT FROM @OutputCursor

WHILE @@FETCH_STATUS = 0
	FETCH NEXT FROM @OutputCursor

-- Liberamos el cursor para poder reutilizar la variable de cursor
DEALLOCATE @OutputCursor

-- Abrimos el cursor C_Categories
OPEN C_Categories

-- Obtenemos información sobre un cursor
-- Observa que status = 1 indica que el cursor está abierto
EXEC sp_describe_cursor @OutputCursor OUTPUT
	, N'local'
	, N'C_Categories'

PRINT CHAR(10) 
	+ 'sp_describe_cursor cursor OUTPUT' 
	+ CHAR(10)

FETCH NEXT FROM @OutputCursor

WHILE @@FETCH_STATUS = 0
	FETCH NEXT FROM @OutputCursor

-- Liberamos el cursor para poder reutilizar la variable de cursor
DEALLOCATE @OutputCursor

CLOSE C_Categories

-- Abrimos el cursor C_Customers
OPEN C_Customers

-- Obtenemos información sobre un cursor
-- Observa que status = 1 indica que el cursor está abierto
EXEC sp_describe_cursor_columns @OutputCursor OUTPUT
	, N'local'
	, N'C_Customers'

PRINT CHAR(10) 
	+ 'sp_describe_cursor_columns cursor OUTPUT' 
	+ CHAR(10)

FETCH NEXT FROM @OutputCursor

WHILE @@FETCH_STATUS = 0
	FETCH NEXT FROM @OutputCursor

-- Liberamos el cursor para poder reutilizar la variable de cursor
DEALLOCATE @OutputCursor

CLOSE C_Customers

-- Abrimos el cursor C_Categories
OPEN C_OrdersCompleto

-- Obtenemos información sobre un cursor
-- Observa que status = 1 indica que el cursor está abierto
EXEC sp_describe_cursor_tables @OutputCursor OUTPUT
	, N'global'
	, N'C_OrdersCompleto'

PRINT CHAR(10) 
	+ 'sp_dscribe_cursor_tables cursor OUTPUT' 
	+ CHAR(10)

FETCH NEXT FROM @OutputCursor

WHILE @@FETCH_STATUS = 0
	FETCH NEXT FROM @OutputCursor

DEALLOCATE @OutputCursor

CLOSE C_OrdersCompleto

DEALLOCATE C_Categories

DEALLOCATE C_Customers

DEALLOCATE C_OrdersCompleto
