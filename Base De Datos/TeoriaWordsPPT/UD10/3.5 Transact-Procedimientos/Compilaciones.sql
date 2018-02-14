/***************************************************Creación de un procedimiento almacenado con la opción WITH RECOMPILE.La primera vez que se ejecuta un procedimiento almacenadoSQL Server crea un plan de ejecución optimizado que queda almacenadoen la memoria. SQL Server reutilizará este plan de ejecución cuando vuelva a ser llamado.A veces esto puede no interesar por alguna de las siguientes razones:	- Los valores de los parámetros han cambiado de manera significativa.	- Los objetos a los que hace referencia el procedimiento almacenado	  han sufrido algún tipo de modificación.	- Los datos han cambiado sustancialmente.	- Los índices han cambiado significativamente.Existen tres formas de obligar de forma explícita a SQL Server a quegenere otro plan de ejecución:	1- Crear un procedimiento almacenado con la opción WITH RECOMPILE.	   De esta forma SQL Server no guarda en la caché el plan de ejecución	   y vuelve a crear el plan cada vez que es ejecutado.    ****************************************************/	USE Northwind
	GO

	CREATE PROC dbo.CogerEmpleadosPais
		@country NVARCHAR(30)
	WITH RECOMPILE
	AS
		SELECT    employeeid,lastname,firstname
		FROM    Employees
		WHERE    country = @country


--   2.- Usar la opción WITH RECOMPILE al ejecutar el procedimiento almacenado.
--       De esta forma, SQL Server genera un nuevo plan de ejecución con la primera
--       llamada y será usado por las siguientes llamadas.
	USE Northwind
	GO
	EXEC CogerEmpleadosPais 'USA' WITH RECOMPILE
	GO

--   3.- Usar el procedimiento almacenado de sistema sp_recompile.
--       Puede recibir como argumento:
--			- Un procedimiento almacenado.
--			- Una tabla.
--			- Una vista.
--			- O un trigger.
--		 Si le damos como argumento un procedimiento almacenado o un disparador, el objeto
--		 se recompilará en la próxima ejecución.
--		 Si le damos como argumento una tabla o una vista, todos los procedimientos
--		 que hagan referencia a la tabla o a la vista se recompilarán en la próxima
--		 ejecución. Este es el mejor método para recompilar todos los procedimientos 
--		 que hagan referencia a una tabla o vista particular.
--		Ejemplo: Uso de sp_recompile para obligar a SQL Server a generar un nuevo plan de ejecución--			para cada procedimiento almacenado que haga referencia a la tabla employees.	USE Northwind
	GO
	sp_recompile 'Employees'
	GO

