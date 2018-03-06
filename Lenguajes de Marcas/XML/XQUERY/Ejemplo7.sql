SELECT amigosPersona.value('/gente[1]/persona[6]/edad[1][text()]', 'integer')
as edadAmigo
FROM xml.personas
where codigo=2

SELECT codigo, amigosPersona 
FROM xml.personas
WHERE amigosPersona.exist('/gente/persona/identifica/nombre[.="Laida"]') = 1
   OR amigosPersona.exist('/gente/persona/identifica/nombre[.="Jotaro"]') = 1

select * from xml.personas
