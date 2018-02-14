/***************************************************SEGURIDAD DE APLICACION MEDIANTE PROCEDIMIENTOS ALMACENADOSMediante los procedimientos almacenados podemos impedir que los usuarios trabajen directamente con las tablas. El permiso execute lo damos sobre el procedimiento.Cuando un usuario ejecuta un procedimiento, SQL Server controla los permisos. Al usuario le bastacon tener el permiso EXECUTE sobre el procedimiento. Esta regla tiene dos excepciones:	- Si el procedimiento almacenado tiene una consulta din�mica, el usuario	  que ejecuta el procedimiento necesita tener permisos sobre cada uno de los objetos accedidos.	- Si se rompe la cadena de propiedad, SQL Server controla los permisos 	  sobre cada objeto que tenga un propietario diferente y solo ejecutar� 	  aquellas instrucciones para las que haya permisos suficientes.	  Es muy importante que el propietario de un procedimiento almacenado sea propietario	  tambi�n de todos los objetos a los que aquel hace referencia, para evitar que se 	  rompa la cadena de propiedad.Por ejemplo:Supongamos que en una base de datos tenemos las siguientes tablas:	wdavidg.clientes	wbenata.pedidosy un procedimiento almacenado que creamos de este modo:	CREATE PROCEDURE wbenata.pr_clientespedidos	AS		SELECT * FROM wdavidg.clientes		SELECT * FROM wbenata.pedidos	Se producen las siguientes actuaciones:	wdavidg concede permiso de lectura sobre la tabla clientes a "wbenata".	wbenata concede permiso de ejecuci�n sobre pr_clientespedidos a "wgaizka".		"wgaizka" ejecuta el procedimiento. "wgaizka" solo recupera los datos de pedidos	ya que tiene acceso indirecto a la tabla clientes pero no tiene permiso directo 	sobre dicha tabla. La cadena de propiedad se ha roto ya que el procedimiento almacenado	accede a una tabla de la que no es propietario.	Para solucionar este problema, "wdavidg" deber�a conceder permiso de lectura sobre	la tabla clientes a "wgaizka".En resumen:    Si todos los objetos a los que hace referencia un ppaa pertenecen al propietario     del procedimiento y la definici�n del procedimiento no tiene consultas din�micas,    a cualquier usuario le basta con tener permiso EXECUTE sobre el procedimiento    para poder ejecutarlo.   ****************************************************/