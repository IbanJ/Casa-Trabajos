USE Adventureworks
GO
CREATE VIEW ClientesHamburgo
AS
SELECT indi.CustomerID, person.LastName, dir.City
FROM Sales.Individual indi JOIN Sales.Customer cli
ON indi.CustomerID = cli.CustomerID
JOIN Sales.CustomerAddress direccli
ON cli.CustomerID=direccli.CustomerID
JOIN Person.Address dir
ON direccli.AddressID = dir.AddressID
JOIN Person.Contact person
on indi.ContactID = person.ContactID
WHERE dir.city= 'Hamburg'
GO

SELECT * FROM ClientesHamburgo
GO

