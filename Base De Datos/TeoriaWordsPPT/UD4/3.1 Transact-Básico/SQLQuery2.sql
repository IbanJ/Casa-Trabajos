USE AdventureWorks; 
GO 
SELECT 'El pedido se debe pagar el ' + CONVERT(varchar(12), DueDate, 101) 
FROM Sales.SalesOrderHeader
WHERE SalesOrderID = 50001; 
GO
