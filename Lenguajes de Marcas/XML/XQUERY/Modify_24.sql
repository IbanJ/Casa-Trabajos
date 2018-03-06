USE AdventureWorks2014
GO

-- En Adventureworks consultamos la fila de la persona con código 11000
-- de la tabla de clientes individuales (compran a traves de Internet)
select * from PERSON.Person
where BusinessEntityID = 11000

-- Actualizamos la informacion del cliente cuyo codigo
-- es el 11000 eliminando la etiqueta NumberCarsOwned
UPDATE PERSON.Person
SET demographics.modify('
      declare namespace CLI="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
      delete (/CLI:IndividualSurvey/CLI:NumberCarsOwned[1])')
where BusinessEntityID = 11000

-- Verificamos la operacion
select * 
from PERSON.Person
where BusinessEntityID = 11000