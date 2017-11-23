-- ************ Orden DELETE ***********
-- Para probarla vamos a crear una tabla con 
-- datos de prueba
USE ASIR_IgnacioGonzalo
GO
SELECT * INTO copiaLineas
from AdventureWorks2014.sales.SalesOrderDetail
/*
   Ls orden DELETE no libera espacio. 
   Esta orden se registra en el archivo log (.ldf),
   por lo que estamos consumiendo espacio.
*/
-- 1. Eliminar todas las filas de una tabla
--    registrando en el log
DELETE
FROM COPIALINEAS

-- 2. Eliminar todas las filas de una tabla
--    sin registrar en el log.
--    No libera espacio pero tampoco consume espacio
TRUNCATE TABLE copialineas

-- 3. Eliminar el objeto tabla con todas las filas
--    Libera espacio disponible (NO EN EL DISCO).
--	  Solo registra una orden el el LOG.
DROP TABLE copialineas
GO