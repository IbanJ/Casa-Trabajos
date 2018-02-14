/***************************************************
UTILIZACIÓN DE VARIABLES DE TABLA EN LAS UDF
Si necesitamos usar tablas temporales, como alternativa podemos
usar variables de tabla definidas dentro de la función, pudiéndolas
modificar dentro.

EJEMPLO: creamos una función que calcula la mediana (NO LA MEDIA)
de la columna UnitPrice para los productos guardados en la 
tabla Products.
La función se llama PrecioUnitarioMedio
****************************************************/

USE AdventureWorks
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PrecioUnitarioMedio]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[PrecioUnitarioMedio]
GO
CREATE FUNCTION dbo.PrecioUnitarioMedio
()
RETURNS money
AS
BEGIN
	-- Creamos una variable de tabla para almacenar los datos
		DECLARE @tabla TABLE(
		  id int identity(1,1)
		, PrecioVenta money)
	
	-- Insertamos los precios de los productos en orden ascendente
	INSERT INTO @tabla (PrecioVenta)
	SELECT ListPrice
	FROM Production.Product
	ORDER BY ListPrice ASC
	
	-- Seleccionamos el precio medio
		RETURN (
				SELECT MAX(PrecioVenta)
				FROM @tabla
				WHERE ID <=
					(
						SELECT MAX(ID)
						FROM @tabla
					) / 2
				)
	
END
