DECLARE @myDoc xml
SET @myDoc = '<Root>
<Location LocationID="10" 
            LaborHours=".1"
            MachineHours=".2" >Manu steps are described here.
<step>Manufacturing step 1 at this work center</step>
<step>Manufacturing step 2 at this work center</step>
<step>Manufacturing step 3 at this work center</step>
<step>Manufacturing step 4 at this work center</step>
</Location>
</Root>'
--SELECT @myDoc

SET @myDoc.modify('
  replace value of (/Root/Location[1]/@LaborHours)[1]
  with (
       if (count(/Root/Location[1]/step) > 3) then
         "3.0"
       else
          "1.0"
      )
')
SELECT @myDoc