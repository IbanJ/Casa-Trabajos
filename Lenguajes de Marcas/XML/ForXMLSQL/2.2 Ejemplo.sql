-- Clientes con pedido y con lineas de pedido
-- sacar informacion de lineas de pedidos
-- cod de producto, Precio y la Cantidad.
SELECT 1 AS Tag, NULL AS Parent,
	customers.CustomerID AS [clientes!1!codCliente],
	customers.CompanyName AS [clientes!1!empresa],
	NULL AS [pedidos!2!codPedido!element],
	NULL AS [pedidos!2!orderdate!element],
	NULL AS [pedidos!2!shipName!element],
	NULL AS [lineas!3!codProducto!element],
	NULL AS [lineas!3!precio!element],
	NULL AS [lineas!3!cantidad!element]
FROM customers
UNION ALL
SELECT 2 AS Tag, 1 AS Parent,
	customers.CustomerID,
	customers.CompanyName,
	orders.orderid,
	OrderDate,
	ShipName,
	NULL, NULL, NULL
From Orders join Customers
	on Customers.CustomerID=Orders.CustomerID
UNION ALL
SELECT 3 AS Tag, 2 AS Parent,
	customers.CustomerID,
	customers.CompanyName,
	orders.orderid,
	OrderDate,
	ShipName,
	productId,
    UnitPrice,
	Quantity

FROM Customers join Orders ON Customers.CustomerID=Orders.CustomerID
	JOIN "Order Details" as lineas on orders.OrderID=lineas.OrderID
WHERE year(orders.OrderDate) = 1996
     AND month(orders.OrderDate) BETWEEN 7 AND 9
ORDER BY [clientes!1!codCliente], [clientes!1!empresa],
        [pedidos!2!codPedido!element], Tag
FOR XML EXPLICIT