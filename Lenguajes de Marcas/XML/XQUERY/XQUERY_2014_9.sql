use AdventureWorks
go
SELECT CatalogDescription.query('
declare namespace PD="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain";
  for $f in /child::PD:ProductDescription/child::PD:Features/child::*
  return
   <Feature
     ProductModelID="{ ($f/parent::PD:Features/parent::PD:ProductDescription/attribute::ProductModelID)[1]}" >
          { $f }
   </Feature>
')
FROM  Production.ProductModel
WHERE ProductModelID=19