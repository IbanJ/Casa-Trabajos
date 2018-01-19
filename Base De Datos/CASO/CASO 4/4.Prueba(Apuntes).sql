-- CODIGO DE PRUEBA
-- SI TIENE UN OUTPUT
-- SI TIENE 5 OUTPUTS HAY QUE DECLARAR 5 VARIABLES
-- Los programas que sirven para probar otros programas son
-- programas anonimos.
DECLARE
	@salida smallint
BEGIN
	execute TRANSPORTES.pr_mod_vehiculo 1,5,
				'MAN',600,NULL,'NO','13/02/2016',60000,600000,
				@salida OUTPUT

	PRINT @salida
END