/***************************************************Inserción en una tabla del conjunto de resultados devueltopor un procedimiento almacenado.Se realiza mediante una sentencia INSERT seguida de la ejecucióndel procedimiento almacenado.****************************************************/USE AdventureWorks
GO
-- Creamos un Procedimiento que recoge los colores de los productos
CREATE PROC dbo.Coger_Colores_Productos
AS
	select distinct(color) from Production.Product
	
/* Probamos el procedimiento anterior realizando una INSERT masiva
   sobre una tabla temporal que creamos en primer lugar */
	-- Creamos la tabla temporal
	CREATE TABLE #Colores (	Color INT NOT NULL)
	-- Realizamos la Insert masiva
	INSERT INTO #Colores
		EXEC Coger_Colores_Productos
	-- Leemos los resultados
	SELECT * FROM #Colores