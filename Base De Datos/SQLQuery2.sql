select * from sys.syscolumns
where name = 'nombre'

select *
from [INFORMATION_SCHEMA].TABLE_CONSTRAINTS
where CONSTRAINT_TYPE='primary key'

SELECT codigoDepartamento, Nombre
 from departamentos