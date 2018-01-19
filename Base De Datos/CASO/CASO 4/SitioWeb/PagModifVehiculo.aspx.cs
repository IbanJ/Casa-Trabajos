using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class PagModifVehiculo : System.Web.UI.Page
{
    SqlConnection conexion = new SqlConnection();
    SqlCommand cmdModificar = new SqlCommand();
    SqlParameter prmCodigo = new SqlParameter();
    SqlParameter prmCapacTrans = new SqlParameter();
    SqlParameter prmMarca = new SqlParameter();
    SqlParameter prmCapacDeposito = new SqlParameter();
    SqlParameter prmITV = new SqlParameter();
    SqlParameter prmDisponibilidad = new SqlParameter();
    SqlParameter prmFechaCompra = new SqlParameter();
    SqlParameter prmCoste = new SqlParameter();
    SqlParameter prmUtil = new SqlParameter();
    SqlParameter prmSalida = new SqlParameter();

    protected void Page_Load(object sender, EventArgs e)
    {
        conexion.ConnectionString = "data source=primero100\\primero;initial catalog=ASIR_ibanjuarros; Integrated Security=SSPI;";

        cmdModificar.CommandType = CommandType.StoredProcedure;
        cmdModificar.CommandText = "TRANSPORTES.PR_MOD_VEHICULO";
        cmdModificar.Connection = conexion;

        prmCodigo.ParameterName = "@p_codigo";
        prmCodigo.SqlDbType = SqlDbType.SmallInt;
        prmCodigo.Direction = ParameterDirection.Input;

        prmCapacTrans.ParameterName = "@p_capacidadTrans";
        prmCapacTrans.SqlDbType = SqlDbType.Int;
        prmCapacTrans.Direction = ParameterDirection.Input;

        prmMarca.ParameterName = "@p_marca";
        prmMarca.SqlDbType = SqlDbType.VarChar;
        prmMarca.Size = 20;
        prmMarca.Direction = ParameterDirection.Input;

        prmCapacDeposito.ParameterName = "@p_capacidadDepo";
        prmCapacDeposito.SqlDbType = SqlDbType.Int;
        prmCapacDeposito.Direction = ParameterDirection.Input;

        prmITV.ParameterName = "@p_itv";
        prmITV.SqlDbType = SqlDbType.Date;
        prmITV.Direction = ParameterDirection.Input;

        prmDisponibilidad.ParameterName = "@p_disponible";
        prmDisponibilidad.SqlDbType = SqlDbType.Char;
        prmDisponibilidad.Size = 2;
        prmDisponibilidad.Direction = ParameterDirection.Input;

        prmFechaCompra.ParameterName = "@p_fechaCompra";
        prmFechaCompra.SqlDbType = SqlDbType.Date;
        prmFechaCompra.Direction = ParameterDirection.Input;

        prmCoste.ParameterName = "@p_coste";
        prmCoste.SqlDbType = SqlDbType.Money;
        prmCoste.Direction = ParameterDirection.Input;

        prmUtil.ParameterName = "@p_vidaUtil";
        prmUtil.SqlDbType = SqlDbType.Int;
        prmUtil.Direction = ParameterDirection.Input;

        prmSalida.ParameterName = "@p_salida";
        prmSalida.SqlDbType = SqlDbType.SmallInt;
        prmSalida.Direction = ParameterDirection.Output;

        cmdModificar.Parameters.Add(prmCodigo);
        cmdModificar.Parameters.Add(prmCapacTrans);
        cmdModificar.Parameters.Add(prmMarca);
        cmdModificar.Parameters.Add(prmCapacDeposito);
        cmdModificar.Parameters.Add(prmITV);
        cmdModificar.Parameters.Add(prmDisponibilidad);
        cmdModificar.Parameters.Add(prmFechaCompra);
        cmdModificar.Parameters.Add(prmCoste);
        cmdModificar.Parameters.Add(prmUtil);
        cmdModificar.Parameters.Add(prmSalida);
    }



    protected void btModificar_Click(object sender, EventArgs e)
    {
        cmdModificar.Parameters[0].Value = int.Parse(txtCodigo.Text);
        cmdModificar.Parameters[1].Value = int.Parse(txtCapacTrans.Text);
        cmdModificar.Parameters[2].Value = txtMarca.Text;
        cmdModificar.Parameters[3].Value = int.Parse(txtCapacDepo.Text);
        cmdModificar.Parameters[4].Value = DateTime.Parse(txtITV.Text);
        cmdModificar.Parameters[5].Value = txtDisponibilidad.Text;
        cmdModificar.Parameters[6].Value = DateTime.Parse(txtFechaCompra.Text);
        cmdModificar.Parameters[7].Value = double.Parse(txtCoste.Text);
        cmdModificar.Parameters[8].Value = int.Parse(txtVida.Text);

        conexion.Open();
        cmdModificar.ExecuteNonQuery();
        conexion.Close();

        lblSalida.Text = cmdModificar.Parameters[9].Value.ToString();
    }
}