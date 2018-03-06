use AdventureWorks2012
go

SELECT Instructions.query('
     declare namespace AWMI="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions";
     for $WC in /AWMI:root/AWMI:Location
        return
            <WC OriginalLaborHours = "{ $WC/@LaborHours }"
                UpdatedLaborHoursV1 = "{ $WC/@LaborHours + 1 }" 
                UpdatedLaborHoursV2 = "{ data($WC/@LaborHours) + 2 }" >
            </WC>') as Result
FROM Production.ProductModel
where ProductModelID=7