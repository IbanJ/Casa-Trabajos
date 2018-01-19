alter PROCEDURE med.AltaPacienConEnfer
   @p_codPaciente smallint,
   @p_nombre varchar(20),
   @p_apellido varchar(25),
   @p_fechaNacimiento date,
   @p_enfermedades med.T_codigosEnfermedad READONLY,
   @p_salida smallint OUTPUT
AS
	DECLARE c_enfermedades CURSOR
	  FOR SELECT codigoEnfermedad
			from @p_enfermedades
	Declare @v_codigoEnfermedad Tinyint
BEGIN
   BEGIN TRANSACTION
   BEGIN TRY
		--Damos de alta al paciente
      INSERT INTO med.pacientes 
	         (codPaciente,nombre,apellido,fechaNacimiento)
		VALUES (@p_codPaciente,@p_nombre,
		        @p_apellido,@p_fechaNacimiento)
		-- Damos de alta a sus enfermedades
		OPEN c_enfermedades
		FETCH c_enfermedades INTO @v_codigoEnfermedad
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			INSERT INTO med.PacEnf 
			(codPaciente,codEnfermedad,FechaRegistro)
			VALUES (@p_codPaciente,@v_codigoEnfermedad,
					GETDATE())
			FETCH c_enfermedades INTO @v_codigoEnfermedad
		END
		DEALLOCATE c_enfermedades
	
      COMMIT TRANSACTION
	  SET @p_salida=1
   END TRY
   BEGIN CATCH
	  set @p_salida=@@error
      ROLLBACK TRANSACTION
   END CATCH

END