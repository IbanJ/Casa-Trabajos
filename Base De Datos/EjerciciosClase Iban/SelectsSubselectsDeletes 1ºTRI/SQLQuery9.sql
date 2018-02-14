-- Funciones agregadas
/* ***********************
	Funciones agregadas
	Base de datos Northwind
************************* */

-- Recuperar la media de productos a los
-- que hemos vendido cada producto
SELECT productid,avg(unitprice)
FROM [order details]
GROUP BY ProductID

-- Recuperar el precio mas alto
-- y el precio mas bajo al que hemos vendido
SELECT max(unitprice),min(unitprice)
FROM [order details]
