/***************************************************Creación de un procedimiento almacenado temporal.Pasos para probarlo después de ejecutar enn el SSMS:1. Mirar en la base de datos tempdb2. Cerrar la conexión3. Volver a mirar en la tempdbEstos procedimientos se crean en la base de datos tempdb.Conviene que su nombre comience por # para los locales o por ## para los globales.****************************************************/
CREATE PROC #CogerNombreBD
AS
SELECT db_name() AS NombreBaseDeDatos
GO

