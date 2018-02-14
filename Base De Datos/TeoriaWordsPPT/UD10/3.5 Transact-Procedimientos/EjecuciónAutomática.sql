/* **************************************************Uso del procedimiento almacenado de sistema "sp_procoption"Una de las caracter�sticas de los procedimientos almacenados es que se los puedeconfigurar para que se ejecuten de forma autom�tica (pero no pueden tener par�metrosl�gicamente).El procedimiento almacenado debe ser creado por el administrador de sistema en labase de datos master y luego se usa el procedimiento almacenado de sistema sp_procoptionpara configurarlo de modo que se ejecute al iniciarse el servicio SQL Server.*************************************************** */USE Master
GO

-- Creamos una tabla que nos permitir� comprobar que la automatizaci�n funciona
CREATE TABLE dbo.Sqlstatus (lasttime DATETIME)
GO

-- Creamos el procedimiento que queremos que se ejecute todos los d�as 
-- al arrancar SQL server
CREATE PROC dbo.insert_sqlstatus
AS
	INSERT INTO Sqlstatus (lasttime)
	   VALUES (CURRENT_TIMESTAMP)
GO 

-- Marcamos al procedimiento para que funcione la automatizaci�n
EXEC sp_procoption 'inserts_qlstatus','startup','true'
GO

/***************************************************Se puede probar ejecutando desde el SSMS y cerrando todas las aplicaciones de SQL Server. A continuaci�n habr� que detener y reiniciar SQL Server.Abre una ventana de consultas en SSMS y ejecuta una SELECT sobre la tabla SqlStatus.Otra forma de saber si ha funcionado es mirar el registro de errores de SQL Server****************************************************/