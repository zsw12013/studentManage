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
			url:"",
			columns:[[ 
				{field:'subject',title:'课程',width:100,editor:'textbox'},
				{field:'teacher',title:'任课教师',width:100,editor:'textbox'},
				{field:'classroom',title:'上课地点',width:100,editor:'textbox'},
				{field:'remark',title:'备注',width:100,editor:'textbox'}
			]],
			toolbar:'#toolbar',  //表格菜单
			loadMsg:'嗖 ----正在火速加载中 -------------', //加载提示
			pagination:true, //显示分页工具栏
			rownumbers:true, //显示行号列
			singleSelect:true,//是允许选择一行
			fit:true
		});
	     $("#term").combobox({
	    	url:"../show_term.do",
	    	valueField:'id',
	    	textField:'name',
	    	onSelect:function(obj){
	   			$("#dg").datagrid({
					url:"../show_sub.do?classid=${classid}&termid="+obj.id
				});
	    	}
	    }); 
	});
	
	</script>
  </head>
  
  <body>
	<table id="dg"></table>
	<div id="toolbar">
		 学期：<input id="term" onblur="selectSub()" /> 
	</div>
  </body>
</html>
