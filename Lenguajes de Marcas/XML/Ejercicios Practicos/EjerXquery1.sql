SELECT BusinessEntityID, Demographics
FROM Person.Person
------------------------------------------ TODO SE HACE CON .VALUE -------------------------------------------
/*
 Ejer Demographics
 -Media de hijos de las mujeres
 -gender= f
 -totalchildren ??
*/

SELECT AVG(Demographics.value('
	declare namespace xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
        for $WC in //xmlns:IndividualSurvey
											[xmlns:Gender="F"]
			return []

        
			
			   ()
'))
FROM Person.Person
WHERE Demographics.value('
	declare namespace xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
	/xmlns:IndividualSurvey[xmlns:Gender="F"]
')
/*
  Ejer
  -El total de compras anuales realizadas
  por hombres que son padres
  -Totalchildren>1
  -Gender=male
*/


/*
  Visualizar la media de coches que 
  poseen los hombres solteros
  -marital status = single
  -numbercarsowned ??
*/


/*
  Visualizar el nombre de la persona
  que nos ha comprao mas en el año
  -totalpurchaseYTD
  ??salespurchaseYTD
*/

SELECT Demographics.value('
	declare namespace xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey";
	/xmlns:IndividualSurvey[xmlns:Gender="F"]')
FROM Person.Person