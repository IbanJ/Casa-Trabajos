/***************************************************
DESHABILITACIÓN DE TRIGGERS

Existen dos motivos para deshabilitarlos:
	1. Para acelerar ciertos procesos se puede deshabilitar 
	   temporalmente un trigger. Se consigue con la instrucción
	   ALTER TABLE con la opción DISABLE TRIGGER.
	2. Para evitar que se ejecuten con los triggers en respuesta
	   a la recepción de datos provenientes de la duplicación. Se 
	   consigue con la instrucción CREATE o ALTER TRIGGER con la 
	   opción NOT FOR REPLICATION.
EJEMPLO
****************************************************/

USE Northwind
GO

-- Para desactivar un solo trigger

ALTER TABLE Employees
DISABLE TRIGGER tr_Employees --, isr_Employees, udt_Employees

-- Para desactivar varios triggers de una tabla

ALTER TABLE Employees
DISABLE TRIGGER tr_Employees, isr_Employees, udt_Employees

-- Para desactivar todos los triggers de una tabla
ALTER TABLE Employees
DISABLE TRIGGER ALL
