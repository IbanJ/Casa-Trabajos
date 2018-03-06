use AdventureWorks
go
/*
 
*/
SELECT P.ProductID, p.Name, CatalogDescription.query('
declare namespace pd="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
       <Producto 
           CodigoProducto=       "{ sql:column("P.ProductID") }"
           Nombre=     "{ sql:column("P.Name") }"
           Precio=    "{ sql:column("P.ListPrice") }"
           ModeloID= "{ sql:column("PM.ProductModelID") }" >
           { if (not(empty(/pd:ProductDescription))) then
             attribute ProductModelName { /pd:ProductDescription[1]/@ProductModelName }
            else 
               ()
}
        </Producto>
') as Result
FROM Production.ProductModel PM, Production.Product P
WHERE PM.ProductModelID = P.ProductModelID
AND   CatalogDescription is not NULL
ORDER By PM.ProductModelID