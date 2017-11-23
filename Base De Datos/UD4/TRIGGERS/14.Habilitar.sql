/***************************************************
HABILITACI�N DE TRIGGERS

Para volver a habilitar un trigger usamos la instrucci�n 
ALTER TABLE con la opci�n ENABLE TRIGGER.
EJEMPLO
****************************************************/

USE Northwind
GO

-- Para activar un solo trigger

ALTER TABLE Employees
ENABLE TRIGGER tr_Employees --, isr_Employees, udt_Employees

-- Para activar varios triggers de una tabla

ALTER TABLE Employees
ENABLE TRIGGER tr_Employees, isr_Employees, udt_Employees

-- Para activar todos los triggers de una tabla

ALTER TABLE Employees
ENABLE TRIGGER ALL
