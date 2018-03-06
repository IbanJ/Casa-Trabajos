USE AdventureWorks2014
go

-- Recuperar los contenidos de los pasos (step) del
-- Centro de Trabajo (Location) situado en la 2ª posición del documento XML
SELECT Instructions.query('
   declare namespace AWMI="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions";
for $Step in /AWMI:root/AWMI:Location[2]/AWMI:step
      return
           string($Step) 
') AS Result
FROM Production.ProductModel
WHERE ProductModelID=7;


-- Recuperar los contenidos de los primeros pasos (step) de
-- cada uno de los Centros de Trabajo (Location)
SELECT Instructions.query('
   declare namespace AWMI="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions";
for $Step in /AWMI:root/AWMI:Location/AWMI:step[1]
      return
           string($Step) 
') AS Result
FROM Production.ProductModel
WHERE ProductModelID=7;