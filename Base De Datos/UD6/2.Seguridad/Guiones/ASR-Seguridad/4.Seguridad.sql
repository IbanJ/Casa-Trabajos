-- ALTER SCHEMA (Transact-SQL)  Enviar comentarios 
-- ms-help://MS.SQLCC.v10/MS.SQLSVR.v10.es/s10de_6tsql/html/0a760138-460e-410a-a3c1-d60af03bf2ed.htm

-- Transferir la tabla Order Details del esquema dbo al esquema 
-- EGELA\vargasmartinez.
-- Todos los permisos asociados al elemento protegible se quitarán 
-- cuando se mueva el elemento protegible al nuevo esquema.
USE Northwind
GO
ALTER SCHEMA "EGELA\vargasmartinez" TRANSFER dbo."Order Details";
GO

USE BD_ÁlvaroVargas
GO
ALTER SCHEMA "dbo" TRANSFER db_datareader.Table_1;
GO
