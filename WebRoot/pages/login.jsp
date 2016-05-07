<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>登录</title>
	<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.3/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.3/themes/icon.css">
	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/common/MD5.js"></script>
<script type="text/javascript" charset="UTF-8">
$(function() {
	$('input.easyui-validatebox').validatebox('disableValidation')
            .focus(function () { $(this).validatebox('enableValidation'); })
            .blur(function () { $(this).validatebox('validate'); });
    var loginDialog= $('#win').dialog({    
        title:"登录",
	    width:450,    
	    height:300,  
	    modal : true, //模式化窗口  
	    collapsible:true,
	    closable: false,
	    cache: false, 
	    buttons:[{
				text:'登录',
				iconCls:'icon-ok',
				handler:function(){
				    $.ajax({
				         url:'../login.do',
				         data:{
				              loginName:$('#loginForm input[name=name]').val(),
				              password:$('#loginForm input[name=password]').val(),
				              type:$('#type').combobox('getValue')
				         },
				         dataType : 'json',
				         type:'POST',
						 success : function(data) {
							   if(data.status=="fail"){
							      $.messager.show({
									 title : '提示',
									 msg : "用户名或密码错误"
								  });
							   }else{
							      loginDialog.dialog('close');
								  window.location.href ='index.jsp';
							   }
						 },
						 error : function() {
							 alert("失败");
						 }
				    });
				     
				}
			}]   
    });

}); 

</script>
<style>
	font{
		font-size:40px;
		font-family:"隶书";
	}
</style>
</head>

<body style=”width:100%;height:100%;">

	<div id="win">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north',split:true" style="height:80px;margin:auto">
				<!-- <img src="../img/title.png"  /> -->
			</div>
			<div data-options="region:'center'">
				<div style="margin-left:100px;margin-top:15px;">
					<form id="loginForm" method="post">
					<table style="line-height:2">
						<tr>
							<td><label>用户类型:</label></td>
							<td><select id="type" class="easyui-combobox"
							name="type" editable="false" style="width:155px;">
								<option value="0">系统管理员</option>
								<option value="1">老师</option>
								<option value="2">学生</option>
						</select></td>
						</tr>
						<tr>
							<td><label>登录名:</label></td>
							<td><input type="text"
								name="name" class="easyui-textbox" data-options="required:true"
								  /></td>
						</tr>
						<tr>
							<td><label>密码:</label> </td>
							<td><input type="password"
								name="password" class="easyui-textbox" data-options="required:true"
								  /></td>
						</tr>
					</table>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
