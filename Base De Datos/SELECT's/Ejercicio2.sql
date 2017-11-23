-- SELECT CON METACARACTERES
-- ************************************
-- Se debe usar el operador LIKE
-- Tenemos los siguientes caracteres
-- especiales: % _ [ ] ^

-- Recuperar a los clientes cuyo nombre
-- comienza con L
SELECT companyname
FROM customers
WHERE CompanyName LIKE 'L%'

-- Recuperar a los clientes cuyo nombre
-- termina con o
SELECT companyname
FROM customers
WHERE CompanyName LIKE '%o'

-- Recuperar a los clientes cuyo nombre
-- contiene los caracteres re
SELECT companyname
FROM customers
WHERE CompanyName LIKE '%re%'

-- Recuperar a los clientes cuyo nombre
-- comience por A y el cuarto caracter 
-- contenga la letra O
SELECT companyname
FROM customers
WHERE CompanyName LIKE 'A__O%'

-- Recuperar a los clientes cuyo nombre
-- comience por una vocal
SELECT companyname
FROM customers
WHERE CompanyName LIKE '[aeiou]%'
     OR CompanyName LIKE '[áéíóú]%'

-- Recuperar a los clientes cuyo primer caracter
-- sea una letra comprendida entre A y G,
-- el tercero una vocal y el último
-- un carácter comprendido entre k y s
SELECT companyname
FROM customers
WHERE CompanyName LIKE '[a-g]_[aeiou]%[k-s]'

-- Recuperar a los clientes cuyo último
-- carácter sea consonante
SELECT companyname
FROM customers
WHERE CompanyName LIKE '%[^aeiou]'

-- Recuperar a los clientes que contenganç
-- el caracter '
SELECT companyname
FROM customers
WHERE CompanyName LIKE '%''%' 