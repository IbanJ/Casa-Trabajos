SELECT CatalogDescription.query('
declare namespace PD="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
  /child::PD:ProductDescription/child::PD:Features/descendant::*
')
FROM  Production.ProductModel
WHERE ProductModelID=19