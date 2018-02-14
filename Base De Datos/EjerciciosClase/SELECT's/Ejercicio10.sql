-- Recuperar el numero de empleados
-- que son jefes, excluyendo al superjefe

SELECT COUNT(DISTINCT REPORTSTO)
FROM EMPLOYEES
WHERE REPORTSTO IS NOT NULL

SELECT COUNT(*)
FROM 
  (
	select DISTINCT reportsto
	from Employees
	WHERE REPORTSTO IS NOT NULL
  ) AS datos



