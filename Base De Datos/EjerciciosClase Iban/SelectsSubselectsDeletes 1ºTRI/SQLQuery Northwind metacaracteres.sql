-- SELECT CON METACARACTERES
-- *********************************
-- Se debe usar el operador LIKE
-- Tenemos los siguientes caracteres
-- especiales: % _ [ ] ^

-- Recuperar a los clientes cuyo nombre
-- comienza con L
SELECT CompanyName
FROM customers
WHERE CompanyName LIKE 'L%'

-- Recuperar a los clientes cuyo nombre
-- termina con L
SELECT CompanyName
FROM customers
WHERE CompanyName LIKE '%o'

-- Recuperar a los clientes cuyo nombre
-- contiene los caracteres re
SELECT CompanyName
FROM customers
WHERE CompanyName LIKE '%re%'

-- Recuperar a los clientes cuyo nombre
-- comience por A y el cuarto caracter
-- contenga la letra O
SELECT CompanyName
FROM customers
WHERE CompanyName LIKE 'A__O%'

-- Recuperar a los clientes cuyo nombre
-- comience por una vocal
SELECT CompanyName
FROM customers
WHERE CompanyName LIKE '[aeiou]%'
	 OR CompanyName LIKE '[�����]%'

-- Recuperar a los clientes cuyo primer caracter
-- sea una letra comprendida entre A y G,
-- el tercero una vocal y el �ltimo
-- una caracter comprendido entre K y S
SELECT CompanyName
FROM customers
WHERE CompanyName LIKE '[a-g]_[aeiou]%[k-s]'

-- Recuperar a los clientes cuyo ultimo
-- caracter sea consonante
SELECT CompanyName
FROM customers
WHERE CompanyName LIKE '%[^aeiou]'

-- Recuperar a los clientes que contengan
-- el caracter '
SELECT CompanyName
FROM customers
WHERE CompanyName LIKE '%?''%' ESCAPE '?'

