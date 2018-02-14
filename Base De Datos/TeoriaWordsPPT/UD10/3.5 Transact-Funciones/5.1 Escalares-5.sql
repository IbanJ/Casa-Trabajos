/***************************************************
USO DE PAR�METROS

Si una funci�n definida por el usuario usa par�metros, en cada llamada
a la funci�n hay que indicar un valor para cada par�metro, 
incluso aquellos que tienen valores predeterminados.

Para indicar el uso del valor predeterminado en aquellos par�metros
que lo tienen, se puede usar la palabra clave DEFAULT.

Al llamar a una UDF no se puede emitir ning�n par�metro
ya que en caso contrario se producir� un mensaje de error sint�ctico.

EJEMPLO: Llamamos a la funci�n ImporteTotal sin indicar el
valor de descuento.
****************************************************/
USE AdventureWorks
GO

-- Esta es una llamada ilegal, porque no se indica un valor
-- para el par�metro @descuento
SELECT dbo.ImporteTotal(12, 25.4)
GO

-- Esta es una llamada legal, ya que se indica un valor
-- para cada par�metro
SELECT dbo.ImporteTotal (12, 25.4, 0.0)
GO
