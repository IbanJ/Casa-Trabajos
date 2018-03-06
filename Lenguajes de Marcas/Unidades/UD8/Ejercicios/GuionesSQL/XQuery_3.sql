select jugadores from marcas.equipos

-- Insertamos una nueva etiqueta al final de los datos
-- del jugador que ocupa la 2ª posicion del equipo cuyo
-- codigo es 1
UPDATE Marcas.Equipos
set jugadores.modify('insert <numLesiones>2</numLesiones> as last into (/Jugadores/Jugador[2])[1]')
where CodigoEquipo=1

select jugadores from marcas.equipos

-- Sustituimos el contenido de la etiqueta Goles
-- del jugador perteneciente al equipo 1
-- que ocupa la primera posicion en la lista de jugadores
UPDATE Marcas.Equipos
set jugadores.modify(
  'replace value of (/Jugadores/Jugador[1]/Goles[1]/text())[1] 
       with "100"')
where CodigoEquipo=1

select jugadores from marcas.equipos

-- Eliminamos una de las etiquetas (a elegir)
-- del 2º jugador
UPDATE Marcas.Equipos
set jugadores.modify(
  'delete /Jugadores/Jugador[2]/numLesiones[1]')
where CodigoEquipo=1

select jugadores from marcas.equipos

