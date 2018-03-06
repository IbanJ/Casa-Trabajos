-- Recuperacion de la suma de LaborHours con la funcion data()
-- implícita y explicitamente

-- Forma implicita
declare @x xml
set @x='<ROOT><Location LID="1" SetupTime="1.1" LaborHours="3.3" />
<Location LID="2" SetupTime="1.0" LaborHours="5" />
<Location LID="3" SetupTime="2.1" LaborHours="4" />
</ROOT>'
-- data() implicitly applied to the attribute node sequence.
SELECT @x.query('sum(/ROOT/Location/@LaborHours)')

-- Forma Explicita
SELECT @x.query('sum(data(/ROOT/Location/@LaborHours))')