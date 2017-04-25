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
    <style type="text/css">
        body {
            background:url("images/Index.png");
        }
        .top_bar {
            height:60px;
            background:rgba(0,0,0,0.3);
            padding:10px;
            overflow:hidden;
            text-align:center;
            color:#909090;
        }
        .bottom_bar {
            height:40px;
            background:rgba(0,0,0,0.2);
            padding:10px;
            overflow:hidden;
            text-align:center;
            color:#909090;
        }
        .left_nav {
            width:150px;
            padding:10px;
            background:rgba(0,0,0,0.3);
        }
        .layout-split-west {
            border-right: 5px solid;
        }
        .panel-header, .panel-body {
            border-color: rgba(0,0,0,0.3);
        }
        .panel-header {
            background:rgba(0,0,0,0.2);          
        }
        .panel-title {
            color:#FFDB7F;
        }
        .nv_item{
            font-size:20px;
            padding:20px;
        }
        .nv_item>a {
            text-decoration:none;
            color:#77A4D1;
        }
       .nv_item > a:hover {
            color:#AB8198;     
       }
        .layout-expand {
            background:none;
        }
        .layout-expand .panel-header, .layout-expand .panel-body {

            background:rgba(0,0,0,0.2); 
        }
        /*右侧的信息内容样式*/
        .tabs li.tabs-selected a.tabs-inner {
                background: rgba(0,0,0,0.3);
                color:#DA70D6;
                background: -webkit-linear-gradient(top,rgba(255,255,255,0.3) 0,rgba(0,0,0,0.3) 100%);
                background: -moz-linear-gradient(top,rgba(255,255,255,0.3) 0,rgba(0,0,0,0.3) 100%);
                background: -o-linear-gradient(top,rgba(255,255,255,0.3) 0,rgba(0,0,0,0.3) 100%);
                background: linear-gradient(to bottom,rgba(255,255,255,0.3) 0,rgba(0,0,0,0.3) 100%);
                background-repeat: repeat-x;
                filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=rgba(255,255,255,0.3),endColorstr=rgba(0,0,0,0.3),GradientType=0);
        }
        .tabs li a.tabs-inner {
                background: rgba(0,0,0,0.3);
                color:#909090;
                background: -webkit-linear-gradient(top,rgba(255,255,255,0.3) 0,rgba(0,0,0,0.3) 100%);
                background: -moz-linear-gradient(top,rgba(255,255,255,0.3) 0,rgba(0,0,0,0.3) 100%);
                background: -o-linear-gradient(top,rgba(255,255,255,0.3) 0,rgba(0,0,0,0.3) 100%);
                background: linear-gradient(to bottom,rgba(255,255,255,0.3) 0,rgba(0,0,0,0.3) 100%);
                background-repeat: repeat-x;
                filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=rgba(255,255,255,0.3),endColorstr=rgba(0,0,0,0.3),GradientType=0);
        }
        .tabs-header, .tabs-tool {
            background:rgba(0,0,0,0.1);
        }
        .tabs-scroller-right,.tabs-scroller-left {
            border:1px solid black;
        }
        .right {
            background:rgba(0,0,0,0.1);
        }
        .panel-body {
            overflow:hidden;
            background:rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <form id="formContent" runat="server">
<div class="easyui-layout" style="width:960px; height:800px;margin:50px auto;">
        <%--采用easy-ui布局--%>
        <%--头部导航--%>
        <div data-options="region:'north',border:false" class="top_bar">
            <h1>汽车仓储管理系统</h1>
        </div>
        <%--头部导航结束--%>
	    <%--左侧的切换选择--%>
        <div data-options="region:'west',split:true,title:'信息总览'" class="left_nav">
            <ul class="main_nv">
                <li class="nv_item"><a href="javascript:void(0)" class="linkToPage" url="InfoPage/PartsInfo.aspx">配件信息</a></li>
                <li class="nv_item"><a href="javascript:void(0)" class="linkToPage" url="InfoPage/Supplies.aspx">供应商信息</a></li>
                <li class="nv_item"><a href="javascript:void(0)" class="linkToPage" url="InfoPage/NeedMerchant.aspx">需求商信息</a></li>
                <li class="nv_item"><a href="javascript:void(0)" class="linkToPage" url="InfoPage/Manager.aspx">管理员信息</a></li>
                <li class="nv_item"><a href="javascript:void(0)" class="linkToPage" url="InfoPage/Log.aspx">操作日志</a></li>
            </ul>
        </div>
        <%--左侧的切换选择结束--%>
	    <%--底部标注信息--%>
        <div data-options="region:'south',border:false" class="bottom_bar">
            <h3>此系统仅供本公司人员使用</h3>
        </div>
        <%--底部标注信息结束--%>
	    <%--核心内容展示区域--%>
        <div data-options="region:'center',title:'信息管理'" class="right">
             <div class="easyui-tabs" style="width:700px;height:250px;" class="right" fit="true" id="tt">
		        <div title="配件信息" style="padding:10px;overflow:hidden;"class="right">
                    <iframe src="InfoPage/PartsInfo.aspx" scrolling="no" width="100%" height="100%" frameborder="0"></iframe>
		        </div>
	        </div>
        </div>
        <%--核心内容展示区域结束--%>
</div>
    </form>
</body>
</html>
