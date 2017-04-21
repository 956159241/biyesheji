<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SuppliesInfoEdit.aspx.cs" Inherits="WebApp.InfoPage.SuppliesInfoEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript">
        function custom_close() {
            if (confirm("您确定不再编辑了么？")) {
                window.opener = null;
                window.open('', '_self');
                window.close();
            }
            else { }
        }
</script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
       <table>
            <tr>
                <td><asp:Label ID="Label1" runat="server" Text="单位编号:"></asp:Label></td>
                <td><asp:TextBox ID="txtNum" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label2" runat="server" Text="单位名称:"></asp:Label></td>
                <td><asp:TextBox ID="txtName" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td><asp:Label ID="lbPrinciple" runat="server" Text="负责人:"></asp:Label></td>
                <td><asp:TextBox ID="txtPrincipal" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label5" runat="server" Text="单位地址:"></asp:Label></td>
                <td><asp:TextBox ID="txtAddress" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label6" runat="server" Text="供货方式:"></asp:Label></td>
                <td><asp:TextBox ID="txtWays" runat="server"></asp:TextBox></td>
            </tr>
           <tr>
                <td><asp:Label ID="Label3" runat="server" Text="联系电话:"></asp:Label></td>
                <td><asp:TextBox ID="txtPhone" runat="server"></asp:TextBox></td>
            </tr>
            <tr>   
                <td><asp:Button ID="btnAdd" runat="server" Text="添加" OnClick="btnAdd_Click" /></td>
                <td><input id="btnClose" type="button" value="关闭本页" onclick="custom_close()" /></td>
            </tr>

        </table>
    </div>
    </form>
</body>
</html>
