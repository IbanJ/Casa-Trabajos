EXEC PR7

-- Crear un procedimiento PR7
/* 
	PR7
	Este procedimiento nos devuelve los años en numero correspondientes a los ultimos 15 años
	(GETDATE) (YEARGETDATE) hay que hacer un bucle.
*/

ALTER PROCEDURE PR7
AS
	declare @agno smallint;
BEGIN
	SET @agno=YEAR(getdate())-15
	WHILE @agno<YEAR(GETDATE())
	BEGIN
		PRINT @agno
		SET @agno=@agno + 1
	END
		print @agno

END


--select (declare @d di (convert(di,year(getdate)),'-4'))