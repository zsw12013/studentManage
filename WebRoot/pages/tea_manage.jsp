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
			url:"../show_tea.do",
			columns:[[ 
				{field:'name',title:'姓名',width:200},
				{field:'email',title:'邮箱',width:200},
				{field:'zanNum',title:'被点赞',width:200,sortable:true},
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
	
	//添加|保存
	function add(){
		var row = $('#dg').datagrid('getSelected');
			$('#add_dlg').dialog('open').dialog('setTitle', '添加教师');
			$('#addform').form('clear');
	}
	function save_add(){
	 //alert($('#a_birth').datebox('getValue'));
		var name=$("#a_name").textbox('getValue');
		var email=$("#a_email").textbox('getValue');
		$.ajax({
				url:"../add_tea.do",
				type:"post",
				dataType:"json",
				data:{
					name:name,
					email:email
				},
				success:function(data){
				 	if(data.status == "success"){
						$('#add_dlg').dialog('close'); 
						$.messager.show({
							title : '提示',
							msg : '添加成功'
						});
						$('#dg').datagrid('load', {});
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
	
	//更新|保存
	function update(){
		var row = $('#dg').datagrid('getSelected');
		if(row){
			$('#update_dlg').dialog('open').dialog('setTitle', '更新');
		    $('#u_name').textbox('setValue',row.name);
		    $('#u_email').textbox('setValue',row.email);
		}else $.messager.alert("提示","请选择一行");
	}
	function save_update(){
		//用了easyui的样式，就必须要这样取值了 赋值用setValue 见上面   
		var row = $('#dg').datagrid('getSelected');
		var id=row.id;
		var name=$('#u_name').textbox('getValue');
		var email=$('#u_email').textbox('getValue');
		//alert(birth);
		$.ajax({
				url:"../update_tea.do",
				type:"post",
				dataType:"json",
				data:{
					id:id,
					name:name,
					email:email
				},
				success:function(data){
				 	if(data.status == "success"){
						$('#update_dlg').dialog('close'); 
						$.messager.show({
							title : '提示',
							msg : '更新成功'
						});
						$('#dg').datagrid('load', {});
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
	
	//删除
	function del(){
		var row = $('#dg').datagrid('getSelected');
		if(row){
			$.ajax({
				url:"../del_tea.do",
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
		}else $.messager.alert("提示","请选择一行！");
	}
	
	//发送邮件
	function send_email(){
		var row = $('#dg').datagrid('getSelected');
		if(row){
			$('#update_dlg').dialog('open').dialog('setTitle', '邮件信息');
		    $('#u_birth').textbox('setValue',row.birth);
		}else $.messager.alert("提示","请选择学生");
	}
	
	//模糊查询
	function search(){
		var param = $('#param').textbox('getValue');
		if(param){
			$('#dg').datagrid('load', {    
			    param: param    
			});  
		}
	}
	
	//查看评价
	function view_evaluate(){
		var row = $('#dg').datagrid('getSelected');
		if(row){
			$('#view_dlg').dialog('open').dialog('setTitle', '学生评价');
				$("#view_dg").datagrid({
					url:"../show_evaluate.do?t_id="+row.id,
					columns:[[
						{field:'content',title:'评论内容',width:300}			
					]],
					toolbar:'#view_toolbar',  //表格菜单
					loadMsg:'嗖 ----正在火速加载中 -------------', //加载提示
					rownumbers:true, //显示行号列
					singleSelect:true,
					fitColumns:true,
					fit:true,
					height:'200px'
		});
		}else $.messager.alert("提示","请选择一位老师");
	}
	//删除评价
	function del_evaluate(){
		var row = $('#view_dg').datagrid('getSelected');
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
						$('#view_dg').datagrid('load', {});
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
	//更换列名
	//可以通过ajax获取列名信息
	function columns(){
		var name=""
		$("#dg").datagrid({
			url:"../show_tea.do",
			columns:[[ 
				{field:'name',title:'哈哈',width:200},
				{field:'email',title:'你哈',width:200},
				{field:'zanNum',title:'被到底',width:200,sortable:true},
			]],
			toolbar:'#toolbar',  //表格菜单
			loadMsg:'嗖 ----正在火速加载中 -------------', //加载提示
			pagination:true, //显示分页工具栏
			rownumbers:true, //显示行号列
			singleSelect:true,
			fit:true,
			height:'400px'
		});
	}
	</script>
	<style type="text/css">
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
		#tree{
			position:absolute;
			width:180px;
			height:300px;
			top:40px;
			left:20px;
			float:left;
			padding:5px;
		}
		
		#table{
			position:absolute;
			width:250px;
			height:400px;
			top:0px;
			left:300px;
			float:right;
		}
</style>
  </head>
  <body>
	<table id="dg"></table>
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="add()" >添加</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="update()" >更新</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="del()" >删除</a>
		<input id="param" name="search_input"  class="easyui-textbox" type="text"/>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"  onclick="search()" >模糊查询</a>
		<a href="#" class="easyui-linkbutton"  onclick="view_evaluate()" >查看评价</a>
	</div>
	<!-- 添加窗口 -->
	<div id="add_dlg" class="easyui-dialog"
		style="width:430px;height:280px;padding:10px 20px" closed="true"
		buttons="#add_dlg-buttons">
		<form id="addform" method="post">
			<table cellpadding="3">
				<tr>
					<td><label>姓名</label></td>
					<td><input id="a_name" name="name" data-options="required:true" class="easyui-textbox" type="text"/></td>
				</tr>
				<tr>
					<td><label>email</label></td>
					<td><input id="a_email" name="email" class="easyui-textbox" data-options="required:true,validType:'email'" type="text"/></td>
				</tr>
			</table>
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
		style="width:430px;height:280px;padding:10px 20px" closed="true"
		buttons="#update_dlg-buttons">
		<form id="updateform" method="post">
			<table cellpadding="3">
				<tr>
					<td><label>姓名</label></td>
					<td><input id="u_name" name="name" data-options="required:true" class="easyui-textbox" type="text"/></td>
				</tr>
				<tr>
					<td><label>email</label></td>
					<td><input id="u_email" name="email" class="easyui-textbox" data-options="required:true,validType:'email'" type="text"/></td>
				</tr>
			</table>
		</form>
	</div>

	<!-- 更新窗口工具栏 -->
	<div id="update_dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
			onclick="save_update()">提交</a> <a href="#" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#update_dlg').dialog('close')">取消</a>
	</div>
	
	<!-- 查看评价 -->
	<div id="view_dlg" class="easyui-dialog"
		style="width:430px;height:280px" closed="true"
		buttons="#view_dlg-buttons">
		<table id="view_dg"></table>
	</div>

	<div id="view_toolbar">
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="del_evaluate()" >删除</a>
	</div>
  </body>
</html>
