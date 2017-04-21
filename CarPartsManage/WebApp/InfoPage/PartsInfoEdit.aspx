<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PartsInfoEdit.aspx.cs" Inherits="WebApp.InfoPage.PartsInfoEdit" %>

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
                <td><asp:Label ID="Label1" runat="server" Text="编号:"></asp:Label></td>
                <td><asp:TextBox ID="txtNum" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label2" runat="server" Text="名称:"></asp:Label></td>
                <td><asp:TextBox ID="txtPartName" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label3" runat="server" Text="生产单位:"></asp:Label></td>
                <td><asp:DropDownList ID="ddlFromDep" runat="server"></asp:DropDownList>
                    <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" SelectCommand="SELECT [Name], [Id] FROM [Supplies]"></asp:SqlDataSource>--%>
                </td>     
            </tr>
            <tr>
                <td><asp:Label ID="lbTime" runat="server" Text="入库时间:"></asp:Label></td>
                <td><asp:TextBox ID="txtInTime" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label5" runat="server" Text="数量:"></asp:Label></td>
                <td><asp:TextBox ID="txtQuantity" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label6" runat="server" Text="单价:"></asp:Label></td>
                <td><asp:TextBox ID="txtUnitPrice" runat="server"></asp:TextBox></td>
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
