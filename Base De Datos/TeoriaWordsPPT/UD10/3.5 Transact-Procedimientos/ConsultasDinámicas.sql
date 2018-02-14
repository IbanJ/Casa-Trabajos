/***************************************************Uso de objetos como par�metro y construcci�n de consultasen tiempo de ejecuci�nUna ventaja de los procedimientos es que pueden devolver conjuntos de resultadosmediante instrucciones SELECT en el cuerpo del procedimiento.Sin embargo, una de las limitaciones del uso de par�metros es que no pueden ser usadospara pasar al procedimiento almacenado el nombre de un objeto de base de datos:	tabla	columna	o procedimiento almacenado.Para este prop�sito debemos construir la consulta en tiempo de ejecuci�n como consulta din�mica (mediante EXEC o sp_executesql). Esto no es una restricci�n de los par�metros sino del DML.****************************************************/USE AdventureWorks
GO

-- Creamos el procedimiento
CREATE PROC dbo.emitirconsulta
	@nombre_tabla VARCHAR(256)
AS
	DECLARE @consulta VARCHAR(1000)
	SET @consulta = 'SELECT * FROM ' + @nombre_tabla
	EXEC (@consulta)

-- C�digo de prueba. Las comillas dobles son necesarias ya que
-- enviamos el punto de separaci�n entre el esquema y el nombre de la tabla 
exec emitirconsulta "Purchasing.Vendor"


/***************************************************Modificaci�n de las opciones de un procedimiento almacenadoCuando se modifica la definici�n de un procedimiento almacenado con ALTER PROCEDURE:	SQL Server mantiene los permisos asignados sobre el procedimiento almacenado	Ning�n objeto dependiente (tablas, desencadenadores o procedimientos almacenados)	    Resulta afectado.	Si previamente hemos usado el procedimiento almacenado de sistema sp_procoption para configurar 	    la ejecuci�n autom�tica cuando se inicia SQL Server, esta propiedad no sufre modificaciones.Aunque queramos solo cambiar una opci�n del procedimiento almacenado, debemos incluir todo el c�digo y el resto de las opciones.****************************************************/Modificamos el c�digo para encriptar el texto del procedimientoALTER PROC dbo.emitirconsulta
	@nombretabla VARCHAR(256)
WITH ENCRYPTION
AS
	DECLARE @consulta NVARCHAR(1000)
	SET @consulta = 'SELECT * FROM ' + @nombretabla
	EXEC (@consulta)

-- Comprobamos que realmente el texto ha sido encriptado
sp_helptext consulta_emitida
GO



