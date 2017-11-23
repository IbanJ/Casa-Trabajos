-- EJERCICIO 1 DE SELECT's
-- Northwind

/*
   Recuperar el nombre y la ciudad de todos
   los clientes que contengan en su nombre 
   los caracteres 'RA'
*/ 
SELECT CompanyName,City
FROM Customers
WHERE CompanyName LIKE '%ra%'


/*
   Recuperar el nombre y la ciudad de todos
   los clientes que comiencen con el carácter 'B'
*/
SELECT Companyname, City
FROM Customers
WHERE CompanyName LIKE 'B%'

/*
   Recuperar el nombre y la ciudad de todos
   los clientes que comiencen con cualquier
   carácter siendo el segundo 'A', el tercero
   cualquier carácter y el cuarto 'I'
*/
SELECT companyname, city
FROM CUSTOMERS
WHERE CompanyName LIKE '_A_I%'

/*
   Recuperar el nombre y la ciudad de todos
   los clientes que comiencen con un caracter
   entre 'D' y 'H' siendo el segundo y el tercero
   cualquier carácter y el cuarto una vocal.
*/
SELECT companyname, city
FROM CUSTOMERS
WHERE CompanyName LIKE '[D-H]__[aeiou]%'

/*
   Recuperar el nombre y la ciudad de todos
   los clientes que NO comiencen con un caracter
   entre 'D' y 'H' siendo el segundo y el tercero
   cualquier carácter y el cuarto una consonante.
*/
SELECT CompanyName, city
FROM CUSTOMERS
WHERE CompanyName LIKE '[^D-H]__[^aeiou]%'