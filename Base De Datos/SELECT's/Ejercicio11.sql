-- Recuperar el numero de regiones
-- a las que llevamos nuestras mercancías
select count(distinct shipregion)
from orders
--where shipregion  is not null