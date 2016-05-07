<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>班级管理</title>
    	<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.3/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.3/themes/icon.css">
	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
	$(function(){
	 	$('input.easyui-validatebox').validatebox('disableValidation')
            .focus(function () { $(this).validatebox('enableValidation'); })
            .blur(function () { $(this).validatebox('validate'); });
	// 实例化树菜单
		$("#tree").tree({
			url:'../show_classes.do?id=-1',
			 onBeforeExpand:function(node,param){  
                     $('#tree').tree('options').url = "../show_classes.do?id=" + node.id;
                     $('#dg').datagrid('load', {    
					    id: node.id    
					});  
                 },  
               loadFilter: function(data){    
                  if (data.msg){    
                      return data.msg;    
                 } else {    
                     return data;    
                 }    
            }, 
			lines : true,
			onClick : function(node) {
				
			}
		});
		
		$("#dg").datagrid({
			url:"../show_allclasses.do",
			columns:[[ 
				{field:'text',title:'子节点名称',width:100},
				{field:'status',title:'状态',width:100,
					formatter: function(value,row,index){
						var result="";
                 		  	if(value=="0"){
                 		  		result="已停用";
                 		  	}else if(value=="1"){
                 		  		result="已启用";
                 		  	}
                 		  	return result;
					}
				}
			]],
			toolbar:'#buttons',  //表格菜单
			loadMsg:'嗖 ----正在火速加载中 -------------', //加载提示
			pagination:true, //显示分页工具栏
			rownumbers:true, //显示行号列
			singleSelect:true,//是允许选择一行
			selectOnCheck:false,
			checkOnSelect:true, //复选框
			queryParams:{   //在请求数据是发送的额外参数，如果没有则不用谢
				id:""
			},
			fit:true
		});
	});
	//添加节点 | 保存
	function add(){
		var node = $('#tree').tree('getSelected');
		if(node){
			 $('#add_dlg').dialog('open').dialog('setTitle', '添加子节点');
		}else $.messager.alert("提示","请选择父节点");
	}
	function save_add(){
		var node = $('#tree').tree('getSelected');
		$.ajax({
			url:"../add_node.do",
			type:"post",
			dataType:"json",
			data:{
				pid:node.id,
				text:$("#name").val()
			},
			success:function(data){
				 	if(data.status == "success"){
						$('#add_dlg').dialog('close'); 
						$.messager.show({
							title : '提示',
							msg : '添加成功'
						});
						$("#tree").tree({
							url:'../show_classes.do?id=-1'
						});
					}else{
						$.messager.show({
							title : '提示',
							msg : '添加失败，请联系管理员 ------'
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
	}
	//编辑节点 | 保存
	function update(){
		var node = $('#tree').tree('getSelected');
		if(node){
			$('#update_dlg').dialog('open').dialog('setTitle', '更新节点名称');
			document.getElementById("oldname").value=node.text;
		}else $.messager.alert("提示","请选择要操作的节点");
	}
	function save_update(){
		var node = $('#tree').tree('getSelected');
		$.ajax({
				url:"../update_node.do",
				type:"post",
				dataType:"json",
				data:{
					id:node.id,
					text:$("#update_name").val()
				},
				success:function(data){
				 	if(data.status == "success"){
						$('#update_dlg').dialog('close'); 
						$.messager.show({
							title : '提示',
							msg : '更新成功'
						});
						$("#tree").tree({
							url:'../show_classes.do?id=-1'
						});
					}else{
						$.messager.show({
							title : '提示',
							msg : '更新失败，请联系管理员 ------'
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
	}
	//停用节点
	function del(){
		var node = $('#tree').tree('getSelected');
 		if(node){
			$.ajax({
				url:"../disabled_node.do",
				type:"post",
				dataType:"json",
				data:{
					id:node.id
				},
					success:function(data){
				 	if(data.status == "success"){
						$.messager.show({
							title : '提示',
							msg : '节点已停用成功'
						});
						$("#tree").tree({
							url:'../show_classes.do?id=-1'
						});
					}else{
						$.messager.show({
							title : '提示',
							msg : '停用失败，请联系管理员 ------'
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
		}else $.messager.alert("提示","请选择要停用的节点");
	}
	//列表停用节点
	function removeNode(){
		var row= $('#dg').datagrid('getSelected');
 		if(row){
			$.ajax({
				url:"../disabled_node.do",
				type:"post",
				dataType:"json",
				data:{
					id:row.id
				},
					success:function(data){
				 	if(data.status == "success"){
						$.messager.show({
							title : '提示',
							msg : '节点已停用成功'
						});
						$("#tree").tree({
							url:'../show_classes.do?id=-1'
						});
						$('#dg').datagrid('reload');
					}else{
						$.messager.show({
							title : '提示',
							msg : '停用失败，请联系管理员 ------'
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
		}else $.messager.alert("提示","请选择一行数据");
	}
	function openNode(){
	var row= $('#dg').datagrid('getSelected');
 		if(row){
			$.ajax({
				url:"../open_node.do",
				type:"post",
				dataType:"json",
				data:{
					id:row.id
				},
					success:function(data){
				 	if(data.status == "success"){
						$.messager.show({
							title : '提示',
							msg : '节点启用成功'
						});
						$("#tree").tree({
							url:'../show_classes.do?id=-1'
						});
						$('#dg').datagrid('reload');
					}else{
						$.messager.show({
							title : '提示',
							msg : '启用失败，请联系管理员 ------'
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
		}else $.messager.alert("提示","请选择一行数据");
	}
	</script>
	<style>
		#fm {
			margin: 0;
			padding: 10px 30px;
		}
		
		.ftitle {
			font-size: 14px;
			font-weight: bold;
			color: #666;
			padding: 5px 0;
			margin-bottom: 10px;
			border-bottom: 1px solid #ccc;
		}
		
		.fitem {
			margin-bottom: 5px;
		}
		
		.fitem label {
			display: inline-block;
			width: 80px;
		} 
	
	</style>
  </head>
  <body>
  <div id="cc1" class="easyui-layout" data-options="fit:true">   
	  <div data-options="region:'west'" style="width: 320px" >
		<div id="tree" class="easyui-panel" title="编辑学院-专业-班级树" style="width:400px;height:340px;padding:10px;"
				data-options="iconCls:'icon-save',closable:false,tools:'#tt',fit:true">
		</div>
	  </div>
	  <div data-options="region:'center', fit:'true'">
		<div id="table" class="easyui-panel" style="height:100%" title="详细" >
				<table id="dg"></table>
				<div id="buttons">
					<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="openNode()">启用</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="removeNode()">停用</a>
				</div>
	  	</div> 	
	  </div>
	</div>
		<div id="tt">
			<a href="javascript:void(0)" class="icon-add" onclick="add()"></a>
			<a href="javascript:void(0)" class="icon-edit" onclick="update()"></a>
			<a href="javascript:void(0)" class="icon-save" onclick="save_update()"></a>
			<a href="javascript:void(0)" class="icon-remove" onclick="del()"></a>
		</div>
	 
		<!-- 添加窗口 -->
		<div id="add_dlg" class="easyui-dialog"
			style="width:300px;height:120px;padding:10px 20px" closed="true"
			buttons="#add_dlg-buttons">
			<form id="addform" method="post">
				<div class="fitem">
					<label>节点名称：</label> <input id="name" name="name" type="text" class="easyui-validatebox"
						required="true">
				</div>
			</form>
		</div>
	
		<!-- 添加窗口工具栏 -->
		<div id="add_dlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
				onclick="save_add()">提交</a> <a href="#" class="easyui-linkbutton"
				iconCls="icon-cancel"
				onclick="javascript:$('#add_dlg').dialog('close')">取消</a>
		</div>
		
		<!-- 更新窗口 -->
		<div id="update_dlg" class="easyui-dialog"
			style="width:300px;height:220px;padding:10px 20px" closed="true"
			buttons="#update_dlg-buttons">
			<form id="updateform" method="post">
				<div class="fitem">
					<label>节点名称 ：</label> <input id="oldname" name="name"  disabled type="text" />
				</div>
				<div class="fitem">
					<label>更新节点名称为 ：</label> <input id="update_name" name="name"  type="text" />
				</div>
			</form>
		</div>
	
		<!-- 更新窗口工具栏 -->
		<div id="update_dlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
				onclick="save_update()">提交</a> <a href="#" class="easyui-linkbutton"
				iconCls="icon-cancel"
				onclick="javascript:$('#update_dlg').dialog('close')">取消</a>
		</div>
  </body>
</html>
