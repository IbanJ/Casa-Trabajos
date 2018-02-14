/***************************************************Inserción en una tabla del conjunto de resultados devueltopor un procedimiento almacenado.Se realiza mediante una sentencia INSERT seguida de la ejecucióndel procedimiento almacenado.****************************************************/USE Northwind
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Coger_empleados_Pais]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Coger_empleados_Pais]
GO

-- Creamos el Procedimiento
CREATE PROC dbo.Coger_empleados_Pais
     @country NVARCHAR(30)
AS
BEGIN
	-- Creamos una tabla temporal
	CREATE TABLE #Empleados_del_Pais (
		emp_id INT NOT NULL,
		emp_lname NVARCHAR (20) NOT NULL,
		emp_fname NVARCHAR (10) NOT NULL
		)
		
	 -- Realizamos una INSERT masiva
	INSERT INTO #Empleados_del_Pais
		SELECT    employeeid,lastname,firstname
		FROM    Employees
		WHERE    country = @country
		
	-- Trabajamos con los datos de la tabla temporal
    
END

-- Probamos el Procedimiento
EXEC dbo.Coger_empleados_Pais 'USA'

-- y consultamos los datos de la tabla temporal.
-- Nos responde que el objeto #Empleados_del_Pais no existe.
SELECT * FROM #Empleados_del_Pais
GO

