DECLARE @lista XML
SET @lista='<frutas><elemento>Naranjas</elemento>
            <elemento>Peras</elemento>
			<elemento>Manzanas</elemento></frutas>'
DECLARE @elementoAdicional XML
SET @elementoAdicional='<elemento>Kiwis</elemento>'

SET @lista.modify('insert sql:variable("@elementoAdicional")
                   as first into (/frutas)[1]')

SET @lista.modify ('delete /frutas/elemento[2]')

SELECT @lista