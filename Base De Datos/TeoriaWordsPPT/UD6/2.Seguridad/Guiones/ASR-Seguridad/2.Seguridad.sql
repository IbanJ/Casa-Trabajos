-- Lista los datos de los asegurables de la base de datos
select * from sys.objects
-- listamos los esquemas de la base de datos
select * from sys.schemas
-- listamos los propietarios de los esquemas
select * from sys.database_principals


--EJEMPLO: SACAR EL PROPIETARIO DE LA TABLA PRODUCTS DE NORTHWIND
select prin.name, esque.name
from sys.objects obj join sys.schemas esque
  on obj.schema_id = esque.schema_id
  join sys.database_principals prin
  on obj.principal_id = prin.principal_id
where obj.name = 'employee'


--EJEMPLO: SACAR EL PROPIETARIO DE LA TABLA dbo.clientes DE la BD_ÁlvaroVargas
use BD_ÁlvaroVargas
select prin.name as 'Propietario', esque.name as 'Esquema'
from sys.objects obj join sys.schemas esque
  on obj.schema_id = esque.schema_id
  join sys.database_principals prin
  on obj.principal_id = prin.principal_id
where obj.name = 'clientes'