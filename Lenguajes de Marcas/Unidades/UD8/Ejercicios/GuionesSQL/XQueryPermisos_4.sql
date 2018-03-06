-- Para poder consultar con XQuery la informacion almacenada
-- en una columna XML validada con un Schema Collection
-- almacenado en la base de datos, se necesita aplicar
-- un permiso EXECUTE sobre el Schema Colletcion correspondiente.
GRANT execute ON XML
SCHEMA collection :: [Sales].[IndividualSurveySchemaCollection]
TO "segundo\asir1";