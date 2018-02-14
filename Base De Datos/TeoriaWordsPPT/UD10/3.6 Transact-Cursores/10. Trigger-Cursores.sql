/***************************************************Uso de cursores dentro de un trigger para convertir operaciones sobre varias filas en otras que solamenteafectan a una.****************************************************/


USE Northwind
GO



-- Modificamos las caracter�sticas de la tabla "Customers"
ALTER TABLE Customers
ADD CreditLimit money
GO

-- Creamos un procedimiento denominado "AsignarLimiteCredito"
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AsignarLimiteCredito]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AsignarLimiteCredito]
GO

CREATE PROCEDURE AsignarLimiteCredito
	@ID varchar(5)
AS
	-- Aqu� ir�a el c�digo que generar�a el l�mite de cr�dito correspondiente
	-- En este caso, imaginemos que el valor recogido es 1000 (en realidad
	-- estar�a almacenado en una variable)
	   UPDATE Customers
	   SET CreditLimit = 1000
	   WHERE CustomerID = @ID
GO
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[isr_Customers]'))
DROP TRIGGER [dbo].[isr_Customers]
GO
-- Creamos el Trigger que se ejecutar� despu�s
-- de cada Insert llevada a cabo en la tabla "Customers"
CREATE TRIGGER isr_Customers
ON Customers
FOR INSERT AS
	DECLARE @ID nvarchar(5)
	
	IF @@ROWCOUNT > 1
	-- Operaci�n con varias filas
	BEGIN
		-- Abrimos un cursor basado en la tabla Inserted
		DECLARE Nuevos_Customers CURSOR
		FOR 
			SELECT CustomerID
			FROM Inserted
			ORDER BY CustomerID
		
		OPEN Nuevos_Customers
		
		FETCH NEXT FROM Nuevos_Customers INTO @ID
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Asignamos un l�mite de cr�dito a cada cliente nuevo
			EXEC AsignarLimiteCredito @ID
			
			FETCH NEXT FROM Nuevos_Customers INTO @ID
		END
		
		-- Cerramos el cursor
		CLOSE Nuevos_Customers
		DEALLOCATE Nuevos_Customers
	END
		
	ELSE
	-- Operaci�n sobre una sola fila
	BEGIN
		SELECT @ID = CustomerID
		FROM Inserted
		
		IF @ID IS NOT NULL
			-- Asignamos un l�mite de cr�dito al nuevo cliente
			EXEC AsignarLimiteCredito @ID
	END
	
GO

/*
   Ejecutamos el c�digo de prueba
*/
INSERT customers (CustomerID, CompanyName)
     VALUES ('ZZZZZ', 'Nueva Compa��a')

SELECT CreditLimit
FROM Customers
WHERE CustomerID = 'ZZZZZ'


