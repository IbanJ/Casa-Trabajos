/* *********************** 
   Funciones agregadas
   Base de datos Northwind
************************** */

-- Recuperar la media de precios a los
-- que hemos vendido cada producto
SELECT productid,avg(unitprice)
FROM [order details]
GROUP BY ProductID

-- Recuperar el precio más alto 
-- y el precio más bajo al que hemos vendido
SELECT max(unitprice),min(unitprice)
FROM [order details]