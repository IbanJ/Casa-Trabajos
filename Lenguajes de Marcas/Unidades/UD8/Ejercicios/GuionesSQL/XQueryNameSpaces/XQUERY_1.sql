-- Base de datos usada AdventureWorks

-- Extraemos los valores desde los nodos de una columna XML 
-- usando la cláusula WITH XMLNAMESPACES
;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey' AS ns)
SELECT FirstName, 
   MiddleName,
   LastName,
   Demographics.value('(/ns:IndividualSurvey/ns:Occupation)[1]','varchar(50)') AS Occupation,
   Demographics.value('(/ns:IndividualSurvey/ns:Education)[1]','varchar(50)') AS Education,
   Demographics.value('(/ns:IndividualSurvey/ns:HomeOwnerFlag)[1]','bit') AS HomeOwnerFlag,
   Demographics.value('(/ns:IndividualSurvey/ns:NumberCarsOwned)[1]','int') AS NumberCarsOwned
FROM sales.Individual as s join person.contact as c 
     on s.ContactID=c.ContactID
WHERE c.ContactID = 15291
GO 