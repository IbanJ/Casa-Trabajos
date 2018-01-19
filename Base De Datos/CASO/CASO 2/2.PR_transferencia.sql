ALTER PROCEDURE bancos.pr_Transferenciaa
  @p_origen smallint,
  @p_destino smallint,
  @p_importe smallmoney,
  @p_salida smallint OUTPUT
AS
	DECLARE @saldo SMALLMONEY
BEGIN
	--Comprobamos que la cuenta origen existe
	IF NOT EXISTS (SELECT *
				   FROM bancos.Cuentas
				   WHERE codigoCuenta=@p_origen)
		BEGIN
		  SET @p_salida=-1
		  RETURN
		END
	-- Comprobamos que la cuenta destino existe
	IF NOT EXISTS (SELECT *
				   FROM bancos.Cuentas
				   WHERE codigoCuenta=@p_destino)
		BEGIN
		  SET @p_salida=-2
		  RETURN
		END
	
	SELECT @saldo=saldo
	FROM bancos.Cuentas
	WHERE codigoCuenta = @p_origen

	-- Compruebo que el saldo sea menor que el importe (error)
	IF @saldo<@p_importe
		BEGIN
			SET @p_salida=-3
		END

	-- Comprobamos que el importe mayor que 0
	IF @p_importe < = 0
	  BEGIN
	    SET @p_salida = -4
		RETURN
	  END

	-- Realizamos una transaccion explicita
	BEGIN TRANSACTION
	BEGIN TRY
		UPDATE bancos.Cuentas
		SET saldo = saldo - @p_importe
		WHERE codigoCuenta = @p_origen

		UPDATE bancos.Cuentas
		SET saldo = saldo + @p_importe
		WHERE codigoCuenta = @p_destino

		INSERT INTO bancos.movimientos 
					(cuentaOrigen,cuentaDestino,importe)
			VALUES (@p_origen,@p_destino,@p_importe)

		COMMIT TRANSACTION
		SET @p_salida = 0
	END TRY
	BEGIN CATCH

		ROLLBACK TRANSACTION
		SET @p_salida =-4
	END CATCH

END