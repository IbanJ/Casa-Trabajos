Public Class FrmCategorias
    Private Sub FrmCategorias_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        'TODO: esta línea de código carga datos en la tabla 'BD_DaniDataSet.Categorias' Puede moverla o quitarla según sea necesario.
        Me.CategoriasTableAdapter.Fill(Me.BD_DaniDataSet.Categorias)

    End Sub

    Private Sub CategoriasBindingNavigatorSaveItem_Click(sender As Object, e As EventArgs) Handles CategoriasBindingNavigatorSaveItem.Click
        Me.Validate()
        Me.CategoriasBindingSource.EndEdit()
        Me.TableAdapterManager.UpdateAll(Me.BD_DaniDataSet)

    End Sub
End Class