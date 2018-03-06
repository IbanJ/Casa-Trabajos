USE AdventureWorks2014
go

-- Recuperar todas las filas de la tabla Production.ProductModel
-- que contenga la etiqueta Specifications en la columna CatalogDescription
-- Al mismo tiempo, generamos un contenido XML accediendo a la información de una
-- columna de la tabla

 WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription' AS pd)
SELECT ProductModelID, CatalogDescription.query('
    <Producto 
        ProductModelID= "{ sql:column("ProductModelID") }" 
		NombreModelo= "{ sql:column("Name") }"
        />
') AS Resultado
FROM Production.ProductModel
--where CatalogDescription IS NOT NULL
WHERE CatalogDescription.exist('/pd:ProductDescription[(pd:Specifications)]') = 1