-- Visualizar los datos de los clientes
-- que estan en una ciudad en donde
-- tenemos proveedores (tabla suppliers)
-- 1. Con SUBSELECT

SELECT CompanyName,city
FROM Customers
WHERE City IN (
				SELECT DISTINCT city
				FROM suppliers
				)

-- 2. Con JOIN (combinacion)
SELECT customers.CompanyName,customers.city
	  ,Suppliers.CompanyName, Suppliers.City
FROM customers JOIN suppliers
	ON customers.City = suppliers.city
-- Visualizar los datos de los clientes
-- con el numero de pedidos realizados

-- 1. Con tabla derivada

SELECT Customers.CompanyName,
	   pedidosClientes.numPedidos
FROM customers JOIN
	(
		select customerID,count(*) as numPedidos
		from orders
		GROUP BY customerID
	) as pedidosClientes
ON Customers.CustomerID=pedidosClientes.CustomerID

-- Visualizar los datos de los clientes
-- con el numero de pedidos realizados

-- 2. Con JOIN

SELECT customers.CompanyName, count(*)
FROM customers JOIN orders
ON Customers.CustomerID=orders.CustomerID
GROUP BY customers.CompanyName

-- Visualizar los datos de los clientes
--

SELECT companyname
FROM customers





