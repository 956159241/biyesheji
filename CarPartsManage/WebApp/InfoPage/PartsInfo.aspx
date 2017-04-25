<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PartsInfo.aspx.cs" Inherits="WebApp.InfoPage.PartsInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="../Scripts/jquery-3.2.1.js"></script>
    <style type="text/css">
        body {
            background:rgba(0, 0, 0,0.1);
        }
        #gvParts {
            background:rgba(0,0,0,0.5);
            color:white;
            margin-top:15px;
        }
        #gvParts > tr > td {
            padding:10px;
        }
        /*为两个按钮添加样式*/
        @-webkit-keyframes greenPulse {
            from { background-color: #F58BDF; -webkit-box-shadow: 0 0 9px #EA7BDA; }
            50% { background-color: #EA7BDA; -webkit-box-shadow: 0 0 18px #F58BDF; }
            to { background-color: #EB9DB5; -webkit-box-shadow: 0 0 9px #EA7BDA; }
        }
        #btnAdd,#btnDelete{
         -webkit-animation-name: greenPulse;
         -webkit-animation-duration: 2s;
        -webkit-animation-iteration-count: infinite;
        }
        /*对超链接统一定义样式*/
        a {
            text-decoration:none;
            color:#909090;
        }
        td,th {
            padding:5px;
        }
    </style>
    <script type="text/javascript">
        function linkToPart(id) {
            window.open('PartsInfoEdit.aspx?pid=' + id , '_blank', 'width=600,height=400,top=100px');
        }
        $(function () {
            $("#btnAdd").click(function () {
                window.open('PartsInfoEdit.aspx', '_blank', 'width=600,height=400,top=100px');
            });
            <%--$("#linkToPartInfoEdit").click(function () {
                window.open('PartsInfoEdit.aspx?cid=<%# Eval("PartId") %>', '_blank', 'width=600,height=400,top=100px');
            });--%>

        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Button ID="btnAdd" runat="server" Text="添加" />
        <asp:Button ID="btnDelete" runat="server" Text="删除" OnClick="btnDelete_Click" />
        <asp:GridView ID="gvParts" runat="server" DataKeyNames="PartId" AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="gvParts_PageIndexChanging">
            <Columns>
                <asp:TemplateField HeaderText="删除">
                     <ItemTemplate>
                         <asp:CheckBox ID="cbSelection" runat="server" />
                     </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Num" HeaderText="编号" />
                <asp:TemplateField HeaderText="名称">
                     <ItemTemplate>
                              <a id="linkToPartInfoEdit" target="_blank" href="javascript:linkToPart(<%# Eval("PartId") %>)">
                            <%#Eval("PartName") %>
                        </a>
                     </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Name" HeaderText="生产单位" />
                <asp:BoundField DataField="InTime" HeaderText="入库时间" />
                <asp:BoundField DataField="Quantity" HeaderText="数量" />
                <asp:BoundField DataField="UnitPrice" HeaderText="单价" />
            </Columns>
            <%--添加分页--%>
             <PagerTemplate>
                当前第:
                <%--//((GridView)Container.NamingContainer)就是为了得到当前的控件--%>
                <asp:Label ID="LabelCurrentPage" runat="server" Text="<%# ((GridView)Container.NamingContainer).PageIndex + 1 %>"></asp:Label>
                页/共:
               <%-- //得到分页页面的总数--%>
                <asp:Label ID="LabelPageCount" runat="server" Text="<%# ((GridView)Container.NamingContainer).PageCount %>"></asp:Label>
                页
                 <%--//如果该分页是首分页，那么该连接就不会显示了.同时对应了自带识别的命令参数CommandArgument--%>
                <asp:LinkButton ID="LinkButtonFirstPage" runat="server" CommandArgument="First" CommandName="Page"
                    Visible='<%#((GridView)Container.NamingContainer).PageIndex != 0 %>'>首页</asp:LinkButton>
                <asp:LinkButton ID="LinkButtonPreviousPage" runat="server" CommandArgument="Prev"
                    CommandName="Page" Visible='<%# ((GridView)Container.NamingContainer).PageIndex != 0 %>'>上一页</asp:LinkButton>
               <%--//如果该分页是尾页，那么该连接就不会显示了--%>
                <asp:LinkButton ID="LinkButtonNextPage" runat="server" CommandArgument="Next" CommandName="Page"
                    Visible='<%# ((GridView)Container.NamingContainer).PageIndex != ((GridView)Container.NamingContainer).PageCount - 1 %>'>下一页</asp:LinkButton>
                <asp:LinkButton ID="LinkButtonLastPage" runat="server" CommandArgument="Last" CommandName="Page"
                    Visible='<%# ((GridView)Container.NamingContainer).PageIndex != ((GridView)Container.NamingContainer).PageCount - 1 %>'>尾页</asp:LinkButton>
                转到第
                <asp:TextBox ID="txtNewPageIndex" runat="server" Width="20px" Text='<%# ((GridView)Container.Parent.Parent).PageIndex + 1 %>'/>页
                <%--//这里将CommandArgument即使点击该按钮e.newIndex 值为3--%>
                <asp:LinkButton ID="btnGo" runat="server" CausesValidation="False" CommandArgument="-2"
                    CommandName="Page" Text="Go"/>
            </PagerTemplate>
        </asp:GridView>
    </div>
    </form>
</body>
    
</html>
