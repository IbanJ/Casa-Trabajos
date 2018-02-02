-- Codigo de prueba
DECLARE
    @rdo BIT
EXEC PR_VuelosDisponibles 'Adolfo Suarez','Dusseldorf','14/04/2018',
						  10, @rdo OUTPUT
PRINT @rdo