-- Codigo de prueba

SELECT bco.f_validarPrestamo(2,10000)

-- Funcion booleana f_validarPrestamo

ALTER FUNCTION bco.f_validarPrestamo
	(
		@p_idTitular int,
		@p_importe money
	)
RETURNS bit
AS
BEGIN
	DECLARE @deuda money, @limite money, @concedido bit

	IF NOT EXISTS (SELECT *
			FROM bco.titulares
			WHERE idtitular=@p_idTitular)
		OR @p_importe < 0
			SET @concedido=NULL
	ELSE
	BEGIN

	SELECT @deuda=ISNULL(sum(importe),0)
	FROM bco.prestamos
	WHERE idtitular=@p_idTitular

	SELECT @limite=limiteRiesgo
	FROM bco.titulares
	WHERE idtitular=@p_idTitular

	IF @p_importe + @deuda > @limite
		SET @concedido=0
	ELSE
		SET @concedido=1

	END
	RETURN @concedido
		
END