select categoryname,productname
from Categories JOIN products
	ON Categories.CategoryID =Products.CategoryID


SELECT emp.FirstName as nombre, Region.RegionDescription
FROM employees EMP JOIN EmployeeTerritories EMPTER
	ON emp.EmployeeID=empter.employeeID
	JOIN Territories TER
	ON EMPTER.TerritoryID=TER.TerritoryID
	JOIN Region
	ON ter.RegionID=region.RegionID

--	codigo de pedido, fecha de pedido y nombre del empleado que ha tramitado el pedido del año 1996
SELECT Orders.orderID, ORDERS.ORDERDATE, EMPLOYEES.FIRSTNAME
FROM Employees JOIN orders
ON ORDERS.EmployeeID=Employees.EmployeeID
WHERE YEAR(ORDERDATE)=1996