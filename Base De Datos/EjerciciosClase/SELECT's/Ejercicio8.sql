-- BD Adventureworks2014

-- 1. Recuperar de la tabla SalesOrderHeader
--    las columnas SalesOrderId, OrderDate, Duedate
--    y TotalDue correspondientes al pedido cuyo
--    SalesOrderId es 43692 y ademas las lineas del pedido
--    con los siguientes datos:
--        salesOrderDetailId, productId, OrderQty,
--        UnitPrice,TotalDue
SELECT pedidos.SalesOrderId, OrderDate, Duedate, TotalDue,
      salesOrderDetailId, productId, OrderQty, UnitPrice,TotalDue
FROM SALES.SalesOrderHeader as pedidos
   JOIN sales.SalesOrderDetail as lineas
   ON pedidos.SalesOrderID=lineas.SalesOrderID
WHERE lineas.SalesOrderID=43692