
--Con TOP 1

SELECT TOP 1 per.FirstName,per.LastName,ventas.SalesLastYear
FROM AdventureWorks2014.Sales.SalesPerson as Ventas
	JOIN AdventureWorks2014.HumanResources.Employee as Empleado
	ON ventas.BusinessEntityID=Empleado.BusinessEntityID
	JOIN AdventureWorks2014.person.Person as per
	ON per.BusinessEntityID=Empleado.BusinessEntityID
WHERE Ventas.TerritoryID=1
ORDER BY 3 DESC

-- Sin TOP 1 (Standard ANSI)

SELECT per.FirstName,per.LastName,ventas.SalesLastYear
FROM AdventureWorks2014.Sales.SalesPerson as Ventas
	JOIN AdventureWorks2014.HumanResources.Employee as Empleado
	ON ventas.BusinessEntityID=Empleado.BusinessEntityID
	JOIN AdventureWorks2014.person.Person as per
	ON per.BusinessEntityID=Empleado.BusinessEntityID
WHERE Ventas.TerritoryID=1
	AND Ventas.SalesLastYear =
		(
			SELECT MAX(SalesLastYear)
			FROM AdventureWorks2014.Sales.SalesPerson
			WHERE TerritoryID=1
		)
	
