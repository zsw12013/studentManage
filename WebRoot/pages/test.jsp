<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"">
<title>test</title>
   <link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.3/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.3/themes/icon.css">
	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.min.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../jquery-easyui-1.4.3/easyloader.js"></script>
	<script type="text/javascript" src="../js/ajaxfileupload.js"></script>
	
	
 	<link rel="stylesheet" type="text/css" href="http://www.jeasyui.net/Public/js/easyui/demo/demo.css">
 	<script type="text/javascript" src="../jquery-easyui-1.4.3/jquery.edatagrid.js"></script>
		<script type="text/javascript">
		function load1(){
			using('calendar', function(){
				$('#cc').calendar({
					width:180,
					height:180
				});
			});
		}
		function load2(){
			using(['dialog','messager'], function(){
				$('#dd').dialog({
					title:'Dialog',
					width:300,
					height:200
				});
				$.messager.show({
					title:'info',
					msg:'dialog creatsddddddddded'
				});
			});
		}
	</script>
</head>
<body>
 <h1>EasyLoader</h1>
	<a href="#" class="easyui-linkbutton" onclick="load1()">Load Calendar</a>
	<a href="#" class="easyui-linkbutton" onclick="load2()">Load Dialog</a>
	<div id="cc"></div>
	<div id="dd"></div>
</body>
</html>