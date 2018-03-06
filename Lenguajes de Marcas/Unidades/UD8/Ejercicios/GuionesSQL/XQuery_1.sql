DECLARE @lista as XML
set @lista='<frutas><fruta>Peras</fruta><fruta>Manzanas</fruta><fruta>Albaricoques</fruta></frutas>'

DECLARE @elemento as XML
set @elemento='<fruta>Kiwis</fruta>'

set @lista.modify(
   'insert sql:variable("@elemento") as first into (/frutas)[1] ')

select @lista

set @lista.modify('delete (frutas/fruta[2])')
select @lista

set @lista.modify(
   'replace value of (frutas/fruta[3]/text())[1] with "Melocotones"')
select @lista