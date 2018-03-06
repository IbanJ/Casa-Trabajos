--Insertamos datos en la tabla
INSERT INTO marcas.Equipos(CodigoEquipo, NombreEquipo,
                           Ciudad, Jugadores)
	VALUES (1,'REAL SOCIEDAD','DONOSTIA',
			( SELECT *
			  FROM OPENROWSET (
				 BULK 'D:\DAM-1\DOCUMENTOS\LENGUAJE_DE_MARCAS\XML\FicherosXML\Jugadores.XML',
				  SINGLE_BLOB) AS TEMP
			)
		)
GO
