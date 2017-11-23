USE Northwind
go
-- Visualizar cada producto con el
-- codigo de producto y la cantidad
-- maxima que se ha pedido de dicho producto
select productid,quantity
from "Order Details" as lineas1
where quantity = 
       (select max(quantity)
		from "Order Details" as lineas2
        WHERE lineas2.ProductID = lineas1.Productid)