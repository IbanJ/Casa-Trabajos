use AdventureWorks2014
go
SELECT Instructions.query('
     declare namespace AWMI="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions";
        for $T in //AWMI:tool
            let $L := //AWMI:Location[.//AWMI:tool[.=data($T)]]
        return
          <herramienta descripcion="{data($T)}" CentroTrabajo="{data($L/@LocationID)}"/>
') as Result
FROM Production.ProductModel
where ProductModelID=7


SELECT Instructions.query('
     declare namespace AWMI="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions";
for $WC in /AWMI:root/AWMI:Location
      where count($WC/AWMI:step) > 2
      return
          <Centro>
           { $WC/@LocationID } 
          </Centro>
') as Result
FROM Production.ProductModel
where ProductModelID=7


SELECT Instructions.query('
     declare namespace AWMI="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions";
for $WC in /AWMI:root/AWMI:Location 
order by $WC/@LaborHours descending
        return
          <CentroTrabajo>
             { $WC/@LocationID } 
             { $WC/@LaborHours } 
          </CentroTrabajo>
') as Result
FROM Production.ProductModel
WHERE ProductModelID=7;