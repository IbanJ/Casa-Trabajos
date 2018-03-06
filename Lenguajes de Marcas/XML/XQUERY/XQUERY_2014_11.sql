SELECT CatalogDescription.query('
declare namespace PD="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain";
 /child::PD:ProductDescription/child::PD:Features/child::text()
')
FROM Production.ProductModel
WHERE ProductModelID=19

/*
  ----------------------------------------------------------------
*/
SELECT CatalogDescription.query('
declare namespace PD="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain";
 /child::PD:ProductDescription/child::comment()
')
FROM Production.ProductModel
WHERE ProductModelID=19

/* 
  ----------------------------------------------------------------
*/
SELECT CatalogDescription.query('
declare namespace PD="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain";
 /child::processing-instruction()
')
FROM Production.ProductModel
WHERE ProductModelID=19

/* 
  ----------------------------------------------------------------
*/
SELECT CatalogDescription.query('
declare namespace PD="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain";
 /child::processing-instruction("xml-stylesheet")
')
FROM Production.ProductModel
WHERE ProductModelID=19