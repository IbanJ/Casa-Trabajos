-- BD Adventureworks2014

-- 1. Recuperar de la tabla SalesOrderHeader
-- las columnas SalesOrderId, orderDate, Duedate
-- y ToltalDue correspondientes al pedido cuyo
-- SalesOrderId es 43692 y ademas las lineas del pedido
-- con los siguientes datos:
--		salesOrderDetailID, productID (NOMBRE DEL PRODUCTO) 
--		,Orderqty, 
--		unitPrice, totalDue
SELECT pedidos.Salesorderid, orderdate, duedate, totaldue,salesOrderDetailID, 
		productID, orderqty,unitPrice, totalDue
FROM sales.SalesOrderHeader as pedidos
	Join sales.SalesOrderDetail as lineas
	ON pedidos.SalesOrderID=lineas.SalesOrderID
	JOIN Production.Product as productos
	ON lineas.ProductID=productos.ProductID
WHERE pedidos.SalesOrderID=43692