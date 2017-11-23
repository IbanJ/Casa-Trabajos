
-- 1
SELECT alums.nombre,alums.apellido,notas.nota
FROM cole.alumnos as alums
	JOIN cole.notas as notas
	on alums.id=notas.idalumno
	join cole.ASIGNATURAS as asigs
	on asigs.idespecialidad=notas.idespecialidad
	and	asigs.codcurso=notas.codcurso
		and asigs.codasig=notas.codasig
where asigs.codasig='0483'

-- 2
SELECT asigs.codasig,asigs.DESCRIPCION,count(asigs.notamedia)
from cole.ASIGNATURAS as asigs
where asigs.notamedia>=5
group by asigs.descripcion,asigs.codasig
-- 3
SELECT TOP 1 alums.nombre,alums.apellido,AVG(notas.NOTA) as notaMedia
FROM cole.alumnos as alums
	JOIN cole.notas as notas
	on alums.id=notas.idalumno
	join cole.ASIGNATURAS as asigs
	on asigs.idespecialidad=notas.idespecialidad
	and	asigs.codcurso=notas.codcurso
	and asigs.codasig=notas.codasig
where asigs.IDESPECIALIDAD='ASIR'
GROUP BY notas.IDALUMNO,alums.nombre,alums.apellido
order by AVG(notas.NOTA) desc
-- 4
SELECT asigs.CODASIG, count(NUMALUMNOS) as nulls
FROM cole.alumnos as alums
	JOIN cole.notas as notas
	on alums.id=notas.idalumno
	join cole.ASIGNATURAS as asigs
	on asigs.idespecialidad=notas.idespecialidad
	and	asigs.codcurso=notas.codcurso
	and asigs.codasig=notas.codasig 
where NOTA is null
group by asigs.CODASIG


select * from cole.ASIGNATURAS




-- 5
SELECT profes.id,profes.nombre,profes.apellido,count(asigs.CODASIG) as cuenta
from cole.alumnos as alums
	JOIN cole.notas as notas
	on alums.id=notas.idalumno
	join cole.ASIGNATURAS as asigs
	on asigs.idespecialidad=notas.idespecialidad
	and	asigs.codcurso=notas.codcurso
	and asigs.codasig=notas.codasig
	join cole.profesores as profes
	on asigs.IDPROFESOR=profes.id
where profes.id=asigs.IDPROFESOR 
group by profes.id,profes.nombre,profes.apellido
HAVING COUNT(asigs.CODASIG)>1
-- 6
SELECT nombre,apellido
FROM cole.alumnos
where apellido like '%ra%' 
	or apellido like '%ma%'
-- 7
select *
from (
		-- select alu.nombre,alu.apellido,AVG(notas.nota) as notaMedia
		select alu.nombre,alu.apellido,notas.nota as nota
		from cole.alumnos as alu join cole.notas as notas
			on alu.id=notas.IDALUMNO
		WHERE IDESPECIALIDAD='DAM' AND CODCURSO=2
		-- group by notas.IDALUMNO, alu.nombre,alu.apellido
		) as alum

-- 8
SELECT esp.DENOMINACION,asigs.DESCRIPCION,
	   notas.CODCURSO,alums.nombre,alums.apellido,notas.NOTA
from  cole.alumnos as alums
	JOIN cole.notas as notas
	on alums.id=notas.idalumno
	join cole.ASIGNATURAS as asigs
	on asigs.idespecialidad=notas.idespecialidad
	and	asigs.codcurso=notas.codcurso
	and asigs.codasig=notas.codasig
	join cole.profesores as profes
	on asigs.IDPROFESOR=profes.id
	join cole.especialidades as esp
	on esp.id=asigs.IDESPECIALIDAD
group by esp.DENOMINACION,asigs.DESCRIPCION,
	   notas.CODCURSO,alums.nombre,alums.apellido,notas.NOTA
order by NOTA desc

-- 9
SELECT alums.idTutor,profes.nombre,profes.apellido,count(*) as cuenta
FROM cole.alumnos as alums
	 join cole.profesores as profes
	 on alums.idTutor=profes.id
GROUP BY alums.idTutor,profes.nombre,profes.apellido
order by cuenta desc
-- 10
SELECT
FROM


select * from cole.alumnos
