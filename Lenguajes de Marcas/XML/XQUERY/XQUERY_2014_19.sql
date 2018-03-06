use AdventureWorks
go

declare @x as xml
set @x = (
			SELECT CatalogDescription.query('
			   declare namespace PD="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
			   data(/PD:ProductDescription[1]/@ProductModelID) 
			         instance of xs:string
			') as Result
			FROM Production.ProductModel
			WHERE ProductModelID = 19 
		 ) 

if cast(@x as varchar(5)) = 'true'
   print 'Es del tipo string'
else
   print 'No es del tipo string'
