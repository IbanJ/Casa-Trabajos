-- Cada color con el numero de productos de ese color

SELECT Count(Color), Color
FROM SalesLT.Product as Producto
WHERE COLOR IS NOT NULL
group by Color

-- El nombre de cada categoria de productos
--  y el precio medio de todo los productos de esa categoria

SELECT ProductoCategoria.Name, AVG(Producto.ListPrice)
FROM SalesLT.ProductCategory as ProductoCategoria 
	 JOIN SalesLT.Product as Producto
	 ON Producto.ProductCategoryID=ProductoCategoria.ProductCategoryID
Group by ProductoCategoria.Name

-- Sacar el nombre del cliente con mayor importe de factura acumulado.

SELECT top 1 cli.FirstName,ped.CustomerID, SUM(totaldue) as theMoney
FROM SalesLT.SalesOrderHeader as PED
 join SalesLT.Customer as cli
 on cli.CustomerID=ped.CustomerID
group by ped.CustomerID,cli.FirstName
ORDER BY sum(totaldue) desc