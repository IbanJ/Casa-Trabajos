-- filtrando datos XML usando XQuery
;WITH XMLNAMESPACES 
('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey' AS ns)
SELECT COUNT(*)
FROM sales.Individual
WHERE Demographics.exist('(/ns:IndividualSurvey/ns:Gender[.="F"])')=1
GO


--Ejemplo de uso de la cláusula XQuery contains() 
;WITH XMLNAMESPACES 
('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey' AS ns)
SELECT COUNT(1)
FROM sales.Individual
WHERE Demographics.exist('(/ns:IndividualSurvey/ns:Education[contains(.,"Bachelors")])')=1
AND Demographics.exist('(/ns:IndividualSurvey/ns:Gender[.="F"])')=1
GO

-- Método value()
;WITH XMLNAMESPACES 
('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey' AS ns)
SELECT  
con.LastName,
Demographics.value('(/ns:IndividualSurvey/ns:Education)[1]', 'varchar(50)') AS Education,
Demographics.value('(/ns:IndividualSurvey/ns:Gender)[1]', 'char(1)') AS Gender
FROM sales.Individual as cli join Person.Contact as con
on cli.ContactID = con.ContactID
WHERE Demographics.exist('(/ns:IndividualSurvey/ns:Education[contains(.,"Bachelors")])')=1
 AND Demographics.exist('(/ns:IndividualSurvey/ns:Gender[contains(.,"F")])')=1
GO



