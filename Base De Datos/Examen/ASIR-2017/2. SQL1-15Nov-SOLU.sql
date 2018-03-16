-- 1. 
SELECT alu.nombre, alu.apellido, notas.nota
FROM cole.alumnos as alu join cole.notas as notas
  on alu.id=notas.idalumno
WHERE notas.CODASIG='0483'

-- 2. 
SELECT asig.DESCRIPCION, count(notas.IDALUMNO) as aprobados
FROM cole.asignaturas as asig join cole.notas as notas
  on asig.CODASIG=notas.CODASIG 
     and asig.CODCURSO=notas.CODCURSO
     and asig.IDESPECIALIDAD=notas.IDESPECIALIDAD
WHERE notas.nota>=5
GROUP BY asig.IDESPECIALIDAD,asig.CODASIG,asig.CODCURSO,asig.DESCRIPCION
order by 1

-- 3. 
SELECT top 1 alumnos.nombre,alumnos.apellido
         ,AVG(notas.nota) as notaMedia
FROM cole.notas as notas join cole.alumnos as alumnos
  on notas.IDALUMNO=alumnos.id
where IDESPECIALIDAD='asir'
GROUP BY notas.IDALUMNO,alumnos.nombre,alumnos.apellido
order by AVG(notas.nota) desc

-- 4.
select notas.codasig, asig.DESCRIPCION, COUNT(*) as NoPresentados
from cole.notas as notas join cole.ASIGNATURAS as asig
   on asig.CODASIG=notas.CODASIG and asig.CODCURSO=notas.CODCURSO
     and asig.IDESPECIALIDAD=notas.IDESPECIALIDAD
where NOTA is null
group by notas.CODASIG, asig.DESCRIPCION

-- 5.
SELECT nombre,apellido,COUNT(Asig.CODASIG) as NumAsignaturas
FROM Cole.profesores as profe JOIN Cole.ASIGNATURAS as Asig
    ON profe.id=asig.IDPROFESOR
WHERE asig.IDPROFESOR=profe.id 
GROUP BY Nombre,apellido
HAVING COUNT(Asig.CODASIG)>1

-- 6.
select nombre,apellido
from cole.alumnos
where apellido like '%ra%' or apellido like '%ma%'

-- 7.
select *
from (
       --select alu.nombre,alu.apellido,AVG(notas.nota) as notaMedia
	   select alu.nombre,alu.apellido,notas.nota as nota
	   from cole.alumnos as alu join cole.notas as notas
			on alu.id=notas.IDALUMNO
	   where IDESPECIALIDAD='DAM' AND CODCURSO=2 
	   --group by notas.IDALUMNO, alu.nombre,alu.apellido
     ) as alum
--where notaMedia > (select AVG(notas.NOTA) ...
where nota > (select AVG(notas.NOTA)
				   from cole.notas as notas
				   where IDESPECIALIDAD='DAM' AND CODCURSO=2)


-- 8.
select espe.DENOMINACION,asig.DESCRIPCION,notas.CODCURSO,
       alu.nombre,alu.apellido,
	   notas.NOTA
from cole.ASIGNATURAS as asig join cole.notas as notas
     on asig.CODASIG=notas.CODASIG and asig.CODCURSO=notas.CODCURSO
     and asig.IDESPECIALIDAD=notas.IDESPECIALIDAD
  join cole.alumnos as alu
    on notas.IDALUMNO = alu.id
  join cole.especialidades as espe
    on espe.ID=asig.IDESPECIALIDAD
order by espe.DENOMINACION,asig.DESCRIPCION,notas.NOTA desc


-- 9.
select profe.nombre, COUNT(*)
from cole.alumnos as alu join cole.profesores as profe
  on alu.idTutor=profe.id
group by idTutor,profe.nombre

-- 10.
select top 3 with ties asig.DESCRIPCION,  COUNT(*) as suspensos
from cole.notas as notas join cole.ASIGNATURAS as asig
   on asig.CODASIG=notas.CODASIG and asig.CODCURSO=notas.CODCURSO
     and asig.IDESPECIALIDAD=notas.IDESPECIALIDAD 
where notas.NOTA<5
group by notas.IDESPECIALIDAD,notas.CODCURSO,notas.CODASIG, asig.DESCRIPCION
order by suspensos desc