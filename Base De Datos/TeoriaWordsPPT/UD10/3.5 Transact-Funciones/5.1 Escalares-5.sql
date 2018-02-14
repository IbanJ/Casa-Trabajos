/***************************************************
USO DE PARÁMETROS

Si una función definida por el usuario usa parámetros, en cada llamada
a la función hay que indicar un valor para cada parámetro, 
incluso aquellos que tienen valores predeterminados.

Para indicar el uso del valor predeterminado en aquellos parámetros
que lo tienen, se puede usar la palabra clave DEFAULT.

Al llamar a una UDF no se puede emitir ningún parámetro
ya que en caso contrario se producirá un mensaje de error sintáctico.

EJEMPLO: Llamamos a la función ImporteTotal sin indicar el
valor de descuento.
****************************************************/
USE AdventureWorks
GO

-- Esta es una llamada ilegal, porque no se indica un valor
-- para el parámetro @descuento
SELECT dbo.ImporteTotal(12, 25.4)
GO

-- Esta es una llamada legal, ya que se indica un valor
-- para cada parámetro
SELECT dbo.ImporteTotal (12, 25.4, 0.0)
GO
