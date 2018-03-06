use AdventureWorks2014
go

SELECT BusinessEntityID,Demographics
FROM person.Person
WHERE Demographics.exist('IndividualSurvey/TotalChildren[.=5]') = 1

