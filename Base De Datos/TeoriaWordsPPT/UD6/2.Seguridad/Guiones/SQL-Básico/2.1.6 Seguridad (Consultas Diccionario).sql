-- LISTAR LA INFORMACI”N DE LOS ASEGURABLES DE UNA BASE DE DATOS
use AdventureWorks2014
select * from sys.objects 
where type='u'
ORDER BY object_id
-- LISTAMOS LOS ESQUEMAS DE LA BASE DE DATOS
select * from sys.schemas ORDER BY schema_id

-- LISTAMOS INFORMACÕ”N DE LOS ESQUEMAS CON SUS PROPIETARIOS
select esque.name as NombreEsquema,
       prin.name as "NombrePrincipal (Usuario/Rol)" , prin.type as TipoPrincipal, prin.type_desc       
from sys.database_principals prin
    JOIN sys.schemas esque
    ON prin.principal_id = esque.principal_id
order by type


-- EJEMPLO: SACAR EL PROPIETARIO DE LA TABLA Product DE AdventureWorks
-- Y EL ESQUEMA AL QUE PERTENECE
use AdventureWorks2014
select prin.name as Propietario, esque.name as Esquema
from sys.objects obj join sys.schemas esque
  on obj.schema_id = esque.schema_id
  join sys.database_principals prin
  on esque.principal_id = prin.principal_id
where obj.name = 'Product'
