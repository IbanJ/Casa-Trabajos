UPDATE med.Pacientes
SET enfermedades='<?xml version="1.0" encoding="utf-8" ?>
<enfermedades>
  <enferamedad>
    <nombre>Gripe</nombre>
    <tratamiento>Cama</tratamiento>
	<tratamiento>Jarabe</tratamiento>
	<tratamiento>Antibiotico</tratamiento>
    <diasRecuperacion>5</diasRecuperacion>
    <vacunado>1</vacunado>
  </enferamedad>
  <enferamedad>
    <nombre>Catarro</nombre>
    <tratamiento>Pastillitas</tratamiento>
    <diasRecuperacion>0</diasRecuperacion>
    <vacunado>0</vacunado>
  </enferamedad>
  <enferamedad>
    <nombre>Saranpion</nombre>
    <tratamiento>Cama</tratamiento>
    <diasRecuperacion>12</diasRecuperacion>
    <vacunado>1</vacunado>
  </enferamedad>
</enfermedades>'
WHERE codPaciente=1