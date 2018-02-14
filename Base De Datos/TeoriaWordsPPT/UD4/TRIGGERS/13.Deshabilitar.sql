/***************************************************
DESHABILITACI�N DE TRIGGERS

Existen dos motivos para deshabilitarlos:
	1. Para acelerar ciertos procesos se puede deshabilitar 
	   temporalmente un trigger. Se consigue con la instrucci�n
	   ALTER TABLE con la opci�n DISABLE TRIGGER.
	2. Para evitar que se ejecuten con los triggers en respuesta
	   a la recepci�n de datos provenientes de la duplicaci�n. Se 
	   consigue con la instrucci�n CREATE o ALTER TRIGGER con la 
	   opci�n NOT FOR REPLICATION.
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
