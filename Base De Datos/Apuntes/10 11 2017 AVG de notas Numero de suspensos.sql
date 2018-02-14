-- Sacar la nota media de cada especialidad

SELECT IDESPECIALIDAD,espe.DENOMINACION, AVG(NOTA) 
FROM cole.notas notas join cole.especialidades espe
	on notas.IDESPECIALIDAD=espe.ID
group by IDESPECIALIDAD,espe.DENOMINACION

-- La funcion agregada AVG no cuenta los nulls,
-- pero la funcion agregada de COUNT si que cuenta los nulls
-- en caso de que tenga (*), si escribimos COUNT(nota) tampoco contaria los nulls


-- los diez alumnos de ASIR con mejores notas SU NOMBRE Y LA CIUDAD
SELECT top 10 with ties alumnos.nombre,alumnos.ciudad,
			  notas.NOTA
FROM COLE.notas notas
JOIN cole.alumnos alumnos
on notas.IDALUMNO=alumnos.id
where IDESPECIALIDAD='ASIR'
ORDER BY NOTA desc	

-- los datos de cada profesor con el numero de alumnos que tutela

select * from cole.alumnos


select profes.nombre,profes.apellido,profes.ciudad,count(idTutor) as AlumsTutelados
from cole.alumnos alums
	join cole.profesores profes
	on profes.id=alums.idTutor
group by idTutor,profes.nombre,profes.ciudad,profes.apellido

-- los datos de cada asignatura con el numero de suspensos
select * from cole.notas


select asigs.DESCRIPCION,count(*) as fails
		,asigs.NUMALUMNOS
		,count(*)*1.0/asigs.NUMALUMNOS as percent
from cole.notas as notas 
	join cole.ASIGNATURAS asigs
	on asigs.CODASIG=notas.CODASIG
where NOTA<5
group by notas.CODASIG,asigs.DESCRIPCION,asigs.NUMALUMNOS



