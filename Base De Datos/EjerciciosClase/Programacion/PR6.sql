Declare @p_salida as money, @valorDevuelto smallint
exec @valorDevuelto = PR6 10, 'Black', @p_salida output
IF @valorDevuelto = 0
	PRINT @p_salida
ELSE 
	PRINT 'No hay datos'


-- Crear un procedimiento PR6
/* Este procedimiento recibe como parametros:
	-> Codigo de subcategoria
	-> Color
	-> Variable (OUTPUT) en donde se almacenara el precio medio
	   correspondiente a productos de la subcategoria
	   y el color indicado.
	El procedimiento accede a la informacion de la tabla
	Adventureworks2014.Production.Product

	Si no hay datos con el criterio de busqueda,
	el programa devlovera el valor -1
*/

ALTER PROCEDURE PR6
	@p_CodigoSubcategoria int,
	@p_Color varchar(30),
	@p_PrecioMedio money OUTPUT

AS

BEGIN
	SELECT @p_PrecioMedio = AVG(ListPrice)
	FROM AdventureWorks2014.Production.Product
	WHERE color = @p_Color and
		  ProductSubcategoryID = @p_CodigoSubcategoria

	IF @p_PrecioMedio IS NULL
		RETURN -1
		  

END

--SELECT ProductSubcategoryID,Color,ListPrice
--FROM AdventureWorks2014.Production.Product
--WHERE color  is not null and listprice is not null
--	and ProductSubcategoryID is not null