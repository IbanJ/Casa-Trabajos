/***************************************************USO DE FUNCIONES TABULARES PARA DEVOLVER RESULTADOS COMPLEJOSLista de funciones creadas:	CrearLista	DetalleCompletoPedidos****************************************************/USE Northwind
GO
USE Northwind
GO
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

-- Convierte una cadena que contiene una lista de elementos en una
-- tabla de una sola columna en la que cada elemento está en una
-- fila separada. Cualquier carácter sirve como separador.
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CrearLista]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CrearLista]
GO

CREATE FUNCTION dbo.CrearLista
	(@ArrayDeParam as nvarchar(4000)
	, @Separador as char(1) = '|')
RETURNS @Lista TABLE
	(Elemento sql_variant)
AS
BEGIN
	DECLARE @pos int, @pos0 int
	SET @pos0 = 0
	
	WHILE 1=1
	BEGIN
		SET @pos = CHARINDEX(@Separador, @ArrayDeParam, @pos0 + 1)
		
		INSERT @Lista
			SELECT CASE @pos
				WHEN 0 THEN SUBSTRING(@ArrayDeParam, @pos0+1, LEN(@ArrayDeParam) - @pos -1)
				ELSE SUBSTRING(@ArrayDeParam, @pos0+1, @pos - @pos0-1)
				END
		
		IF @pos = 0 BREAK
		
		SET @pos0 = @pos
	END
	RETURN
	
END
GO

-- Genera una lista de pedidos con información descriptiva
-- completa:
--	 ProductName, CategoryName, CompanyName, OrderDate y TotalValue
-- con todas las claves principales para vincular
-- con otras tablas.

-- La lista puede ser generada para cada
--		Order (@Clave = 'ORD'),
--		Product (@Clave = 'PRO'),
--		Customer (@Clave = 'CUS'),
--		Category (@Clave = 'CAT')
--		o la lista completa (@Clave NOT IN ('ORD', 'PRO', 'CUS', 'CAT'))
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DetalleCompletoPedidos]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[DetalleCompletoPedidos]
GO

CREATE FUNCTION dbo.DetalleCompletoPedidos
	(@ID sql_variant = NULL,
	@Clave char(3) = NULL)
RETURNS @Detalles TABLE
	(OrderID int
	, ProductID int
	, CustomerID nchar(5) NULL
	, CategoryID int NULL
	, OrderDate smalldatetime NULL
	, Value money NULL
	, Category nvarchar(15) NULL
	, Product nvarchar(40) NULL
	, Company nvarchar(40) NULL)
AS
BEGIN
	IF @Clave = 'ORD'
	BEGIN
		INSERT @Detalles (OrderID, ProductID, Value)
			SELECT OrderID, ProductID,
				dbo.ImporteTotal(Quantity, UnitPrice, Discount)
			FROM [Order Details]
			WHERE OrderID = @ID
	END
	ELSE IF @Clave = 'PRO'
	BEGIN
		INSERT @Detalles 
			(OrderID, ProductID, Value)
			SELECT OrderID, ProductID,
				dbo.ImporteTotal(Quantity, UnitPrice, Discount)
			FROM [Order Details]
			WHERE ProductID = @ID
		
	END
	ELSE IF @Clave = 'CUS'
	BEGIN
		INSERT @Detalles 
			(OrderID, ProductID, CustomerID, Value)
			SELECT O.OrderID, ProductID, CustomerID,
				dbo.ImporteTotal(Quantity, UnitPrice, Discount)
			FROM [Order Details] OD
				JOIN Orders O
					ON O.OrderID = OD.OrderID
			WHERE CustomerID = @ID
	END
	ELSE IF @Clave = 'CAT'
	BEGIN
	INSERT @Detalles 
			(OrderID, ProductID, CategoryID, Value)
			SELECT OD.OrderID, P.ProductID, CategoryID,
				dbo.ImporteTotal(Quantity, OD.UnitPrice, Discount)
			FROM [Order Details] OD
				JOIN Products P
					ON P.ProductID = OD.ProductID
			WHERE CategoryID = @ID
	END
	ELSE
	BEGIN
		INSERT @Detalles
			(OrderID, ProductID, Value)
		SELECT OrderID, ProductID,
			dbo.ImporteTotal(Quantity, UnitPrice, Discount)
		FROM [Order Details]
	END
	
	UPDATE D
	SET D.CustomerID = O.CustomerID
		, D.OrderDate = O.OrderDate
	FROM @Detalles D
		JOIN Orders O
			ON O.OrderID = D.OrderID
	WHERE D.CustomerID IS NULL
	
	UPDATE D
	SET D.CategoryID = P.CategoryID
		, D.Product = P.ProductName
	FROM @Detalles D
		JOIN Products P
			ON P.ProductID = D.ProductID
	WHERE D.CategoryID IS NULL
	
	UPDATE D
	SET D.Category = C.CategoryName
	FROM @Detalles D
		JOIN Categories C
			ON C.CategoryID = D.CategoryID
	
	UPDATE D
	SET D.Company = C.CompanyName
	FROM @Detalles D
		JOIN Customers C
			ON C.CustomerID = D.CustomerID
	
	RETURN
END
GO
select *
FROM dbo.CrearLista('hhhh|lllll|ss|456|23|rfghhfgh','|')
GO	
select *
FROM dbo.CrearLista('hhhhalllllassa456a23arfghhfgh','a')
GO	

select *
FROM dbo.DetalleCompletoPedidos(6,'PRO')
GO
select *
FROM dbo.DetalleCompletoPedidos('ANTON','CUS')
GO	
select *
FROM dbo.DetalleCompletoPedidos(6,'CAT')
GO
select *
FROM dbo.DetalleCompletoPedidos(10248,'ORD')
GO
select *
FROM dbo.DetalleCompletoPedidos(6,'cc')
GO