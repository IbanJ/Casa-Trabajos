/***************************************************Resolución de un problema de negocio sin cursores y con cursores****************************************************/

USE Northwind
GO

SET NOCOUNT ON
GO

------------------
-- Sin cursores
------------------
SELECT CompanyName, OrderDate
FROM Customers
	JOIN Orders
		ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'USA'
ORDER BY CompanyName, OrderDate

----------------
-- usando cursores
----------------

-- Declaramos las variables de Servidor
DECLARE @ID nchar(5), @Name nvarchar(40)
	, @Country nvarchar(15), @OrderDate datetime

-- Declaramos un cursor para Customers
DECLARE Misclientes CURSOR LOCAL
FOR
	SELECT CustomerID, CompanyName, Country
	FROM Customers

-- Abrimos el cursor para Customers 
OPEN Misclientes

-- Recuperamos el primer cliente
FETCH NEXT FROM Misclientes
	INTO @ID, @Name, @Country

WHILE @@FETCH_STATUS=0
BEGIN

	IF @Country = 'USA'
	BEGIN
	
		-- Declaramos el cursor para Orders 
		DECLARE MisPedidos CURSOR LOCAL
		FOR
			SELECT OrderDate
			FROM Orders
			WHERE CustomerID = @ID
		
		-- Abrimos el cursor para Orders
		
		OPEN MisPedidos
		
		-- Recuperamos el primer pedido
		FETCH NEXT FROM MisPedidos
			INTO @OrderDate
		
		WHILE @@FETCH_STATUS=0
		BEGIN
		
			SELECT @Name AS 'Nombre Compañía'
				, @OrderDate AS 'Fecha Pedido'
			
			-- Recuperamos el siguiente pedido
			FETCH NEXT FROM MisPedidos
				INTO @OrderDate
			
		END
		
		-- Cerramos el cursor de  Orders 
		CLOSE MisPedidos
		
		--Liberamos el cursor de Orders 
		
		DEALLOCATE MisPedidos
		
	END
	
	-- Recuperamos el siguiente Cliente
	FETCH NEXT FROM Misclientes
		INTO @ID, @Name, @Country
	
END

-- Cerramos el cursor de Customers 
CLOSE Misclientes

-- Liberamos el cursor de Customers
DEALLOCATE Misclientes
