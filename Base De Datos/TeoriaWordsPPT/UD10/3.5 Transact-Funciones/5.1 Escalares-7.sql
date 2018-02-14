/***************************************************
USO DE COLUMNAS COMO PAR�METROS EN UNA LLAMADA
A UNA FUNCI�N DEFINIDA POR EL USUARIO
****************************************************/
USE AdventureWorks
GO

-- Utilizaci�n de la funci�n ImporteTotal para obtener 
-- informaci�n de la tabla "Sales.SalesOrderDetail"
SELECT SalesOrderID
	, ProductID
	, dbo.ImporteTotal(OrderQty, UnitPrice, UnitPriceDiscount) AS Total
FROM Sales.SalesOrderDetail
WHERE ProductID = 760

/***************************************************
LLAMADA A FUNCIONES CON EXECUTE
En las llamadas se pueden omitir aquellos par�metros que tengan
un valor predeterminado y modificar el orden de los par�metros, 
siempre que la llamada a la funci�n sea con el nombre de los 
par�metros (nominada)
****************************************************/
USE AdventureWorks
GO

--Declaramos una variable para guardar el resultado de la UDF
DECLARE @Total money

-- Utilizamos EXECUTE y suministramos valores para todos los par�metros
EXECUTE @Total = dbo.ImporteTotal 12, 25.4, 0.0
SELECT @Total

-- Usamos EXECUTE y omitimos el par�metro @Descuento
-- ya que tiene valor predeterminado
EXECUTE @Total = dbo.ImporteTotal 12, 25.4
SELECT @Total

-- Usamos EXECUTE y omitimos el nombre del propietario de la UDF 
-- ya que est� predeterminado para dbo.
EXECUTE @Total = ImporteTotal 12, 25.4
SELECT @Total

-- Usamos EXECUTE y suministramos valores para cada par�metro
-- indicando los nombres de par�metro
EXECUTE @Total = ImporteTotal
	  @Cantidad = 12
	, @PrecioUnitario = 25.4
	, @Descuento = 0.2
SELECT @Total

-- Usamos EXECUTE y suministramos valores para todos los par�metros
-- especificando los par�metros en orden y con nombre en cualquier orden
EXECUTE @Total = ImporteTotal 
	  12
	, @Descuento = 0.2
	, @PrecioUnitario = 25.4
SELECT @Total

/***************************************************
COMENTARIOS
Al llamar a una UDF con EXECUTE no hace falta cualificar la funci�n
con el nombre del propietario.
Sin embargo, siempre es m�s eficiente cualificar los objetos usados,
ya que de este modo SQL Server no tiene que buscar primero entre los
objetos que pertenecen al usuario actual, antes de hacerlo con los
del usuario dbo.
****************************************************/

