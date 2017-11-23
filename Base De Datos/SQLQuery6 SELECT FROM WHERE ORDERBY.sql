-- Iniciaci�n de sentencias SELECT (SQL)

-- Formato B�sico
SELECT *
FROM Customers

-- Formato con especificacion de columnas
SELECT	CompanyName,City,Country
FROM customers

-- Formato con filtro de filas
SELECT companyname,city
FROM customers
WHERE city = 'London'

-- Formato con ordenacion de filas
SELECT companyname,country,city
FROM customers
WHERE Country = 'USA'
ORDER BY city desc