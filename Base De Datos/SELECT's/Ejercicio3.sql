-- Recuperar el numero de productos
-- de la categoria 1
SELECT COUNT(*)
FROM products
WHERE CategoryID=1

-- Recuperar el numero de empleados 
-- que nacieron antes del año 1960
SELECT COUNT(*)
FROM employees
--WHERE BirthDate<'01/01/1960'
WHERE year(BirthDate) < 1960

-- Recuperar el numero de productos
-- de cada categoria 
SELECT categoryid,count(*)
FROM products
group by CategoryID

-- Utilizamos la BD AdventureWorks2014
-- Recuperar el número de empleados
-- de cada sexo
SELECT gender,count(*)
FROM HumanResources.Employee
group by gender

-- Utilizamos la BD AdventureWorks2014
-- Recuperar el número de empleados
-- por año de nacimiento sacándo en
-- un orden (descendente) basado en 
-- el numero de empleados
SELECT Year(birthdate) as Agno, count(*) as Numero
FROM HumanResources.Employee
GROUP BY Year(birthdate)
ORDER BY count(*) DESC

-- Utilizamos la BD AdventureWorks2014
-- Recuperar el número de empleados
-- cuyo puesto es 'Marketing Assistant'
-- por año de nacimiento sacándo en
-- un orden (descendente) basado en 
-- el numero de empleados
SELECT Year(birthdate) as Agno, count(*) as Numero
FROM HumanResources.Employee
WHERE JobTitle='Marketing Assistant'
GROUP BY Year(birthdate)
ORDER BY count(*) DESC


