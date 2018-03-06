-- Creamos una tabla con una columna XML
CREATE TABLE [xml].[personas](
	[codigo] [smallint] NOT NULL,
	[amigosPersona] [xml] NULL,
 CONSTRAINT [PK_personas] PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Insertamos una fila con el contenido XML

INSERT INTO [xml].[personas] ([codigo], [amigosPersona]) 
VALUES (1, N'<gente><persona><identifica><nombre>Martin</nombre><apellido>Martinez</apellido></identifica><edad>33</edad><peso>ligero</peso></persona><persona><identifica><nombre>Laida</nombre><apellido>Eceiza</apellido></identifica><edad>40</edad><peso>ligero</peso></persona><persona><identifica><nombre>Tomas</nombre><apellido>Alfaro</apellido></identifica><edad>30</edad><peso>medio</peso></persona></gente>')


/* ******************************************************
					Ejercicios de XQUERY
******************************************************* */

--Consultamos los datos
SELECT * FROM xml.personas
GO

--Insertamos un nuevo valor
UPDATE xml.personas 
SET amigosPersona.modify(
'insert <ColorFavorito>Rojo</ColorFavorito>
as first into (/gente/persona[1])[1]')
WHERE codigo=1
GO

--Consultamos los datos
SELECT * FROM xml.personas
GO

--Modificamos el valor
UPDATE xml.personas 
SET amigosPersona.modify(
'replace value of (/gente/persona[1]/ColorFavorito[1]/text())[1]
with "Azul"')
WHERE codigo=1
GO

--Consultamos los datos
SELECT * FROM xml.personas
GO

--Eliminamos la elemento "<ColorFavorito>"
UPDATE xml.personas 
SET amigosPersona.modify(
'delete /gente/persona[1]/ColorFavorito')
WHERE codigo=1
GO

--Consultamos los datos
SELECT * FROM xml.personas
GO





