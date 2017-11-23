/***************************************************
MODIFICACIÓN EN LA DEFINICIÓN DE UN TRIGGER

La modificación de la definición de un trigger es
mediante la sentencia ALTER TRIGGER.
Los triggers son objetos independientes. Ningún objeto
depende de ellos. Por tanto se pueden eliminar y volver
a crear sin ningún problema.

PRECAUCIÓN: con sp_rename se puede cambiar el nombre de
un trigger pero esto no cambia el nombre almacenado en 
syscomments. 
Para cambiar el nombre es recomendable eliminarlo y 
volverlo a crear con otro nombre.

****************************************************/

USE Northwind
GO

-- Creamos un trigger que reserva el privilegio de modificar
-- la tabla employees al usuario dbo

CREATE TRIGGER tr_Employees
ON Employees
AFTER UPDATE, INSERT, DELETE
AS
	IF CURRENT_USER <> 'dbo'
	BEGIN
		RAISERROR ('Solo los propietarios de la base de datos pueden modificar Employees, transacción deshecha', 10, 1)
		ROLLBACK TRAN
	END
GO

-- Modificamos el trigger para restringir las modificaciones
-- de la tabla employees a los miembros de la función (rol) dbo.

ALTER TRIGGER tr_Employees
ON Employees
AFTER UPDATE, INSERT, DELETE
AS
	IF IS_MEMBER('db_owner') <> 1
	BEGIN
		RAISERROR ('Solo los propietarios de la base de datos pueden modificar Employees, transacción deshecha', 10 ,1)
		ROLLBACK TRAN
	END
GO
