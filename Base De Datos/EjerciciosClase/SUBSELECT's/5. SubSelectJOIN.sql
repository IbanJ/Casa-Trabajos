USE Northwind
go
-- Visualizar los clientes que nos han
-- pedido más de 20 unidades del producto 23
select DISTINCT cli.companyname
       --,lineas.productid,lineas.Quantity
from "order details" as lineas
     JOIN orders as ped
	 ON lineas.OrderID=ped.OrderID
	 join Customers as cli
	 on ped.CustomerID=cli.CustomerID
where ProductID=23 and Quantity>20