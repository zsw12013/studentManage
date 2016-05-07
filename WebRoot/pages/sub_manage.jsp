<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>课程管理</title>
	<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.3/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.3/themes/icon.css">
	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	$(function(){
		//班级树
		$("#tree").tree({
				url:'../show_classes.do?id=-1',
				onBeforeExpand:function(node,param){  
	                     $('#tree').tree('options').url = "../show_classes.do?id=" + node.id;
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
				    var term = $('#term').combobox('getValue');
					if (node.id.length == 7) {
						if(term!=""){
							$("#dg").datagrid({
								url:"../show_sub.do?classid="+node.id+"&termid="+term
							});
						}else {
							$.messager.alert("提示","请选择学期");
						}
						document.getElementById("chooseclass").value=node.id;  
					} else $.messager.alert("提示","请选择班级节点");
				}
			});
		//信息表格
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
			onClickCell: onClickCell,
			height:'400px',
		});
	     $("#term").combobox({
	    	url:"../show_term.do",
	    	valueField:'id',
	    	textField:'name',
	    	onSelect:function(obj){
	    		//alert(obj+","+obj.id);
	    		var node = document.getElementById("chooseclass").value;
	    		if(node!=""){
	    			$("#dg").datagrid({
						url:"../show_sub.do?classid="+node+"&termid="+obj.id
						});
	    		}else $.messager.alert("提示","请先选择班级--");
	    	}
	    }); 
	});
	
	//可编辑行
	var editIndex = undefined;
	function endEditing(){
		if (editIndex == undefined){return true}
		if ($('#dg').datagrid('validateRow', editIndex)){
			$('#dg').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickCell(index, field){
		if (editIndex != index){
			if (endEditing()){
				$('#dg').datagrid('selectRow', index)
						.datagrid('beginEdit', index);
				var ed = $('#dg').datagrid('getEditor', {index:index,field:field});
				($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
				editIndex = index;
			} else {
				$('#dg').datagrid('selectRow', editIndex);
			}
		}
	}
	function accept(){
		if (endEditing()){
			var row = $('#dg').datagrid('getSelected');
			var subject = row.subject;
			var teacher = row.teacher;
			var classroom = row.classroom;
			var remark = row.remark;
			var id = row.id;
			$.ajax({
				url:"../update_sub.do",
				type:"post",
				dataType:"json",
				data:{
					id:id,
					subject:subject,
					teacher:teacher,
					classroom:classroom,
					remark:remark
				},
				success:function(data){
				 	if(data.status == "success"){
						$.messager.show({
							title : '提示',
							msg : '修改成功'
						});
						$('#dg').datagrid('load', {});
					}else{
						$.messager.show({
							title : '提示',
							msg : '修改失败，请联系管理员 ------'
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
	}
	
	//添加|保存
	function add(){
	 	var term = $('#term').combobox('getValue');
	    var node = $('#tree').tree('getSelected');
		var row = $('#dg').datagrid('getSelected');
	    if(node && node.id.length == 7 && term!=""){
			$('#add_dlg').dialog('open').dialog('setTitle', '新添课程');
	    }else $.messager.alert("提示","请先选择班级和学期");
		}
	function save_add(){
	 	var termid = $('#term').combobox('getValue');
	    var classid = $('#chooseclass').val();
	    var subject=$('#subject').textbox('getValue');
	    var teacher = $('#teacher').textbox('getValue');
	    var classroom = $('#classroom').textbox('getValue');
	    var remark = $('#remark').textbox('getValue');
		$.ajax({
				url:"../add_sub.do",
				type:"post",
				dataType:"json",
				data:{
					classid : classid,
					termid : termid,
					subject : subject,
					teacher : teacher,
					classroom : classroom,
					remark : remark			
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
	
	//删除
	function del(){
		var row = $('#dg').datagrid('getSelected');
		if(row){
			$.ajax({
				url:"../del_sub.do",
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
  	<input id="chooseclass" type="hidden"/>   
 	<span style="color:red">查看或管理课程信息请先在树中选择班级！</span>
  	<div id="tree" class="easyui-panel" style="width:300px;" ></div>
  	<div id="table" class="easyui-panel" style="width:840px;float:right;margin-left:30px;">
		<table id="dg"></table>
  	</div>
	<div id="toolbar">
		 学期：<input id="term" onblur="selectSub()" /> 
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="add()" >添加</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="del()" >删除</a>
	</div>

	<!-- 添加窗口 -->
	<div id="add_dlg" class="easyui-dialog"
		style="width:300px;height:280px;padding:10px 20px" closed="true"
		buttons="#add_dlg-buttons">
			<table cellpadding="3">
				<tr>
					<td><label>课程</label></td>
					<td><input id="subject" name="subject" type="text" class="easyui-textbox"/></td>
				</tr>
				<tr>
					<td><label>任课教师</label></td>
					<td><input id="teacher" name="teacher" type="text" class="easyui-textbox"/></td>
				</tr>
				<tr>
					<td><label>上课地点</label></td>
					<td><input id="classroom" name="classroom" type="text" class="easyui-textbox"/></td>
				</tr>
				<tr>
					<td><label>备注</label></td>
					<td><input id="remark" name="remark" type="text" class="easyui-textbox"/></td>
				</tr>
			</table>
	</div>

	<!-- 添加窗口工具栏 -->
	<div id="add_dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
			onclick="save_add()">提交</a> <a href="#" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#add_dlg').dialog('close')">取消</a>
	</div>
  </body>
</html>
