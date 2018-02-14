USE Northwind
go
-- Visualizar el nombre de cada cliente
-- con cada uno de sus pedidos:
--     Codigo de pedido
--     fecha de pedido
SELECT cli.CompanyName,
       ped.OrderID,ped.OrderDate
FROM customers as cli JOIN orders as ped
   ON cli.CustomerID=ped.CustomerID

-- Con subconsultas correlacionadas
SELECT ( SELECT CompanyName
         FROM customers 
		 WHERE customerid=ped.customerid
       ),
     ped.OrderID,ped.OrderDate
FROM orders as ped