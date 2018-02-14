-- ALTER SCHEMA (Transact-SQL) 
-- ms-help://MS.SQLCC.v10/MS.SQLSVR.v10.es/s10de_6tsql/html/0a760138-460e-410a-a3c1-d60af03bf2ed.htm

-- Mover la tabla "Store" del esquema "Sales" al esquema "Purchasing".
-- Todos los permisos asociados al elemento protegible se quitarán 
-- cuando se mueva el elemento protegible al nuevo esquema.
USE AdventureWorks
GO
ALTER SCHEMA Purchasing TRANSFER Sales.Store;
GO
