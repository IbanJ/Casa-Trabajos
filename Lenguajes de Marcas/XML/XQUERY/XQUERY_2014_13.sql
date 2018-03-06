use AdventureWorks2012
go

WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription' AS PD)
SELECT CatalogDescription.query('       
    for $P in /PD:ProductDescription/PD:Picture[PD:Size = "small"]       
    return $P') as Result       
FROM   Production.ProductModel       
WHERE  ProductModelID=19   

WITH XMLNAMESPACES (
  'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes' AS act,
  'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo' AS aci)
SELECT AdditionalContactInfo.value('       
   /aci:AdditionalContactInfo//act:telephoneNumber/act:number = "425-555-1112"', 'nvarchar(10)') as Result       
FROM Person.person       
WHERE BusinessEntityID=1        


WITH XMLNAMESPACES (
  'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes' AS act,
  'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo' AS aci)
SELECT AdditionalContactInfo.query('       
  if (/aci:AdditionalContactInfo//act:telephoneNumber/act:number = ("222-222-2222","425-555-1111"))       
  then        
     /aci:AdditionalContactInfo//act:telephoneNumber/act:number       
  else       
    ()') as Result       
FROM Person.person       
WHERE BusinessEntityID=1
          