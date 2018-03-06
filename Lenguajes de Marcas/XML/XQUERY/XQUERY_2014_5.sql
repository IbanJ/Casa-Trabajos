use DAM1_Gonzalo
go

CREATE XML SCHEMA COLLECTION SC AS '
<schema xmlns="http://www.w3.org/2001/XMLSchema">
      <element name="s" type="string"/>
      <element name="b" type="boolean"/>
</schema>'
go

DECLARE @x XML(SC)
SET @x = '<s>patata</s><b>true</b><b>false</b>'
SELECT @x.query('if (data(/b[1])) then "Cierto" else "falso"')
SELECT @x.query('if (data(/b[2])) then "Cierto" else "falso"')
go