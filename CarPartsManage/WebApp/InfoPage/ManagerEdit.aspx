<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManagerEdit.aspx.cs" Inherits="WebApp.InfoPage.ManagerEdit" %>

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
                <td><asp:Label ID="Label2" runat="server" Text="用户名："></asp:Label></td>
                <td><asp:TextBox ID="txtUserName" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td><asp:Label ID="lbTime" runat="server" Text="用户密码："></asp:Label></td>
                <td><asp:TextBox ID="txtPassword" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label5" runat="server" Text="所属部门:"></asp:Label></td>
                <td><asp:TextBox ID="txtDepartment" runat="server"></asp:TextBox></td>
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
