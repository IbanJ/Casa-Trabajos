CREATE PROCEDURE PR_VuelosDisponibles
	@p_origen VARCHAR(40),
	@p_destino VARCHAR(40),
	@p_fechaSalida SMALLDATETIME,
	@p_plazas tinyint,
	@p_salida bit OUTPUT
AS
   DECLARE @numVuelos as smallint
BEGIN
  IF @p_origen = @p_destino
  BEGIN
	 SET @p_salida=0
	 RETURN
  END

	SELECT @numVuelos = count(*)
	FROM aviacion.Vuelos
	WHERE origen=@p_origen AND destino = @p_destino
			AND fechaSalida = @p_fechaSalida
			AND disponibilidad > = @p_plazas
			AND finalizado = 0
			
   IF @numVuelos = 0
  BEGIN
	 SET @p_salida=0
	 RETURN
  END
  
  SELECT codVuelo,compania,precio,disponibilidad
	FROM aviacion.Vuelos
	WHERE origen=@p_origen AND destino = @p_destino
			AND fechaSalida = @p_fechaSalida
			AND disponibilidad > = @p_plazas
			AND finalizado = 0

	SET @p_salida = 1
END