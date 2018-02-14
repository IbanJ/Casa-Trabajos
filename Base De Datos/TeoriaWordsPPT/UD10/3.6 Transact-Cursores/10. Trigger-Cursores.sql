/***************************************************Uso de cursores dentro de un trigger para convertir operaciones sobre varias filas en otras que solamenteafectan a una.****************************************************/


USE Northwind
GO



-- Modificamos las características de la tabla "Customers"
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
	-- Aquí iría el código que generaría el límite de crédito correspondiente
	-- En este caso, imaginemos que el valor recogido es 1000 (en realidad
	-- estaría almacenado en una variable)
	   UPDATE Customers
	   SET CreditLimit = 1000
	   WHERE CustomerID = @ID
GO
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[isr_Customers]'))
DROP TRIGGER [dbo].[isr_Customers]
GO
-- Creamos el Trigger que se ejecutará después
-- de cada Insert llevada a cabo en la tabla "Customers"
CREATE TRIGGER isr_Customers
ON Customers
FOR INSERT AS
	DECLARE @ID nvarchar(5)
	
	IF @@ROWCOUNT > 1
	-- Operación con varias filas
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
			-- Asignamos un límite de crédito a cada cliente nuevo
			EXEC AsignarLimiteCredito @ID
			
			FETCH NEXT FROM Nuevos_Customers INTO @ID
		END
		
		-- Cerramos el cursor
		CLOSE Nuevos_Customers
		DEALLOCATE Nuevos_Customers
	END
		
	ELSE
	-- Operación sobre una sola fila
	BEGIN
		SELECT @ID = CustomerID
		FROM Inserted
		
		IF @ID IS NOT NULL
			-- Asignamos un límite de crédito al nuevo cliente
			EXEC AsignarLimiteCredito @ID
	END
	
GO

/*
   Ejecutamos el código de prueba
*/
INSERT customers (CustomerID, CompanyName)
     VALUES ('ZZZZZ', 'Nueva Compañía')

SELECT CreditLimit
FROM Customers
WHERE CustomerID = 'ZZZZZ'


