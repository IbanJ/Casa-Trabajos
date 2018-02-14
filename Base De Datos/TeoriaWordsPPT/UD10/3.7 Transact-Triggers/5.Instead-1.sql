/***************************************************
DESENCADENADORES INSTEAD OF
Existen dos tipos de triggers:
	- INSTEAD OF: se activan en lugar de la acción original, antes de que
	              tenga lugar la modificación del objeto base.
	- AFTER: se activan inmediatamente después de la modificación de los
			 datos de la tabla base.
Una tabla puede tener un número ilimitado de triggers AFTER para cada
acción peros solo un trigger INSTEAD OF por acción.
Las vistas solo pueden tener triggers INSTEAD OF.

Estos triggers se activan antes de la ejecución de la acción. También se
puede acceder a las tablas virtuales INSERTED y DELETED.
Cuando comienza la ejecución de este tipo de triggers la tabla base
no ha sufrido aún modificaciones. En el caso de una acción INSERT, la 
tabla INSERTED contendrá los valores predeterminados de las columnas 
que tengan definida la propiedad DEFAULT y no contendrá los valores 
correspondientes a la propiedad IDENTITY.
Durante la ejecución del código aún no se ha efectuado el control de las 
restricciones por lo que pueden ser usados para controlar la entrada de datos
como restricciones CHECK mucho más complejas.
Para modificar los datos en una tabla se pueden usar las instrucciones INSERT, 
UPDATE Y DELETE. Para cada tabla o vista se puede definir un solo trigger 
INSTEAD OF por acción activadora.
	- Un trigger INSTEAD OF INSERT permite cancelar en forma parcial o
	  total, una operación INSERT, sin necesidad de descartar ninguna transacción.
	- Un trigger INSTEAD OF UPDATE nos da la posibilidad de controlar los cambios
	  antes de que se apliquen a los datos y decidir qué cambios aplicar.
	- Un trigger INSTEAD OF DELETE permite evitar la eliminación de filas específicas
	  sin necesidad de cancelar las transacciones.

En una tabla con una FOREIGN KEY con opciones CASCADE no se puede crear un 
trigger INSTEAD OF.

Se pueden definir INSTEAD OF sobre vistas. Supongamos que tenemos una vista 
sobre la tabla employees que nos presenta un nombre completo como 
Lastname + ', ' + Firstname. No podríamos ejecutar una instrucción UPDATE que 
actualice directamente la columna Nombrecompleto ya que se trata de una columna calculada
y de solo lectura. la slución es crear un trigger INSTEAD OF UPDATE que permita
realizar modificiaciones sobre la columna Nombrecompleto actuando indirectamente
sobre las columnas Firstname y Lastname.
El código es el siguiente.

EJEMPLO.
Este trigger sirve para actualizar columnas calculadas
****************************************************/

USE Northwind
GO

-- Creamos una vista basada en la tabla Employees

CREATE VIEW NombresEmpleados
AS
	SELECT ISNULL(EmployeeID, 0) AS EmployeeID
		, LastName + ', ' + FirstName AS NombreCompleto
	FROM Employees
GO

-- Muestra la información del empleado 6

SELECT NombreCompleto
FROM NombresEmpleados
WHERE EmployeeID = 6

SELECT FirstName
	, LastName
FROM Employees
WHERE EmployeeID = 6
GO

-- Crea un trigger INSTEAD OF

CREATE TRIGGER tr_EmployeesName
ON NombresEmpleados
INSTEAD OF INSERT
AS
	INSERT Employees (LastName, FirstName)
	SELECT LEFT(NombreCompleto, CHARINDEX(',', NombreCompleto) - 1)
		, LTRIM(RIGHT(NombreCompleto, LEN(NombreCompleto)
			- CHARINDEX(',', NombreCompleto)))
	FROM Inserted
GO

-- Create INSTEAD OF UPDATE trigger

CREATE TRIGGER udtEmployeesName
ON NombresEmpleados
INSTEAD OF UPDATE
AS
	UPDATE Employees
	SET LastName = LEFT(Inserted.NombreCompleto
			, CHARINDEX(',', Inserted.NombreCompleto) - 1)
		, FirstName = LTRIM(RIGHT(Inserted.NombreCompleto,
			LEN(Inserted.NombreCompleto)
			- CHARINDEX(',', Inserted.NombreCompleto) ))
	FROM Employees
		JOIN Inserted
			ON Inserted.EmployeeID = Employees.EmployeeID
	WHERE Employees.EmployeeID = Inserted.EmployeeID
GO

-- Testeamos el trigger INSTEAD OF UPDATE

UPDATE NombresEmpleados
SET FullName = 'NewFamily, Michael'
WHERE EmployeeID = 6
GO

SELECT FullName
FROM NombresEmpleados
WHERE EmployeeID = 6

SELECT FirstName, LastName
FROM Employees
WHERE EmployeeID = 6
GO

-- Testeamos el trigger INSTEAD OF INSERT 

INSERT NombresEmpleados (EmployeeID, NombreCompleto)
VALUES (0, 'NewFamily, NewGuy')
GO

SELECT NombreCompleto
FROM NombresEmpleados
WHERE NombreCompleto LIKE 'New%'

SELECT FirstName, LastName
FROM Employees
WHERE LastName LIKE 'New%'
GO

-- Las eliminaciones llevadas a cabo sobre esta vista
-- no requieren un trigger INSTEAD OF DELETE

DELETE NombresEmpleados
WHERE NombreCompleto = 'NewFamily, NewGuy'
GO

SELECT NombreCompleto
FROM NombresEmpleados
WHERE NombreCompleto LIKE 'New%'

SELECT FirstName, LastName
FROM Employees
WHERE LastName LIKE 'New%'
GO

DROP VIEW NombresEmpleados
GO
