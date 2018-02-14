/***************************************************
TRIGGER para garantizar un tipo complejo de unicidad

Imaginemos una tabla Employees y necesitamos almacenar el N� de carnet de conducir
del empleado y como no todos los empleados conducen, esta columna debe permitir
valores NULL.
Sin embargo, queremos garantizar que en esta columna haya unicidad, ya que dos empleados 
no pueden tener el mismo n�mero de licencia de conducir.
Veamos las diversas formas de hacer cumplir esta regla:
	1- No podemos crear una restricci�n UNIQUE porque puede haber m�s de un empleado 
	   sin carnet de conducir. Las restricciones UNIQUE solo aceptan un valor NULL
	   en la columna de la tabla.
	2- No podemos crear una restricci�n CHECK para controlar si ya existe el mismo
	   valor en alguna otra fila de la tabla, porque las restricciones CHECK no 
	   pueden acceder a otras filas en la misma tabla.
	3- No podemos crear un objeto RULE, porque estos objetos solo controlan los valores en
	   la columna seleccionada y en la fila afectada.
	4- Podemos crear un procedimiento almacenado que inserte los datos en la tabla y
	   controlar la unicidad del valor dentro del procedimiento. En este caso necesitamos 
	   dos procedimientos:
			- uno para insertar datos.
			- otro para modificarlos.
	   Como estos dos procedimientos son lo �nico que garantiza el cumplimiento de esta
	   regla, debemos asegurarnos de que las aplicaciones cliente solo inserten o modifiquen
	   los datos de los empleados a trav�s de estos procedimientos. Pero los admininistradores
	   pueden modificar las tablas directamente y de ese modo violar esta regla de negocio.
	5- Podemos crear un trigger que controle la unicidad del valor que se va a insertar y 
	   aceptar o rechazar la entrada. Esta ser�a la soluci�n m�s razonable y la que
	   exponemos en el c�digo.
****************************************************/

USE Northwind
GO

-- A�adimos una columna llamada NoConductor a la tabla Employees

ALTER TABLE Employees
ADD NoConductor varchar(15) NULL
GO

-- Creamos el trigger para chequear
-- la unicidad en la columna NoConductor 

CREATE TRIGGER isrEmployees
ON Employees
FOR INSERT, UPDATE
AS
--Nos aseguramos de que la actualizaci�n se ha hecho en el campo 
--N�conductor
	IF UPDATE (NoConductor)

--No queremos permitir que haya m�s de un conductor con el mismo numero de 
--carnet de conducir, por lo que si existe un numero de conductor igual al 
--que queremos modificar no se aceptar� el cambio.

		IF EXISTS (
			SELECT NoConductor, COUNT(*)
			FROM Employees
			WHERE NoConductor IS NOT NULL
				AND NoConductor IN (
					SELECT DISTINCT NoConductor
					FROM Inserted
					)
			GROUP BY NoConductor
			HAVING COUNT(*) > 1
			)
		BEGIN
			RAISERROR ('N� de carnet de conducir no v�lido, INSERT o UPDATE cancelada', 16, 1)
			ROLLBACK TRAN
		END
GO

-- Este mandato tiene �xito

UPDATE Employees
SET NoConductor = '74914173'
WHERE EmployeeID = 5

-- Este mandato falla
-- El n�mero de carnet no es �nico

UPDATE Employees
SET NoConductor = '74914173'
WHERE EmployeeID = 6

-- Este mandato falla
-- Se intenta insertar un carnet repetido

UPDATE Employees
SET NoConductor = '74914175'
WHERE EmployeeID BETWEEN 6 AND 10

-- Inicializamos a NULL ya que los valores NULL no los 
-- tenemos en consideraci�n en el trigger

UPDATE Employees
SET NoConductor = NULL

/* **************************************************************************************
COMENTARIOS
Los triggers no suponen una gran carga de trabajo para SQL Server.
Los triggers se ejecutan siempre dentro de la transacci�n que los activa.
Cuidado con la sentencia ROLLBACK TRANSACTION (cancela todas las acciones de la transacci�n).
****************************************************************************************/
