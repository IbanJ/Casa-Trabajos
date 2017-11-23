-- Recuperar el numero de productos
-- de la categoria 1
SELECT *
FROM products
WHERE CategoryID=1

-- Recuperar el numero de empleados
-- que nacieron antes del a�o 1960
SELECT COUNT(*)
FROM employees
WHERE BirthDate<'01/01/1960'

-- Recuperar el numero de productos
-- de cada categoria 
SELECT categoryid,count(*)
FROM products
group by CategoryID

-- Utilizamos la BD AdventureWorks2014
-- Recuperar el n�mero de personas
-- de cada sexo
SELECT gender,count(*)
FROM HumanResources.Employee
group by gender

-- Utilizamos la BD AdventureWorks2014
-- Recuperar el n�mero de empleados
-- por a�o de nacimiento sacando en 
-- un orden basado en el numero de 
-- empleados

SELECT Year(birthdate) as [A�o], count(*)
FROM HumanResources.Employee
GROUP BY Year(birthdate)
ORDER BY count(*) desc

-- Utilizamos la BD AdventureWorks2014
-- Recuperar el n�mero de empleados
-- cuyo puesto es 'Marketing Assistant'
-- por a�o de nacimiento sacando en 
-- un orden basado en el numero de 
-- empleados

SELECT Year(birthdate) as [A�o], count(*)
FROM HumanResources.Employee
WHERE JobTitle='Marketing Assistant'
GROUP BY Year(birthdate)
ORDER BY count(*) desc