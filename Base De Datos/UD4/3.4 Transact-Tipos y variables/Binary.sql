DECLARE @mivalor decimal (5, 2)
SET @mivalor = 193.57
SELECT CAST(CAST(@mivalor AS varbinary(20)) AS decimal(10,5))

-- O, usando CONVERT
SELECT  CONVERT(varbinary(20), @mivalor)
