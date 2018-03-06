-- Creamos una nueva tabla
CREATE TABLE xml.plantas 
     (pk INT IDENTITY PRIMARY KEY, planta XML)
GO

--Insertamos datos en la tabla
INSERT INTO xml.plantas (planta)
	SELECT *
	FROM OPENROWSET (
	BULK 'D:\plantas.xml',
	SINGLE_BLOB) AS TEMP
GO

select * from xml.plantas

SELECT planta.query
(
	'
		for $p in (/CATALOG)
		where $p/PLANT
		return
		 <persona>
			<identifica>{$p/PLANT/BOTANICAL}</identifica>
		 </persona>
	'
)
FROM xml.plantas

