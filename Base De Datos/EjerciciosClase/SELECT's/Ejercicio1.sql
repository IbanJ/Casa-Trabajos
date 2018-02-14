-- Recuperar el nombre de los productos,
-- y el valor de su Stock
SELECT ProductName, 
       UnitPrice*UnitsInStock as importe
FROM products

-- Recuperar el nombre de los productos,
-- y el valor de su Stock pero solo de
-- los que superan los 1000$
SELECT ProductName, 
       UnitPrice*UnitsInStock as importe
FROM products
WHERE UnitPrice*UnitsInStock>1000

-- Sacar los datos de los clientes de 
-- Londres o de Madrid
SELECT CompanyName,city
FROM customers
WHERE city='London' OR city='Madrid'
ORDER BY City DESC

-- Otra alternativa para la consulta anterior
SELECT CompanyName,city
FROM customers
WHERE city IN ('London','Madrid')
ORDER BY City DESC

-- Recuperar los productos cuyo precio
-- este entre 100 y 200
SELECT ProductName,UnitPrice
FROM products
WHERE UnitPrice >= 100 AND UnitPrice<=200

-- Otra alternativa para la consulta anterior
SELECT ProductName,UnitPrice
FROM products
WHERE UnitPrice BETWEEN 100 AND 200

-- Recuperar los datos de los empleados
-- que nacieron en la década de los 60
SELECT lastname,BirthDate
FROM employees
WHERE BirthDate>='01/01/1960' 
   AND BirthDate<='31/12/1969'

-- Otra alternativa a la anterior
SELECT lastname,BirthDate
FROM employees
WHERE year(BirthDate)>=1960 
   AND year(BirthDate)<=1969