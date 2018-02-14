/***************************************************
Se puede crear una asociación virtual entre una vista y los objetos a los que hace referencia.
De esta forma, no se puede eliminar ningún objeto al que la vista haga referencia. para ello, se necesita
crear la vista con la opción SCHEMA_BUILDING.
Esta opción tiene dos restricciones:
  Los objetos a los que hace referencia la vista tinen que ser referenciados con el nombre del propietario.
  Se debe indicar explícitamente la lista de columnas en la vista.
****************************************************/
USE Northwind
GO

CREATE VIEW Toyotacars
WITH SCHEMABINDING
AS
SELECT serial, make, model
FROM dbo.Cars
WHERE make = 'Toyota'
GO

DROP TABLE Cars
GO
