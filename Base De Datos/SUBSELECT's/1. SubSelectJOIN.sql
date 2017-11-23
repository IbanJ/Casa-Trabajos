-- Visualizar los datos de los clientes
-- que est�n en una ciudad en donde
-- tenemos proveedores (tabla suppliers)

-- 1. Con SUBSELECT
SELECT CompanyName,city
FROM Customers
WHERE City IN (
                SELECT DISTINCT city
				FROM suppliers
			  )

-- 2. Con JOIN (combinaci�n)
SELECT customers.CompanyName,Customers.city
      ,Suppliers.CompanyName, suppliers.city
FROM customers JOIN suppliers
   ON customers.City = suppliers.city