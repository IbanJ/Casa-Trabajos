<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PagModifVehiculo.aspx.cs" Inherits="PagModifVehiculo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 40%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <h1>Modificación de vehículos</h1><hr />
    <div style="margin-bottom:25px; background-color:bisque">
        Código de vehículo &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtCodigo" runat="server"></asp:TextBox>
    </div>
    <div>        
        <table class="auto-style1">
            <tr>
                <td>Capacidad de transporte</td>
                <td><asp:TextBox ID="txtCapacTrans" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Marca</td>
                <td><asp:TextBox ID="txtMarca" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Capacidad de depósito</td>
                <td><asp:TextBox ID="txtCapacDepo" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>ITV</td>
                <td><asp:TextBox ID="txtITV" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Disponibilidad</td>
                <td><asp:TextBox ID="txtDisponibilidad" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Fecha de compra</td>
                <td><asp:TextBox ID="txtFechaCompra" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Coste</td>
                <td><asp:TextBox ID="txtCoste" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Vida útil</td>
                <td><asp:TextBox ID="txtVida" runat="server"></asp:TextBox></td>
            </tr>
        </table>       
    </div>
    <div style="margin-top:25px; background-color:antiquewhite">
        <asp:Button ID="btModificar" runat="server" Text="Modificar" OnClick="btModificar_Click" />
    </div>
    <asp:Label ID="lblSalida" runat="server" Text="Label"></asp:Label>
    </form>
</body>
</html>
