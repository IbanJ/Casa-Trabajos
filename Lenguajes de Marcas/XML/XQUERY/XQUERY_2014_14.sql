use AdventureWorks2012
go
SELECT CatalogDescription.query('
     declare namespace PD="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
     for $F in /PD:ProductDescription/PD:Picture[PD:Size="small" 
                                                 and PD:Angle="front"]
     return 
         $F 
    ') as Result
FROM  Production.ProductModel
where ProductModelID=19