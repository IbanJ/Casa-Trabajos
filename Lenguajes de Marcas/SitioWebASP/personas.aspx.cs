using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class personas : System.Web.UI.Page
{
    SqlConnection conexion = new SqlConnection("data source=primero100\\primero;initial catalog=ASIR_ibanjuarros; integrated security=true;");
    SqlCommand cmdAlta = new SqlCommand("INSERT INTO contactos (nombre,correo,edad,ocupacion) VALUES (@nombre,@correo,@edad,@ocupacion)");
    SqlParameter prmNombre = new SqlParameter();
    SqlParameter prmCorreo = new SqlParameter();
    SqlParameter prmEdad = new SqlParameter();
    SqlParameter prmOcupacion = new SqlParameter();
    protected void Page_Load(object sender, EventArgs e)
    {
        cmdAlta.Connection = conexion;

        prmNombre.ParameterName = "@nombre";
        prmNombre.SqlDbType = SqlDbType.VarChar;
        prmNombre.Size = 30;
        prmNombre.Direction = ParameterDirection.Input;

        prmCorreo.ParameterName = "@correo";
        prmCorreo.SqlDbType = SqlDbType.VarChar;
        prmCorreo.Size = 80;
        prmCorreo.Direction = ParameterDirection.Input;

        prmEdad.ParameterName = "@edad";
        prmEdad.SqlDbType = SqlDbType.TinyInt;
        prmEdad.Direction = ParameterDirection.Input;

        prmOcupacion.ParameterName = "@ocupacion";
        prmOcupacion.SqlDbType = SqlDbType.VarChar;
        prmOcupacion.Size = 60;
        prmOcupacion.Direction = ParameterDirection.Input;

        cmdAlta.Parameters.Add(prmNombre);
        cmdAlta.Parameters.Add(prmCorreo);
        cmdAlta.Parameters.Add(prmEdad);
        cmdAlta.Parameters.Add(prmOcupacion);


        cmdAlta.Parameters[0].Value = Request.Form["txtNombre"];
        cmdAlta.Parameters[1].Value = Request.Form["txtEmail"];
        cmdAlta.Parameters[2].Value = Request.Form["txtEdad"];
        cmdAlta.Parameters[3].Value = Request.Form["cboOcupacion"];

        conexion.Open();
        cmdAlta.ExecuteNonQuery();
        conexion.Close();

        lblSalida.Text = "Alta realizada correctamente";
    }
}