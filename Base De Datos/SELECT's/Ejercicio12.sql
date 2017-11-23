-- Recuperar los datos de los 5 productos
-- más caros
select top 5 with ties ProductName, UnitPrice
from Products
order by UnitPrice desc