-- Mostramos las nombres de las tablas de AdventureWorks 
-- combinadas con texto
USE AdventureWorks
SELECT 'El nombre de la tabla es: ', table_name
FROM INFORMATION_SCHEMA.TABLES
WHERE table_type = 'base table'
GO
SELECT 'DROP TABLE ' + table_name
FROM INFORMATION_SCHEMA.TABLES
WHERE table_type = 'base table'
GO
