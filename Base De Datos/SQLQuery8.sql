-- Recuperar el importe correspondiente
-- al pedido 10248 (BD Northwind)
SELECT sum(UnitPrice*Quantity)
FROM [ORDER DETAILS]
WHERE orderid=10248

-- Recuperar los importes facturados
-- en cada pedido (BD Northwind)
SELECT orderid, 
  sum((UnitPrice*Quantity)*(1-discount))
FROM [ORDER DETAILS]
GROUP BY OrderID
