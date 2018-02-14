/***************************************************Ejemplo: supongamos que queremos aumentar un 5% al precio de los productos. 
El procedimiento manual implicar�a modificar la columna UnitPrice para cada producto.
El proceso autom�tico no puede ser muy diferente, ya que en el comjunto de resultados final 
la columna UnitPrice deber�a contener valores un 5% m�s caros que antes.

Si pensamos c�mo realizar esta operaci�n desde una aplicaci�n cliente, 
por ejemplo en Visual Basic, podr�amos llevar a cabo la misma operaci�n
con una �nica instrucci�n UPDATE.
****************************************************/
/*
 C�digo con Visual Basic
*/
	
Dim conNorthwind As ADODB.Connection
	
Set conNorthwind = New ADODB.Connection
	
conNorthwind.Provider = "SQLOLEDB"
	
conNorthwind.Open "Server=SRV_AULA;UID=sa;PWD=;Database=Northwind;"
	
conNorthwind.Execute "UPDATE Products SET UnitPrice = UnitPrice / 1.05"
	
conNorthwind.Close
	
Set conNorthwind = Nothing
