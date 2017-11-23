-- Visualizar los datos de los clientes
-- con el numero de pedidos realizados

-- 1. Con tabla derivada
SELECT customers.CompanyName,
       pedidosClientes.numPedidos
FROM customers JOIN
     (
	    select CustomerID,count(*) as numPedidos
		from orders
		GROUP BY customerid
	 ) as pedidosClientes
ON Customers.CustomerID=pedidosClientes.CustomerID

-- 2. Con JOIN
SELECT customers.CompanyName, count(*)      
FROM customers JOIN orders
ON Customers.CustomerID=orders.CustomerID
group by customers.CompanyName