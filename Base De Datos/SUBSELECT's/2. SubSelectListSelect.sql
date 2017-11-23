-- Visualizar los datos de los clientes
-- con el numero total de pedidos realizados
-- por todos ellos.
-- (solo valen subSelect's escalares)

SELECT companyname, (select count(*) from orders)
FROM customers