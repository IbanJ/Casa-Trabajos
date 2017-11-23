select categoryname,productname
from categories JOIN products
    ON categories.CategoryID =products.CategoryID


SELECT DISTINCT emp.employeeid, emp.FirstName  NOMBRE
       , region.RegionDescription
FROM employees EMP JOIN EmployeeTerritories EMPTER
     ON emp.EmployeeID=empter.EmployeeID
	 JOIN Territories TER
	 ON EMPTER.TerritoryID=TER.TerritoryID
	 JOIN Region
	 ON TER.RegionID = region.RegionID


SELECT Orders.OrderID, ORDERS.OrderDate, 
       EMPLOYEES.FirstName
FROM ORDERS JOIN EMPLOYEES 
   ON ORDERS.EmployeeID=Employees.EmployeeID
WHERE YEAR(ORDERDATE)=1996
