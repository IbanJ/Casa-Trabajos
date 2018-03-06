SELECT 1 AS Tag, NULL AS Parent,
	customers.CustomerID AS [clientes!1!codCliente],
	customers.CompanyName AS [clientes!1!empresa],
	NULL AS [pedidos!2!codPedido!element],
	NULL AS [pedidos!2!orderdate!element],
	NULL AS [pedidos!2!shipName!element]
FROM customers
UNION ALL
SELECT 2 AS Tag, 1 AS Parent,
	customers.CustomerID,
	customers.CompanyName,
	orderid,
	OrderDate,
	ShipName
FROM Customers join Orders ON Customers.CustomerID=Orders.CustomerID
WHERE year(orders.OrderDate) = 1996
     AND month(orders.OrderDate) BETWEEN 7 AND 9
ORDER BY [clientes!1!codCliente], [clientes!1!empresa],
        [pedidos!2!codPedido!element], Tag
FOR XML EXPLICIT
