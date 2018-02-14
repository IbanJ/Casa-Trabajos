SELECT customers.CustomerID,CompanyName,city -- customers
		,orderid,orderdate		   -- orders
FROM CUSTOMERS JOIN orders
	 on customers.customerID=orders.customerid
order by customers.customerid