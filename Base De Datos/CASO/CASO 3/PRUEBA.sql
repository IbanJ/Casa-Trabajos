DECLARE @tablaCodigos med.T_codigosEnfermedad
DECLARE @SALIDA SMALLINT

INSERT INTO @tablaCodigos(codigoEnfermedad)
	VALUES (1)
INSERT INTO @tablaCodigos(codigoEnfermedad)
	VALUES (2)
INSERT INTO @tablaCodigos(codigoEnfermedad)
	VALUES (7)
--SELECT * FROM @tablaCodigos

exec med.AltaPacienConEnfer 5,'Wenceslao','Trasiegos','09/08/1932', 
							@tablaCodigos, @SALIDA OUTPUT

IF @SALIDA=1
	PRINT 'Operacion realizada correctamente'
ELSE
	PRINT @salida
	
-- ERROR 2627 error de primary key

-- ERROR 547 hemos metido un codigo que no hay
