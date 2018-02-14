-- Recuperar los empleados que viven
-- en una ciudad en donde tenemos clientes
SELECT lastname,City
FROM employees
WHERE EXISTS 
        (SELECT *
         FROM customers
		 WHERE customers.City=employees.city
		 )