<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>学生管理</title>
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
					if (node.id.length == 7) {
						$("#dg").datagrid({
						url:"../show_choose_stu.do?id="+node.id
						});
					document.getElementById("a_classname").value=node.text;

					document.getElementById("choose_class").value=node.id;  //update
					document.getElementById("chooseclass").value=node.id;   //export
					document.getElementById("chooseclassname").value=node.text; //export
					//
					}
				}
			});
		//信息表格
		$("#dg").datagrid({
			url:"../show_stu.do",
			columns:[[ 
				{field:'age',title:'年龄',width:100},
				{field:'birth',title:'出生日期',width:100},
				{field:'sex',title:'性别',width:100},
				{field:'address',title:'地址',width:100},
				{field:'tel',title:'电话',width:100},
				{field:'email',title:'email',width:150}
			]],
			frozenColumns:[[
				{field:'ck',checkbox:'true'},
				{field:'classname',title:'班级',width:100},
				{field:'id',title:'学号',width:100},
				{field:'name',title:'姓名',width:100}
			]],
			toolbar:'#toolbar',  //表格菜单
			loadMsg:'嗖 ----正在火速加载中 -------------', //加载提示
			pagination:true, //显示分页工具栏
			rownumbers:true, //显示行号列
			singleSelect:true,//是允许选择一行
			selectOnCheck:false,
			checkOnSelect:true, //复选框
			queryParams:{   //在请求数据是发送的额外参数，如果没有则不用谢
				param:'',
			},
			height:'400px',
		});
		//导入（上传）excel 回调函数
		$('#importform').form({    
		    url:"../import_stu.do",    
		    onSubmit: function(){    

		    },    
		    success:function(data){    
		    var data = eval('(' + data + ')');  //把json数据转为object，ajax可以自动转，这里需要手动转
		        if(data.status == "success"){
						$('#import_dlg').dialog('close'); 
						$.messager.show({
							title : '提示',
							msg : '批量导入成功'
						});
						$('#dg').datagrid('load', {});
				}else{
					$.messager.show({
						title : '提示',
						msg : '导入失败，请检查excel中学号是否有重复的或系统中是否已录入该学号'
					});
				}  
		    }    
		});  
		
	});
	
	//模糊查询
	function searchParam(){
		var param = $('#param').textbox('getValue');
		if(param){
			$('#dg').datagrid('load', {    
				url:"../show_stu.do",
			    param: param    
			});  
		}
	}
	
	//添加|保存
	function add(){
	    var node = $('#tree').tree('getSelected');
		var row = $('#dg').datagrid('getSelected');
	    if(node && node.id.length == 7){
			$('#add_dlg').dialog('open').dialog('setTitle', '新建');
	    }else $.messager.alert("提示","请先选择班级--");
		}
	function save_add(){
	 //alert($('#a_birth').datebox('getValue'));
		var classid=$("#choose_class").val();
		var name=$("#a_name").val();
		var id=$("#a_id").val();
		var birth=$('#a_birth').datebox('getValue');   
		var sex=$("#a_sex").val();
		var tel=$("#a_tel").val();
		var email=$("#a_email").val();
		var address=$("#a_address").val();
		$.ajax({
				url:"../add_stu.do",
				type:"post",
				dataType:"json",
				data:{
					id:id,
					name:name,
					birth:birth,
					sex:sex,
					tel:tel,
					email:email,
					address:address,
					classid:classid
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
		    $('#u_birth').textbox('setValue',row.birth);
		    $('#u_address').textbox('setValue',row.address);
		    $('#u_classname').textbox('setValue',row.classname);
		    $('#u_name').textbox('setValue',row.name);
		    $('#u_tel').textbox('setValue',row.tel);
		    $('#u_email').textbox('setValue',row.email);
		    $('#u_sex').textbox('setValue',row.sex);
		    $('#u_id').textbox('setValue',row.id);
		}else $.messager.alert("提示","请选择一行");
	}
	function save_update(){
		//用了easyui的样式，就必须要这样取值了 赋值用setValue 见上面   
		var id=$('#u_id').textbox('getValue');
		var name=$('#u_name').textbox('getValue');
		var birth=$('#u_birth').datebox('getValue');
		var sex=$('#u_sex').textbox('getValue');
		var address=$('#u_address').textbox('getValue');
		var email=$('#u_email').textbox('getValue');
		var tel=$('#u_tel').textbox('getValue');
		//alert(birth);
		$.ajax({
				url:"../update_stu.do",
				type:"post",
				dataType:"json",
				data:{
					id:id,
					name:name,
					birth:birth,
					sex:sex,
					tel:tel,
					email:email,
					address:address
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
				url:"../del_stu.do",
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
	
	//excel批量导入
	function import_class(){
	    var node = $('#tree').tree('getSelected');
	    if(node && node.id.length == 7){
	    	document.getElementById("classid_import").value=node.id;
			$('#import_dlg').dialog('open').dialog('setTitle', '学生批量导入');
	    }else $.messager.alert("提示","请先选择班级--");
	}
	
	//excel导出班级列表
	function export_class(){
		if($("#chooseclass").val()==""){
			$.messager.alert("提示","请在左侧树列表选择要导出的班级");
		}else{
			window.location.href="../export_stu.do?classid="+$("#chooseclass").val()+"&classname="+$("#chooseclassname").val();
		}
	}
	
	//批量删除
	function del_many(){
		var row = $('#dg').datagrid('getChecked');		//得到复选框选择的所有行
		var ids = "";
		//alert(row[0]);								//机智！
        if(row[0]){                    					
	         $.messager.confirm('确认','确实要删除所选行？删除不能恢复！',function(r){    
			    if (r){   
			    	 $.each(row, function(i,n){						//遍历获得每行的id -- 学号
			               ids = ids + n.id +",";
			          });
						$.ajax({
							url:"../del_many_stu.do",
							type:"post",
							dataType:"json",
							data:{
								ids:ids
							},
								success:function(data){
							 	if(data.status == "success"){
									$.messager.show({
										title : '提示',
										msg : '批量删除成功'
									});
									$('#dg').datagrid('load', {});
								}else{
									$.messager.show({
										title : '提示',
										msg : '批量删除失败，请联系管理员 ------'
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
			});  
		}else $.messager.alert("提示","请勾选要删除的行！");

	}
	
	//发送邮件
	function send_email(){
		var row = $('#dg').datagrid('getSelected');
		if(row){
			$('#email_dlg').dialog('open').dialog('setTitle', '邮件信息');
		}else $.messager.alert("提示","请选择学生");
	}
	function send(){
		var row = $('dg').datagrid('getSelected');
		var subject = $('#subject').textbox('getValue');
		var content = $('#content').textbox('getValue');
		var password = $('#password').textbox('getValue');
		 $('#e_to').textbox('setValue',row.email);
		    $.ajax({
		    	url:"../send_email.do",
		    	type:"post",
		    	dataType:"json",
		    	data:{
		    		from:email,
		    		password:password,
		    		to:row.email,
		    		subject:subject,
		    		content:content
		    	},
		    	success:function(data){
				 	if(data.status == "success"){
						$.messager.show({
							title : '提示',
							msg : '邮件发送成功'
						});
						$('#dg').datagrid('load', {});
					}else{
						$.messager.show({
							title : '提示',
							msg : '邮件发送失败，请联系管理员 ------'
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
	
	
	//格式化easyui日期
	function myformatter(date){
		var y = date.getFullYear();
		var m = date.getMonth()+1;
		var d = date.getDate();
		return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
	}
	function myparser(s){
		if (!s) return new Date();
		var ss = (s.split('-'));
		var y = parseInt(ss[0],10);
		var m = parseInt(ss[1],10);
		var d = parseInt(ss[2],10);
		if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
			return new Date(y,m-1,d);
		} else {
			return new Date();
		}
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
  	<input id="chooseclassname" type="hidden" />
 	<span style="color:red">查看或管理班级信息请先在树中选择班级！</span>
  	<div id="tree" class="easyui-panel" style="width:300px;" ></div>
  	<div id="table" class="easyui-panel" style="width:840px;float:right;margin-left:30px;">
		<table id="dg"></table>
  	</div>
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="add()" >添加</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="update()" >更新</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="del()" >删除</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="del_many()" >批量删除</a>
		<a href="#" class="easyui-linkbutton"  onclick="import_class()" >导入</a>
		<a href="#" class="easyui-linkbutton"  onclick="export_class()" >导出</a>
		<input id="param" name="search_input"  class="easyui-textbox" type="text"/>
		<a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-search',plain:true"  onclick="searchParam()" >模糊查询</a>
		
	</div>
	
	<!-- 添加窗口 -->
	<div id="add_dlg" class="easyui-dialog"
		style="width:430px;height:280px;padding:10px 20px" closed="true"
		buttons="#add_dlg-buttons">
		<form id="addform" method="post">
			<input type="hidden" name="classid" id="choose_class" />
			<table cellpadding="3">
				<tr>
					<td><label>班级</label></td>
					<td><input id="a_classname" name="classname" disabled type="text"/></td>
					<td><label>姓名</label></td>
					<td><input id="a_name" name="name" data-options="required:true" class="easyui-textbox" type="text"/></td>
				</tr>
				<tr>
					<td><label>学号</label></td>
					<td><input id="a_id" name="id" data-options="required:true" class="easyui-textbox" type="text"/></td>
					<td><label>生日</label></td>
					<td><input id="a_birth" name="birth" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser"></input></td>
				</tr>
				<tr>
					<td><label>地址</label></td>
					<td><input id="a_address" name="address" data-options="required:true" class="easyui-textbox" type="text"/></td>
					<td><label>电话</label></td>
					<td><input id="a_tel" name="tel" data-options="required:true" class="easyui-textbox" type="text"/></td>
				</tr>
				<tr>
					<td><label>email</label></td>
					<td><input id="a_email" name="email" class="easyui-textbox" data-options="required:true,validType:'email'" type="text"/></td>
					<td><label>性别</label></td>
					<td><select id="a_sex" name="sex" data-options="required:true" class="easyui-combobox" panelHeight="50" style="width:140px;" >
						<option value="男" selected="selected">男</option>
						<option value="女">女</option>
					</select></td>
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
					<td><label>班级</label></td>
					<td><input id="u_classname" name="classname" class="easyui-textbox"  disabled type="text"/></td>
					<td><label>姓名</label></td>
					<td><input id="u_name" name="name" data-options="required:true" class="easyui-textbox" type="text"/></td>
				</tr>
				<tr>
					<td><label>学号</label></td>
					<td><input id="u_id" name="id" class="easyui-textbox" disabled type="text"/></td>
					<td><label>生日</label></td>
					<td><input id="u_birth" name="birth" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser"></input></td>
				</tr>
				<tr>
					<td><label>地址</label></td>
					<td><input id="u_address" name="address" data-options="required:true" class="easyui-textbox" type="text"/></td>
					<td><label>电话</label></td>
					<td><input id="u_tel" name="tel" data-options="required:true" class="easyui-textbox" type="text"/></td>
				</tr>
				<tr>
					<td><label>email</label></td>
					<td><input id="u_email" name="email" data-options="required:true" class="easyui-textbox" data-options="required:true,validType:'email'" type="text"/></td>
					<td><label>性别</label></td>
					<td><select id="u_sex" name="sex" data-options="required:true" class="easyui-combobox" panelHeight="50" style="width:140px;" >
						<option value="男" selected="selected">男</option>
						<option value="女">女</option>
					</select></td>
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
	
	<!-- 批量导入窗口（上传） -->
	<div id="import_dlg" class="easyui-dialog"
		style="width:280px;height:180px;padding:10px 20px" closed="true">
		 <form id="importform" method="post"  enctype="multipart/form-data">
			<input class="easyui-filebox" name="myfile" style="width:180px" data-options="buttonText:'选择正确格式的excel'">
			<input type="submit" value="上传"/>
			<input id="classid_import" name="classid" type="hidden" />
		</form> 
		<span style="color:red">请先下载导入模板输入数据！</span>
		<a href="../download_templet.do" >点击下载</a>

	</div>
  </body>
</html>
