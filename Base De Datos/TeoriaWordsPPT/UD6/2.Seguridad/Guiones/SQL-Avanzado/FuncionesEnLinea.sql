-- Funciones en linea

-- Devuelve los clientes de un determinado País
CREATE FUNCTION dbo.ClientesDelPais
(@country nvarchar(15))
RETURNS TABLE
AS
	RETURN (
		SELECT *
		FROM Customers
		WHERE Country = @country
	)