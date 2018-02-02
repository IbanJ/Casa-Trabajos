-- Hacer que una columna sea de tipo XML no tipada.
ALTER TABLE med.pacientes
	alter column enfermedades xml
				 -- (CONTENT SCH_Enfermedades)