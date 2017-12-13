Imports System.Data.SqlClient
Public Class Form1
    Dim strconexion As String = "Data Source=infor150\itziar;Initial Catalog=master;User Id=pepe;Password=pepe;"
    Dim miconexion As New SqlConnection(strconexion)
    Dim micomando As New SqlCommand()
    Dim paramlogin As New SqlParameter()
    Dim parampassword As New SqlParameter()

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        With micomando
            .CommandType = CommandType.StoredProcedure
            .CommandText = "impersonalVBasic"
            .Connection = miconexion
        End With
        With paramlogin
            .SqlDbType = SqlDbType.VarChar
            .Size = 20
            .Direction = ParameterDirection.Input
            .ParameterName = "@iniciosesion"
        End With
        With parampassword
            .SqlDbType = SqlDbType.VarChar
            .Size = 20
            .Direction = ParameterDirection.Input
            .ParameterName = "@contrasena"
        End With
        micomando.Parameters.Add(paramlogin)
        micomando.Parameters.Add(parampassword)
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        micomando.Parameters(0).Value = TextBox1.Text
        micomando.Parameters(1).Value = TextBox2.Text

        miconexion.Open()
        micomando.ExecuteNonQuery()
        miconexion.Close()
    End Sub
End Class
