use AdventureWorks2014
go
/*
  La consulta siguiente recupera las dos primeras descripciones de características
  de la descripción del catálogo de productos de un modelo de producto determinado. 
  Si hay más características en el documento, 
  agrega un elemento <there-is-more> sin contenido. 
*/
SELECT CatalogDescription.query('
     declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
     <Producto> 
          { /p1:ProductDescription/@ProductModelID }
          { /p1:ProductDescription/@ProductModelName } 
          {
            for $f in /p1:ProductDescription/p1:Features/*[position()<=2]
            return $f 
          }
          {
            if (count(/p1:ProductDescription/p1:Features/*) > 2)
            then <Hay-Mas/>
            else ()
          } 
     </Producto>        
') as descripcion
FROM Production.ProductModel
WHERE ProductModelID = 19


/*
  En la consulta siguiente, se devuelve un elemento <Location> con un atributo LocationID
  si la ubicación de centro de trabajo no especifica
  las horas de instalación. 
*/
SELECT Instructions.query('
     declare namespace AWMI="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions";
        for $WC in //AWMI:root/AWMI:Location
        return
			if ( $WC[not(@SetupHours)] )
			then
			  <WorkCenterLocation>
				 { $WC/@LocationID } 
			  </WorkCenterLocation>
			 else
			   ()
		') as Result
FROM Production.ProductModel
where ProductModelID=7