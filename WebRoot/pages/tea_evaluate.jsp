<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>教师管理</title>
	<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.3/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.3/themes/icon.css">
	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	$(function(){
		//信息表格
		$("#dg").datagrid({
			url:"../show_all_evaluate.do",
			columns:[[ 
				{field:'name',title:'教师姓名',width:200},
				{field:'content',title:'收到的评价',width:500},
			]],
			toolbar:'#toolbar',  //表格菜单
			loadMsg:'嗖 ----正在火速加载中 -------------', //加载提示
			pagination:true, //显示分页工具栏
			rownumbers:true, //显示行号列
			singleSelect:true,
			fit:true,
			height:'400px'
		});
	});
	
	//删除评价 
	function del_evaluate(){
		var row = $('#dg').datagrid('getSelected');
		if(row){
			$.ajax({
				url:"../del_evaluate.do",
				type:"post",
				dataType:"json",
				data:{
					id:row.id
				},
					success:function(data){
				 	if(data.status == "success"){
						$.messager.show({
							title : '提示',
							msg : '删除成功'
						});
						$('#dg').datagrid('load', {});
					}else{
						$.messager.show({
							title : '提示',
							msg : '删除失败，请联系管理员 ------'
						});
					}
				},
				error:function(){
						$.messager.show({
							title : '提示',
							msg : '系统错误，请联系管理员------'
						});
				}
			});
		}else $.messager.alert("提示","请选择要删除的评价")
	}

	</script>
	
  </head>
  <body>
	<table id="dg"></table>
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="del_evaluate()" >删除</a>
	</div>
  </body>
</html>
