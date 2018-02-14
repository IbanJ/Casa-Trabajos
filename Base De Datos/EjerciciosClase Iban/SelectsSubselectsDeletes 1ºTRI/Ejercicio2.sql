-- Todos los productos con su nombre, el color,
-- el nombre de la categoria al que pertence el producto 
-- y el nombre del modelo.

SELECT Producto.Name as NombreProducto,Producto.Color,
		CategoriaProducto.Name as NombreDeCategoria,ModeloProducto.Name as NombreDeModelo
FROM SalesLT.Product as Producto JOIN SalesLT.ProductCategory as CategoriaProducto
	 ON Producto.ProductCategoryID=CategoriaProducto.ProductCategoryID
	 JOIN SalesLT.ProductModel as ModeloProducto
	 ON ModeloProducto.ProductModelID=Producto.ProductModelID
