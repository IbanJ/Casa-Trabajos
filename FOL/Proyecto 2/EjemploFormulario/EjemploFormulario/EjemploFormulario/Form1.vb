Public Class Form1
    Private Sub CategoríasToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles CategoríasToolStripMenuItem.Click
        Dim f As New FrmCategorias
        f.MdiParent = Me
        f.Show()

    End Sub
End Class
