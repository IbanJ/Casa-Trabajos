/***************************************************Ejemplo: supongamos que queremos aumentar un 5% al precio de los productos. 
El procedimiento manual implicar�a modificar la columna UnitPrice para cada producto.
El proceso autom�tico no puede ser muy diferente, ya que en el comjunto de resultados final 
la columna UnitPrice deber�a contener valores un 5% m�s caros que antes.

Si pensamos c�mo realizar esta operaci�n desde una aplicaci�n cliente, 
por ejemplo en Visual Basic, podr�amos escribir un bucle que leyera un producto
cada vez y que modificara la columna UnitPrice.
****************************************************/
Dim conNorthwind As ADODB.Connection
Dim rstProducts As ADODB.Recordset
	
 conNorthwind = New ADODB.Connection
	
conNorthwind.Provider = "SQLOLEDB"
	
conNorthwind.Open "Server=SRV-AULA;UID=sa;PWD=;Database=Northwind;"
	
Set rstProducts = New ADODB.Recordset
	
rstProducts.Open "select ProductID, UnitPrice FROM Products", conNorthwind, adOpenForwardOnly, adLockPessimistic
	
On Error GoTo CancelChanges
	
conNorthwind.BeginTrans
	
While Not rstProducts.EOF
	rstProducts.Fields("UnitPrice").Value = rstProducts.Fields("UnitPrice").Value * 1.05
	rstProducts.Update
			
	rstProducts.MoveNext
Wend
	
conNorthwind.CommitTrans

GoTo CloseObjects

CancelChanges:
	conNorthwind.RollbackTrans

CloseObjects:

	rstProducts.Close
	conNorthwind.Close
	
	Set rstProducts = Nothing
	Set conNorthwind = Nothing
