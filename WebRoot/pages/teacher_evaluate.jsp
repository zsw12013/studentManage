<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>查找老师</title>
	<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.3/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.3/themes/icon.css">
	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	$(function(){
		$("#dg").datagrid({
					url:"../show_evaluate.do?t_id=${id}",
					columns:[[
						{field:'content',title:'评论内容',width:300}			
					]],
					toolbar:'#toolbar',  //表格菜单
					loadMsg:'嗖 ----正在火速加载中 -------------', //加载提示
					rownumbers:true, //显示行号列
					singleSelect:true,
					fitColumns:true,
					fit:true,
					onLoadSuccess:function(data){
						var zan = data.zanNum;
						if(parseInt(zan)>10){
							$("#tip").html("恭喜您，已经备受学生喜爱啦~");
						}else{
							$("#tip").html("学生喜爱度不高啊，是不是上课太严肃了？");
						}
						$("#zan").html(zan);
					}
	});
	});
	
	</script>
  </head>
  
  <body>
	<table id="dg"></table>
	<div id="toolbar">
		收到的赞：<span id="zan"></span> 次！ <span id="tip"></span>
	</div>
  </body>
</html>
