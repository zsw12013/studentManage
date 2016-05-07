<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>查看信息</title>
	<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.3/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.3/themes/icon.css">
	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
	$(function(){
		$('input').attr("disabled",true);
		showStudent();
	});
	function update(){
		 $("#updateForm").form("submit",{
			url:"../update_stu.do",
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.status=="success"){
					$.messager.alert("系统提示","保存成功！");
					showStudent();
					$('input').attr("disabled",true);
				}else{
					$.messager.alert("系统提示","保存失败！");
					return;
				}
			}
		 });
	}
	function showStudent(){
		$.ajax({
			url:"../getStudentMsg.do",
			type:"post",
			data:{
				id:"${id}"
			},
			dataType:"json",
			success:function(obj){
			var data = obj.student;
					$("#id").textbox("setValue",data.id);
					$("#name").textbox("setValue",data.name);
					$("#birth").textbox("setValue",data.birth);
					$("#address").textbox("setValue",data.address);
					$("#email").textbox("setValue",data.email);
					$("#tel").textbox("setValue",data.tel);
					$("#favorite").textbox("setValue",data.favorite);
					$("#describe").textbox("setValue",data.describe);
					$("#reward").textbox("setValue",data.reward);
					$("#sex").textbox("setValue",data.sex);
			},
			error:function(){
				$.messager.alert("提示","系统错误，请联系管理员");
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
	function edit(){
		$('input').attr("disabled",false);
		$('#id').attr("disabled",true);
	}
	function outPut(){
		window.location.href="../output.do?id=${id}";
	}
	</script>
	<style>
		table{
			position:absolute;
			top:100px;
			left:100px;
			margin:0 auto;
		}
	</style>
  </head>
  
  <body>
  	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="edit()" >修改</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="update()" >保存</a>
	</div>
	<div id="info">
		<form id="updateForm" method="post">
			<table>
				<tr>
					<td width="250px">学号：</td>
					<td width="250px"><input id="id" name="id" class="easyui-textbox" type="text"/></td>
				</tr>
				<tr>
					<td>姓名：</td>
					<td><input id="name" name="name" class="easyui-textbox" type="text" /></td>
				</tr>
				<tr>
					<td>性别：</td>
					<td><input id="sex" name="sex" class="easyui-textbox" type="text"/></td>
				</tr>
				<tr>
					<td>生日：</td>
					<td><input id="birth" name="birth" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser"/></td>
				</tr>
				<tr>
					<td>电话：</td>
					<td><input id="tel" name="tel" class="easyui-textbox" type="text" /></td>
				</tr>
				<tr>
					<td>邮箱：</td>
					<td><input id="email" name="email" class="easyui-textbox" type="text"/></td>
				</tr>
				<tr>
					<td>地址：</td>
					<td><input id="address" name="address" class="easyui-textbox" type="text"/></td>
				</tr>
				<tr>
					<td>爱好：</td>
					<td><input id="favorite" name="favorite" class="easyui-textbox" type="text"/></td>
				</tr>
				<tr>
					<td>自我描述：</td>
					<td><input id="describe" name="describe" class="easyui-textbox" type="text"/></td>
				</tr>
				<tr>
					<td>奖项：</td>
					<td><input id="reward" name="reward" class="easyui-textbox" type="text"/></td>
				</tr>
			</table>
		</form>
	</div>
  </body>
</html>
