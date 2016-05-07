<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>系统主页</title>
	<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.3/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.3/themes/icon.css">
	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" charset="utf-8">

$(function() {
   // 实例化树菜单,根据userType选择显示的菜单 0系统管理员1老师2学生
    
      $("#menu").accordion('add', {
			title: '功能列表',
			content: 
				 $("#tree").tree({
				    url:<c:if test="${userType==0}">'tree_data0.json'</c:if>   //管理员
					    <c:if test="${userType==1}">'tree_data1.json'</c:if>   //教师
					    <c:if test="${userType==2}">'tree_data2.json'</c:if>,   //学生
		            loadFilter: function(data){    
		                  if (data.msg){    
		                      return data.msg;    
		                 } else {    
		                     return data;    
		                 }    
		            }, 
					lines : true,
					onClick : function(node) {
						if (node.attributes) {
							openTab(node.text, node.attributes);
						}
					}
							
		}),
			selected: true
		});
		
	
	    //点击菜单 打开选项卡的方法
		function openTab(text, url) {
			if ($("#tabs").tabs('exists', text)) {
				$("#tabs").tabs('select', text);
			} else {
				var content = "<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src="
						+ url + "></iframe>";
				$("#tabs").tabs('add', {
					title : text,
					closable : true,
					content : content
				});
			}
		}
});

//修改密码-修改密码按钮被点击后调用
function updatePw(){
     updatePwdlg=$('#updatePwdlg').dialog('open').dialog('setTitle','修改密码');
     $('#oldpw').val("");
	 $('#newpw').val("");
	 $('#repw').val("");
}
//原始密码input 失去焦点
function opLostFocus(){
     var oldpw=$('#oldpw').val();
     var password="${password}";
     if(oldpw==""){
         $('#oldsp').html("* 原始密码不可为空");
     }
}
//修改密码dialog 确认按钮
function okupdatepw(){
	if(!$("#updatePwF").form("validate")){
		return false;
	}else{
        $.ajax({
            url:'../updatePassword.do',
            data:{
                  id:"${id}",
                  type:"${userType}",
                  password:$('#newpw').val()
                 },
            type:'POST',
            dataType : 'json',
            success:function(data){
            	if(data.status=="success"){
            		$.messager.alert("提示","密码修改成功");
            		$("#updatePwdlg").dialog("close");
            	}
            },
            error : function() {
					$.messager.alert("提示","失败");
		    }
                 
        });
        }
}
function cancle(){
    $('#updatePwdlg').dialog('close');
    $('#oldsp').html("*");
    $('#newsp').html("*");
    $('#resp').html("*");
}
function logout(){
		$.messager.confirm("系统提示","您确定要退出系统吗？",function(r){
			if(r){
				window.location.href='login.jsp';
			} 
		 });
	}
$.extend($.fn.validatebox.defaults.rules, {    
    equals: {    
        validator: function(value,param){    
            return value == $(param[0]).val();    
        },    
        message: '两次密码输入不一致'   
    }    
});  
$.extend($.fn.validatebox.defaults.rules, {    
    equalsOld: {    
        validator: function(value,param){    
            return value == $(param[0]).val();    
        },    
        message: '原密码输入错误'   
    }    
});  
</script>
<style>
 font{
 	font-size:40px;
 	font-family:"隶书";
 }
</style>
</head>
<body class="easyui-layout">   
<input type="hidden" id="oldpassword" value="${password}" />
    <div data-options="region:'north'" style="height:58px;background-color: #E0ECFF">
		<!-- <img src="../img/title.png" /> -->
        <div style="position:absolute;top:40px;right:30px">
			当前用户:&nbsp;${name}
		</div>
		
		<div style="position:absolute;top:77px;right:10px">
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-modifyPassword'"
				onclick="updatePw()">修改密码</a>
		</div>
    </div>   
    <div data-options="region:'west',title:'菜单栏',split:true" style="width:160px;">
        <div id="tree"></div>
        <div id="menu" class="easyui-accordion" data-options="fit:true">
            <div title="版权声明" data-options="iconCls:'icon-reload',selected:true" style="padding:10px;">
		        版权所有，请勿转载；
		    </div>
	        <div title="系统管理"  data-options="iconCls:'icon-item'" style="padding:10px">
				<a href="javascript:updatePw()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 100px;">修改密码</a>
				<a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'" style="width: 100px;">安全退出</a>
			</div>
		</div> 
    </div>   
    
   <div data-options="region:'center'">
	<div class="easyui-tabs" data-options="fit:'true',border:'false'" id="tabs">
	</div>
</div>
    <div id="south" data-options="region:'south',title:'版权声明'" style="height:60px;">
    	<center><span>@FFA_邓晓</span></center>
    </div>   
    
    <!-- 修改密码 -->
	<div id="updatePwdlg" class="easyui-dialog"
		style="width:360px;height:200px;padding:10px 20px" closed="true"
		closable="false" buttons="#updatePwdlg-buttons">
		<form id="updatePwF">
			<table>
				<tr>
					<td><label>原始密码:</label></td>
					<td><input type="password" name="oldpw" id="oldpw"
				style="width:100px;" class="easyui-validatebox"  required="required" validType="equalsOld['#oldpassword']"
				/>&nbsp;<span id="oldsp"
				style="color:red;font-size:10px;">*</span></td>
				</tr>
				<tr>
					<td><label>新密码:</label></td>
					<td><input type="password" name="newpw" id="newpw" style="width:100px;"
					class="easyui-validatebox"     
				data-options="required:true"  />&nbsp;<span
				id="newsp" style="color:red;font-size:10px;">*</span></td>
				</tr>
				<tr>
					<td><label>确认密码:</label></td>
					<td><input type="password" name="repw" id="repw" style="width:100px;"
				class="easyui-validatebox"     
   				required="required" validType="equals['#newpw']" />&nbsp;
   				<span style="color:red;font-size:10px;">*</span></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="updatePwdlg-buttons">
		<a href="#" id="udlg-buttons-ok" class="easyui-linkbutton"
			iconCls="icon-ok" onclick="okupdatepw()">确认</a> <a href="#"
			class="easyui-linkbutton" iconCls="icon-cancel" onclick="cancle()">取消</a>
	</div>
	
	
</body> 
</html>