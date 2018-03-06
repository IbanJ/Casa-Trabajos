-- Declaramos un cursor
DECLARE c_empleados CURSOR
  FOR SELECT employeeid,FirstName,City
  FROM Northwind.dbo.employees

-- Abrimos el cursor
-- Se ejecuta la SELECT del cursor
-- y se genera la copia en la BD tempdb
OPEN c_empleados

-- Recuperar la primera fila
FETCH c_empleados 
-- Recuperar la segunda fila
FETCH c_empleados 
-- Recuperar ...

-- Cerramos el cursor
-- elimina la copia de datos almacenada en la BD tempdb
CLOSE c_empleados

-- Esta orden destruye tanto la sentencia (con su mapa)
-- almacenada en la RAM como la copia situada en el disco
-- del servidor (BD tempdb).
DEALLOCATE c_empleados