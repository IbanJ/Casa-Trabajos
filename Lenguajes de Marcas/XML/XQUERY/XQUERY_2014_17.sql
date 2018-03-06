use AdventureWorks2014
go
/*
 Por ejemplo, la consulta siguiente comprueba cada elemento <Ubicación> 
 para ver si tiene un atributo LocationID.
*/
SELECT Instructions.query('
     declare namespace AWMI="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions";
        if (every $WC in //AWMI:root/AWMI:Location 
            satisfies $WC/@LocationID)
        then
             <Result>All work centers have workcenterLocation ID</Result>
         else
             <Result>Not all work centers have workcenterLocation ID</Result>
') as Result
FROM Production.ProductModel
where ProductModelID=7

/*
  La consulta devolverá True si todas las ubicaciones de centro de trabajo tienen atributos LocationID.
  De lo contrario, la consulta devolverá False
*/
SELECT Instructions.value('
     declare namespace AWMI="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions";
        every $WC in  //AWMI:root/AWMI:Location 
           satisfies $WC/@LocationID', 
  'nvarchar(10)') as Result
FROM Production.ProductModel
where ProductModelID=7

/*
  La consulta siguiente comprueba si una de las imágenes 
  de producto es pequeña
*/  
SELECT ProductModelID, CatalogDescription.value('
     declare namespace PD="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
     some $F in /PD:ProductDescription/PD:Picture
        satisfies $F/PD:Size="small"', 'nvarchar(20)') as SmallPicturesStored
FROM Production.ProductModel
WHERE ProductModelID = 19