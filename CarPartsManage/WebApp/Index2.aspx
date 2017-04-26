<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index2.aspx.cs" Inherits="WebApp.Index2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="Scripts/jquery-3.2.1.js"></script>
    <script type="text/javascript">
        function linkToPart(id) {
            window.open('InfoPage/NeedMerchantEdit.aspx?nid=' + id, '_blank', 'width=600,height=400,top=100px');
        }
        $(function () {
            $("#btnAdd").click(function () {
                window.open('InfoPage/NeedMerchantEdit.aspx', '_blank', 'width=600,height=400,top=100px');
                return false;
            });
            $("#ddlType").change(function () {
                if ($(this).val() == "出库") {
                    $(".direction").css("display", "inline");
                } else {
                    $(".direction").css("display", "none");
                }
            });
        });
    </script>
    <style type="text/css">
        .showIn,.direction {
            display:none;
        }
        body {
            width:960px;
            background:url("images/Index2Bg.jpg");
            background-size:100%;
            margin:50px auto;
        }
         #gvNeedMer,#gvParts {
            background:rgba(0,0,0,0.5);
            color:white;
            margin:15px auto;
        }
          /*对超链接统一定义样式*/
        a {
            text-decoration:none;
            color:#909090;
        }
        td,th {
            padding:5px;
        }
         /*为两个按钮添加样式*/
        @-webkit-keyframes greenPulse {
            from { background-color: #F58BDF; -webkit-box-shadow: 0 0 9px #EA7BDA; }
            50% { background-color: #EA7BDA; -webkit-box-shadow: 0 0 18px #F58BDF; }
            to { background-color: #EB9DB5; -webkit-box-shadow: 0 0 9px #EA7BDA; }
        }
        #btnConfirm{
         -webkit-animation-name: greenPulse;
         -webkit-animation-duration: 2s;
        -webkit-animation-iteration-count: infinite;
        margin-left:10px;
        }
        input {
            border:none;
        }
        #txtNum, #txtQuantity,#txtNeedMerchant {
            width:60px;
        }
    </style>
</head>
<body>
    <h1 class="top_title" style="margin-bottom:100px;text-align:center;">汽车配件的出库/入库</h1>
    <form id="form1" runat="server">
    <div>
         <%--<asp:Button ID="btnAdd" runat="server" Text="添加" />--%>
<%---------------------------------需求商信息--------------------------------------------------%>
        <asp:GridView ID="gvNeedMer" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" AllowPaging="True" OnPageIndexChanging="gvParts_PageIndexChanging">
            <Columns>
                <asp:CheckBoxField DataField="IsDeliver" HeaderText="已发货" />
                <asp:BoundField DataField="Num" HeaderText="编号" />
                <asp:TemplateField HeaderText="单位名称">
                     <ItemTemplate>
                              <a id="linkToPartInfoEdit" target="_blank" href="javascript:linkToPart(<%# Eval("Id") %>)">
                            <%#Eval("Name") %>
                        </a>
                     </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Principal" HeaderText="负责人" />
                <asp:BoundField DataField="Address" HeaderText="地址" />
                <asp:BoundField DataField="Phone" HeaderText="联系电话" />
                <asp:TemplateField HeaderText="添加">
                     <ItemTemplate>
                            <input type="button" id="btnAdd" value="添加"/>
                     </ItemTemplate>
                </asp:TemplateField>
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
<%---------------------------------需求商信息结束--------------------------------------------------%>
<%---------------------------------配件信息表--------------------------------------------------%>
        <div class="input_info" style="width:620px;margin:15px auto;color:white;">
        <span>操作类型：</span>
        <asp:DropDownList ID="ddlType" runat="server">
            <asp:ListItem>入库</asp:ListItem>
            <asp:ListItem>出库</asp:ListItem>
        </asp:DropDownList>
        <span>编号：</span>
        <asp:TextBox runat="server" ID="txtNum"></asp:TextBox>
        <span>数量：</span>
        <asp:TextBox runat="server" ID="txtQuantity"></asp:TextBox>
        <div class="direction">
            <span>需求商编号：</span>
            <asp:TextBox runat="server" ID="txtNeedMerchant"></asp:TextBox>
        </div>
        <asp:Button runat="server" Text="确认" ID="btnConfirm" OnClick="btnConfirm_Click"></asp:Button>
        </div>
        <asp:GridView ID="gvParts" runat="server" DataKeyNames="PartId" AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="gvParts_PageIndexChanging">
            <Columns>
                <asp:BoundField DataField="Num" HeaderText="编号" />
                 <asp:BoundField DataField="PartName" HeaderText="名称" />
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
