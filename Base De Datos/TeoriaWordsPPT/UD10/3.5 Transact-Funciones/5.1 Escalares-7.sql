/***************************************************
USO DE COLUMNAS COMO PARÁMETROS EN UNA LLAMADA
A UNA FUNCIÓN DEFINIDA POR EL USUARIO
****************************************************/
USE AdventureWorks
GO

-- Utilización de la función ImporteTotal para obtener 
-- información de la tabla "Sales.SalesOrderDetail"
SELECT SalesOrderID
	, ProductID
	, dbo.ImporteTotal(OrderQty, UnitPrice, UnitPriceDiscount) AS Total
FROM Sales.SalesOrderDetail
WHERE ProductID = 760

/***************************************************
LLAMADA A FUNCIONES CON EXECUTE
En las llamadas se pueden omitir aquellos parámetros que tengan
un valor predeterminado y modificar el orden de los parámetros, 
siempre que la llamada a la función sea con el nombre de los 
parámetros (nominada)
****************************************************/
USE AdventureWorks
GO

--Declaramos una variable para guardar el resultado de la UDF
DECLARE @Total money

-- Utilizamos EXECUTE y suministramos valores para todos los parámetros
EXECUTE @Total = dbo.ImporteTotal 12, 25.4, 0.0
SELECT @Total

-- Usamos EXECUTE y omitimos el parámetro @Descuento
-- ya que tiene valor predeterminado
EXECUTE @Total = dbo.ImporteTotal 12, 25.4
SELECT @Total

-- Usamos EXECUTE y omitimos el nombre del propietario de la UDF 
-- ya que está predeterminado para dbo.
EXECUTE @Total = ImporteTotal 12, 25.4
SELECT @Total

-- Usamos EXECUTE y suministramos valores para cada parámetro
-- indicando los nombres de parámetro
EXECUTE @Total = ImporteTotal
	  @Cantidad = 12
	, @PrecioUnitario = 25.4
	, @Descuento = 0.2
SELECT @Total

-- Usamos EXECUTE y suministramos valores para todos los parámetros
-- especificando los parámetros en orden y con nombre en cualquier orden
EXECUTE @Total = ImporteTotal 
	  12
	, @Descuento = 0.2
	, @PrecioUnitario = 25.4
SELECT @Total

/***************************************************
COMENTARIOS
Al llamar a una UDF con EXECUTE no hace falta cualificar la función
con el nombre del propietario.
Sin embargo, siempre es más eficiente cualificar los objetos usados,
ya que de este modo SQL Server no tiene que buscar primero entre los
objetos que pertenecen al usuario actual, antes de hacerlo con los
del usuario dbo.
****************************************************/

