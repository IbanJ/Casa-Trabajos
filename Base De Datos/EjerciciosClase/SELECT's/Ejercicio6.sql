SELECT customers.CustomerID,CompanyName,city -- customers
       ,orderid,orderdate          -- orders
FROM CUSTOMERS JOIN orders
     ON customers.CustomerID=orders.customerid
order by customers.customerid