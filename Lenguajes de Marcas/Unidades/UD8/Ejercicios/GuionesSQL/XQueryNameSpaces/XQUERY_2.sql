-- Referencia Web: http://blogs.msdn.com/b/rscdbbiw/archive/2006/05/20/602847.aspx
-- CONSULTAS COMPROBANDO EL RENDIMIENTO
-- FORMA 1
WITH XMLNAMESPACES(DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey')

SELECT count(*) 
  FROM ( SELECT [Demographics].value(N'/IndividualSurvey[1]/Occupation[1]', 'nvarchar(30)') AS [Occupation] 
  			,[Demographics].value(N'/IndividualSurvey[1]/NumberCarsOwned[1]', 'integer') AS [NumberCarsOwned] 
         FROM [Sales].[Individual] i ) as A
WHERE A.Occupation = 'Management' AND A.NumberCarsOwned = 2


-- FORMA 2
;WITH XMLNAMESPACES(DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey')
SELECT count(*) 
FROM Sales.Individual 
WHERE Demographics.value('/IndividualSurvey[1]/Occupation', 'varchar(30)') = 'Management'
  AND Demographics.value('/IndividualSurvey[1]/NumberCarsOwned', 'int') = 2

-- FORMA 3
;WITH XMLNAMESPACES(DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey')
SELECT count(*) 
FROM Sales.Individual 
WHERE [Demographics].value(N'(/IndividualSurvey/Occupation)[1]', 'nvarchar(30)') = 'Management'
AND [Demographics].value(N'(/IndividualSurvey/NumberCarsOwned)[1]', 'int') = 2

 

