/***************************************************Uso de objetos como parámetro y construcción de consultasen tiempo de ejecuciónUna ventaja de los procedimientos es que pueden devolver conjuntos de resultadosmediante instrucciones SELECT en el cuerpo del procedimiento.Sin embargo, una de las limitaciones del uso de parámetros es que no pueden ser usadospara pasar al procedimiento almacenado el nombre de un objeto de base de datos:	tabla	columna	o procedimiento almacenado.Para este propósito debemos construir la consulta en tiempo de ejecución como consulta dinámica (mediante EXEC o sp_executesql). Esto no es una restricción de los parámetros sino del DML.****************************************************/USE AdventureWorks
GO

-- Creamos el procedimiento
CREATE PROC dbo.emitirconsulta
	@nombre_tabla VARCHAR(256)
AS
	DECLARE @consulta VARCHAR(1000)
	SET @consulta = 'SELECT * FROM ' + @nombre_tabla
	EXEC (@consulta)

-- Código de prueba. Las comillas dobles son necesarias ya que
-- enviamos el punto de separación entre el esquema y el nombre de la tabla 
exec emitirconsulta "Purchasing.Vendor"


/***************************************************Modificación de las opciones de un procedimiento almacenadoCuando se modifica la definición de un procedimiento almacenado con ALTER PROCEDURE:	SQL Server mantiene los permisos asignados sobre el procedimiento almacenado	Ningún objeto dependiente (tablas, desencadenadores o procedimientos almacenados)	    Resulta afectado.	Si previamente hemos usado el procedimiento almacenado de sistema sp_procoption para configurar 	    la ejecución automática cuando se inicia SQL Server, esta propiedad no sufre modificaciones.Aunque queramos solo cambiar una opción del procedimiento almacenado, debemos incluir todo el código y el resto de las opciones.****************************************************/Modificamos el código para encriptar el texto del procedimientoALTER PROC dbo.emitirconsulta
	@nombretabla VARCHAR(256)
WITH ENCRYPTION
AS
	DECLARE @consulta NVARCHAR(1000)
	SET @consulta = 'SELECT * FROM ' + @nombretabla
	EXEC (@consulta)

-- Comprobamos que realmente el texto ha sido encriptado
sp_helptext consulta_emitida
GO



