select jugadores from marcas.equipos

-- Insertamos una nueva etiqueta al final de los datos
-- del jugador que ocupa la 2ª posicion del equipo cuyo
-- codigo es 1
UPDATE Marcas.Equipos
set jugadores.modify('insert <numLesiones>2</numLesiones> as last into (/Jugadores/Jugador[2])[1]')
where CodigoEquipo=1