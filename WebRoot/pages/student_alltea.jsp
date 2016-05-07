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
		//信息表格
		$("#dg").datagrid({
			url:"../show_tea.do",
			columns:[[ 
				{field:'name',title:'姓名',width:200},
				{field:'email',title:'邮箱',width:200},
				{field:'zanNum',title:'被点赞',width:200,sortable:true},
				{field:'operate',title:'操作',sortable:true,align:'center',width:100,
					formatter: function(value,row,index){
							return '<a style="color:blue;" href="#" onclick="addEvaluate('+row.id+')">评价</a>'+
							'&nbsp;<a style="color:blue;" href="#" onclick="zan('+row.id+')">点赞</a>';							;
					}
				}
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
	
	var t_id = "";
	function addEvaluate(id){
		$('#e_dlg').dialog('open').dialog('setTitle', '发表评价');
		t_id = id;
		
	}
	function save_e(){
	var content = $("#content").val();
		$.ajax({    
		 	  type:'post',      
	          url:'../add_evaluate.do',  
	          data:{
					t_id:t_id,
					s_id:"${id}",
					content:content
			  },  
	          dataType:'json',  
	          success:function(data){
	        	  if(data.status="success"){
	        		  $.messager.alert("提示","评价成功");
	        		  $('#e_dlg').dialog('close');
	        	  }else{
	        		   $.messager.alert("提示","评价失败");
	        	  }
	          }  
	      });  
		
	}
	function zan(id){
		$.ajax({    
		 	  type:'post',      
	          url:'../zanTea.do',  
	          data:{
					t_id:id,
					s_id:"${id}"
			  },  
	          dataType:'json',  
	          success:function(data){
	        	  if(data.status=="success"){
	        		  $.messager.alert("提示","点赞成功");
	        		  $("#dg").datagrid("reload");
	        	  }else{
	        		   $.messager.alert("提示","您已经为该老师点过赞了，不能重复点赞");
	        	  }
	          },
	          error:function(){
	          	$.messager.alert("提示","系统错误");
	          }
	      });  
	
	}
	//发送邮件
	function send_email(){
		var row = $('#dg').datagrid('getSelected');
		if(row){
			$('#dlg').dialog('open').dialog('setTitle', '邮件信息');
		}else $.messager.alert("提示","请选择老师");
	}
	
	function save_email(){
		var row = $('#dg').datagrid('getSelected');
		$.ajax({    
		 	  type:'post',      
	          url:'../send_email.do',  
	          data:{
					subject:$("#subject").val(),
					email:"${email}",
					content:$("#email_content").val(),
					toemail:row.email,
					password:$("#password").val()
			  },  
	          dataType:'json',  
	          success:function(data){
	        	  if(data.status="success"){
	        		  $.messager.alert("提示","邮件发送成功");
	        		  $('#dlg').dialog('close');
	        	  }else{
	        		   $.messager.alert("提示","邮件发送失败，请确认密码是否正确");
	        	  }
	          }  
	      });  
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
		<input id="param" name="search_input"  class="easyui-textbox" type="text"/>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"  onclick="search()" >模糊查询</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="send_email()" >发送邮件</a>
		<a href="#" class="easyui-linkbutton"  onclick="view_evaluate()" >查看评价</a>
	</div>
	
	<!-- 查看评价 -->
	<div id="view_dlg" class="easyui-dialog"
		style="width:430px;height:280px;" closed="true"
		buttons="#view_dlg-buttons">
		<table id="view_dg"></table>
	</div>
	
	<!-- 邮件 -->
	<div id="dlg" class="easyui-dialog"
		style="width:430px;height:280px;padding:10px 20px" closed="true"
		buttons="#dlg-buttons">
		<form id="addform" method="post">
			<table cellpadding="3">
				<tr>
					<td><label>我的邮箱</label></td>
					<td><input value="${email}" disabled="disabled" type="text"/></td>
				</tr>
				<tr>
					<td><label>密码</label></td>
					<td><input id="password" name="password" type="password"/></td>
				</tr>
				<tr>
					<td><label>主题</label></td>
					<td><input id="subject" name="subject" data-options="required:true" class="easyui-textbox" type="text"/></td>
				</tr>
				<tr>
					<td><label>内容</label></td>
					<td><textarea rows="3" style="width:200px;" id="email_content" name="email_content" ></textarea></td>
				</tr>
			</table>
		</form>
	</div>

	<!-- 邮件工具栏 -->
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
			onclick="save_email()">提交</a> <a href="#" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
	
	<!-- 评价 -->
	<div id="e_dlg" class="easyui-dialog"
		style="width:430px;height:280px;padding:10px 20px" closed="true"
		buttons="#e_buttons">
		<textarea rows="3" id="content" name="content"></textarea>
	</div>

	<!-- 添加窗口工具栏 -->
	<div id="e_buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
			onclick="save_e()">提交</a> <a href="#" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#e_dlg').dialog('close')">取消</a>
	</div>
	
  </body>
</html>
