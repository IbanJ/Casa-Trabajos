SELECT amigosPersona.query
(
'
for $p in (/gente)
where $p//edad
return
 <persona>
    <nombre>{$p//nombre}</nombre>
	<apellido>{$p//apellido}</apellido>
 </persona>
'
)
FROM xml.personas
