-- Recupera un contenido XML NATIVO
-- a SQL binario
SELECT planta.value/*value es un metodo de una columna XML */('/CATALOG[1]/PLANT[1]/BOTANICAL[1][text()]', 'varchar(50)')
as edad 
FROM xml.plantas
where pk=1

-- value, exist y query son otros metodos de consulta SQL.

