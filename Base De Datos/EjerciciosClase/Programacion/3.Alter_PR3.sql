-- PR3.Recibe 2 parametros:Fecha1
-- Fecha2; ambos inputs
-- El programa debe devolver todos los pedidos realizados
-- entre las dos fechas
-- en el caso de que no haya ninguno
-- eL programa devolvera el valor -1
-- en el caso de que si devolvera los datos de los pedidos
-- y el valor 0
ALTER PROCEDURE PR3
	@p_fecha1 datetime,
	@p_fecha2 datetime
AS
BEGIN
	IF NOT EXISTS	(SELECT *
					FROM Northwind.DBO.Orders
					WHERE OrderDate >= @p_fecha1
					AND OrderDate<=@p_fecha2 )
					return -1

		SELECT OrderID, CustomerID, OrderDate
		FROM Northwind.DBO.Orders
		WHERE OrderDate >= @p_fecha1
		AND OrderDate<=@p_fecha2
END