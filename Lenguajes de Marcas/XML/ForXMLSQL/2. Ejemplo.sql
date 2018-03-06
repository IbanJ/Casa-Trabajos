-- Consultamos los clientes con los pedidos
-- realizados en el tercer trimestre del año 1996
-- con la finalidad de llevar a cabo una exportacion de XML universal
select Customers.CustomerID,CompanyName
      ,orders.OrderID, orders.OrderDate
from Customers join Orders
   ON Customers.CustomerID=Orders.CustomerID
WHERE year(orders.OrderDate) = 1996
  AND month(orders.OrderDate) BETWEEN 7 AND 9