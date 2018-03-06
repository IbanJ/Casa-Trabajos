use AdventureWorks
go

SELECT CatalogDescription.query('
declare namespace PD="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain";
 /child::PD:ProductDescription/child::PD:Features/child::*:Maintenance
')
FROM Production.ProductModel
WHERE ProductModelID=19