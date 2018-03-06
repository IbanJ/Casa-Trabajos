SELECT Instructions.query('
declare namespace AWMI="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions";
 /child::AWMI:root/child::AWMI:Location[attribute::LocationID=10]
')
FROM Production.ProductModel
WHERE ProductModelID=7


SELECT Instructions.query('
declare namespace AWMI="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions";
 /child::AWMI:root/child::AWMI:Location[attribute::LotSize]
')
FROM Production.ProductModel
WHERE ProductModelID=7



SELECT CatalogDescription.query('
declare namespace PD="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain";
 /child::PD:ProductDescription/child::PD:Features/child::*[3]
')
FROM Production.ProductModel
WHERE ProductModelID=19



SELECT CatalogDescription.query('
declare namespace PD="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain";
  for $f in /child::PD:ProductDescription/child::PD:Features/child::*
	  return
	   <Caract
		 IDmodelo="{ ($f/parent::PD:Features/parent::PD:ProductDescription/attribute::ProductModelID)[1]}" >
			  { $f }
	   </Caract>
')
FROM  Production.ProductModel
WHERE ProductModelID=19