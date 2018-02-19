-- Eliminación de las FK's en customers
ALTER TABLE [OE].[Customers] DROP CONSTRAINT [FK_Customers_Employees];
ALTER TABLE [OE].[Customers] DROP CONSTRAINT [FK_Customers_Locations];
-- Eliminación de las FK's en Facturas
ALTER TABLE [OE].[Facturas] DROP CONSTRAINT [FK_Facturas_Customers];
ALTER TABLE [OE].[Facturas] DROP CONSTRAINT [FK_Facturas_Orders]
GO
ALTER TABLE [OE].[Facturas] DROP CONSTRAINT [FK_Facturas_TipoCobros]
GO
-- Eliminación de las FK's en inventories
ALTER TABLE [OE].[Inventories] DROP CONSTRAINT [FK_Inventories_Product_Information]
GO
ALTER TABLE [OE].[Inventories] DROP CONSTRAINT [FK_Inventories_Warehouses]
GO
-- Eliminación de las FK's en LineasFactura
ALTER TABLE [OE].[LineasFactura] DROP CONSTRAINT [FK_LineasFactura_Facturas]
GO
ALTER TABLE [OE].[LineasFactura] DROP CONSTRAINT [FK_LineasFactura_LineasFactura]
GO
-- Eliminación de las FK's en OrderItems
ALTER TABLE [OE].[Order_Items] DROP CONSTRAINT [FK_Order_Items_Orders]
GO
ALTER TABLE [OE].[Order_Items] DROP CONSTRAINT [FK_Order_Items_Product_Information]
GO
-- Eliminación de las FK's en Orders
ALTER TABLE [OE].[Orders] DROP CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [OE].[Orders] DROP CONSTRAINT [FK_Orders_Employees]
GO
-- Eliminación de las FK's en Product_Information
ALTER TABLE [OE].[Product_Information] DROP CONSTRAINT [FK_Product_Information_Product_Description]
GO
ALTER TABLE [OE].[Product_Information] DROP CONSTRAINT [FK_Product_Information_suppliers]
GO
-- Eliminación de las FK's en [Warehouses]
ALTER TABLE [OE].[Warehouses] DROP CONSTRAINT [FK_Warehouses_Locations]
GO
