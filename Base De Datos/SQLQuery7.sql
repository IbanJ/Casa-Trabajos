-- Recuperar el numero de productos
-- de la categoria 1
SELECT *
FROM products
WHERE CategoryID=1

-- Recuperar el numero de empleados
-- que nacieron antes del año 1960
SELECT COUNT(*)
FROM employees
WHERE BirthDate<'01/01/1960'

-- Recuperar el numero de productos
-- de cada categoria 
SELECT categoryid,count(*)
FROM products
group by CategoryID

-- Utilizamos la BD AdventureWorks2014
-- Recuperar el número de personas
-- de cada sexo
SELECT gender,count(*)
FROM HumanResources.Employee
group by gender

-- Utilizamos la BD AdventureWorks2014
-- Recuperar el número de empleados
-- por año de nacimiento sacando en 
-- un orden basado en el numero de 
-- empleados

SELECT Year(birthdate) as [Año], count(*)
FROM HumanResources.Employee
GROUP BY Year(birthdate)
ORDER BY count(*) desc

-- Utilizamos la BD AdventureWorks2014
-- Recuperar el número de empleados
-- cuyo puesto es 'Marketing Assistant'
-- por año de nacimiento sacando en 
-- un orden basado en el numero de 
-- empleados

SELECT Year(birthdate) as [Año], count(*)
FROM HumanResources.Employee
WHERE JobTitle='Marketing Assistant'
GROUP BY Year(birthdate)
ORDER BY count(*) desc