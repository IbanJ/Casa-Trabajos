/***************************************************Ejemplo: supongamos que queremos aumentar un 5% al precio de los productos. 
El procedimiento manual implicaría modificar la columna UnitPrice para cada producto.
El proceso automático no puede ser muy diferente, ya que en el comjunto de resultados final 
la columna UnitPrice debería contener valores un 5% más caros que antes.

Si pensamos cómo realizar esta operación desde una aplicación cliente, 
por ejemplo en Visual Basic, podríamos llevar a cabo la misma operación
con una única instrucción UPDATE.
****************************************************/
/*
 Código con Visual Basic
*/
	
Dim conNorthwind As ADODB.Connection
	
Set conNorthwind = New ADODB.Connection
	
conNorthwind.Provider = "SQLOLEDB"
	
conNorthwind.Open "Server=SRV_AULA;UID=sa;PWD=;Database=Northwind;"
	
conNorthwind.Execute "UPDATE Products SET UnitPrice = UnitPrice / 1.05"
	
conNorthwind.Close
	
Set conNorthwind = Nothing
