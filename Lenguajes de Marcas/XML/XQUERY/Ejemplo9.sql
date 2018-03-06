-- ******  EJERCICIO 9 ********
/*  Ejercicio1
  Recuperar los datos de las personas que tienen 
  alguna afición (etiqueta Hobby)
*/
;WITH XMLNAMESPACES 
('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey' AS ns)
SELECT BusinessEntityID, FirstName,LastName,Demographics
FROM person.person
WHERE Demographics.exist('(/ns:IndividualSurvey/ns:Hobby)')=1
GO

/*  Ejercicio2
  Recuperarel nombre, el apellido, y el numero de hijos de 
  las personas que tengan hijos
*/
;WITH XMLNAMESPACES 
('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey' AS ns)
SELECT firstname, lastname, 
		Demographics.value('(/ns:IndividualSurvey/ns:TotalChildren)[1]','int')
FROM person.person
WHERE Demographics.exist('(/ns:IndividualSurvey/ns:TotalChildren)')=1 and 
		Demographics.value('(/ns:IndividualSurvey/ns:TotalChildren)[1]','int') > 0
GO

/*  Ejercicio3
  Recuperar la media de hijos de nuestros clientes
*/
;WITH XMLNAMESPACES 
('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey' AS ns)
SELECT avg(Demographics.value('(/ns:IndividualSurvey/ns:TotalChildren)[1]','int'))
FROM person.person
WHERE Demographics.exist('(/ns:IndividualSurvey/ns:TotalChildren)')=1 and 
		Demographics.value('(/ns:IndividualSurvey/ns:TotalChildren)[1]','int') > 0
GO

/*  Ejercicio 4
  Recuperar el numero de personas que tienen unos rendiminetos anuales 
  en la franja 75001-100000$
*/
;WITH XMLNAMESPACES 
('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey' AS ns)
SELECT count(*)
FROM person.person
WHERE Demographics.value('(/ns:IndividualSurvey/ns:YearlyIncome)[1]','varchar(50)')='75001-100000' 
GO

;WITH XMLNAMESPACES 
('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey' AS ns)
SELECT count(*)
FROM person.person
WHERE Demographics.exist('(/ns:IndividualSurvey/ns:YearlyIncome[.="75001-100000"])')=1 
GO

;WITH XMLNAMESPACES 
('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey' AS ns)
SELECT count(*)
FROM person.person
WHERE Demographics.exist('(/ns:IndividualSurvey/ns:YearlyIncome[contains(.,"75001-100000")])')=1 
GO

/*  Ejercicio 5
  Recuperar la media de hijos (TotalChildren) y la media de compras 
  anuales(TotalPurchaseYTD) de todas las mujeres casadas
*/
