-- Sacar la nota media de cada especialidad

SELECT IDESPECIALIDAD,espe.DENOMINACION, AVG(NOTA) 
FROM cole.notas notas join cole.especialidades espe
	on notas.IDESPECIALIDAD=espe.ID
group by IDESPECIALIDAD,espe.DENOMINACION

-- La funcion agregada AVG no cuenta los nulls,
-- pero la funcion agregada de COUNT si que cuenta los nulls
-- en caso de que tenga (*), si escribimos COUNT(nota) tampoco contaria los nulls
-- 
