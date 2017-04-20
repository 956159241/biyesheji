<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index1.aspx.cs" Inherits="WebApp.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="Content/jquery-easyui-1.5.2/jquery.min.js"></script>
    <script src="Content/jquery-easyui-1.5.2/jquery.easyui.min.js"></script>
    <link href="Content/jquery-easyui-1.5.2/themes/default/easyui.css" rel="stylesheet" />
    <link href="Content/jquery-easyui-1.5.2/themes/icon.css" rel="stylesheet" />

    <style type="text/css">
        body {
            background:#000;
            color:#bdaeae;
            font-family:verdana,helvetica,arial,sans-serif;
            padding:20px;
            font-size:12px;
            margin:0;
        }
    </style>
    <script type="text/javascript">
     $(function () {
            binClickEvent();
        });
        function binClickEvent() {
            //绑定超链接的单击事件
            $(".linkToPage").click(function () {
                var title = $(this).text();
                var url = $(this).attr("url");
                var isExt = $('#tt').tabs('exists', title);//判断页签是否存在
                if (isExt) {
                    $('#tt').tabs('select', title);
                    return;
                }

                $('#tt').tabs('add', {
                    title: title,
                    content: showContent(url),
                    closable: true
                });
            });
        }
        //页签中显示的内容
        function showContent(url) {
            var strHtml = '<iframe src="' + url + '" scrolling="no" width="100%" height="100%" frameborder="0"></iframe>';
            return strHtml;
        }
</script>
</head>
<body class="easyui-layout">
    <form id="form1" runat="server">
     <%--采用easy-ui布局--%>
        <%--头部导航--%>
        <div data-options="region:'north',border:false" style="height:60px;background:#B3DFDA;padding:10px">头部导航</div>
        <%--头部导航结束--%>
	    <%--左侧的切换选择--%>
        <div data-options="region:'west',split:true,title:'West'" style="width:150px;padding:10px;">
            <ul>
                <li><a href="javascript:void(0)" class="linkToPage" url="InfoPage/PartsInfo.aspx">配件信息</a></li>
                <li><a href="javascript:void(0)" class="linkToPage" url="InfoPage/Supplies.aspx">供应商信息</a></li>
                <li><a href="javascript:void(0)" class="linkToPage" url="InfoPage/NeedMerchant.aspx">需求商信息</a></li>
                <li><a href="javascript:void(0)" class="linkToPage" url="">管理员信息</a></li>
                <li><a href="javascript:void(0)" class="linkToPage" url="">操作日志</a></li>
            </ul>
        </div>
        <%--左侧的切换选择结束--%>
	    <%--底部标注信息--%>
        <div data-options="region:'south',border:false" style="height:50px;background:#A9FACD;padding:10px;">底部的标注信息行</div>
        <%--底部标注信息结束--%>
	    <%--核心内容展示区域--%>
        <div data-options="region:'center',title:'Center'" >
             <div class="easyui-tabs" style="width:700px;height:250px;" fit="true" id="tt">
		        <div title="配件信息" style="padding:10px;overflow:hidden;">
                    <iframe src="InfoPage/PartsInfo.aspx" scrolling="no" width="100%" height="100%" frameborder="0"></iframe>
		        </div>
	        </div>
        </div>
        <%--核心内容展示区域结束--%>
    </form>
</body>
</html>
