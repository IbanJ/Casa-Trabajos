-- Visualizar el importe total capturado en cada año

Select
from SalesLT.SalesOrderHeader as Importe
where DueDate=YEAR
group by Importe.DueDate(yy) 


-- Recuperar el numero de pedidos que han superado un importe facturado de 3000€.
SELECT count(*)
FROM SalesLT.SalesOrderHeader
WHERE TotalDue>3000

-- Recuperar el nombre del producto que se ha vendido mas veces

-- solucion 1
SELECT top 1 with ties producto.Name ,count(producto.ProductID), detalles.ProductID
FROM SalesLT.SalesOrderDetail AS detalles
	 JOIN SalesLT.Product as producto
	 on detalles.ProductID=producto.ProductID
group by detalles.ProductID, producto.Name
order by 2 desc

-- solucion 2(standard)

SELECT productid MAX(numero)
FROM
(select COUNT(*) AS numero
from SalesLT.SalesOrderDetail
group by ProductID) as tabla

-- Recuperar los datos de la ciudad en la que mas vendemos en el mes de junio

SELECT top 1 dir.city
FROM SalesLT.SalesOrderHeader as ped
  join SalesLT.Customer as cli
  on ped.CustomerID=cli.CustomerID
  join SalesLT.CustomerAddress as clidir
  on cli.CustomerID=clidir.CustomerID
  join SalesLT.Address as dir
  on clidir.AddressID=dir.AddressID
  where month(ped.orderdate)=6
  group by dir.City 
  order by sum(ped.TotalDue) desc

 

-- Recuperar los nombres de las provincias en donde tenemos mas de dos clientes

SELECT dir.StateProvince
FROM SalesLT.Customer as cli
  join SalesLT.CustomerAddress as clidir
  on cli.CustomerID=clidir.CustomerID
  join SalesLT.Address as dir
  on clidir.AddressID=dir
  group by dir.StateProvince
  having count(*)>2

-- Visualizar la media del numero de lineas de pedido por pedido

select avg(numlineas)
from
	(select count(*) as numLineas
	from SalesLT.SalesOrderDetail as lineas
	group by lineas.SalesOrderID) as