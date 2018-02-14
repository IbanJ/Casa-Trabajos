/***************************************************
FUNCIONES ESCALARES CON PARÁMETROS

Lista de funciones creadas:
	PrecioTotal
	ValorFuturo
****************************************************/

USE AdventureWorks
GO

-----------------------------------------------------------
-- función que calcula el importe total de una venta a partir
-- del precio unitario , la cantidad y el descuento
-----------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ImporteTotal]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ImporteTotal]
GO
CREATE FUNCTION dbo.ImporteTotal
(@Cantidad float, @PrecioUnitario money, @Descuento decimal(3,2) = 0.0)
RETURNS money
AS
BEGIN
	RETURN (@Cantidad * @PrecioUnitario * (1.0 - @Descuento))
END
GO

-----------------------------------------------------------
-- Calcula el valor futuro de una inversión, basándose en
-- pagos periódicos constantes y una tasa de interés constante
-- Parámetros:
--		@ratio: tasa de interés entre pagos
--		@nper: número de pagos
--		@pago: pago a realizar en cada periodo
--		@va: valor actual. Por defecto 0.0
--		@tipo: 0 si el pago se hace al final de cada periodo (por defecto)
--			   1 si el pago se hace al comienzo de cada periodo
-----------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ValorFuturo]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ValorFuturo]
GO
CREATE FUNCTION dbo.ValorFuturo
      (@ratio Decimal, @nper int, @pago money, @vactual money = 0.0, @tipo bit = 0)
RETURNS money
AS
BEGIN
	DECLARE @vf money
	
	IF @ratio = 0
		SET @vf = @vactual + @pago * @nper
	ELSE
		SET @vf = @vactual * POWER(1 + @ratio, @nper) 
			+ @pago * (((POWER(1 + @ratio, @nper + @tipo) - 1) / @ratio) - @tipo)
	
	RETURN (-@vf)
END
GO
