<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Passenger" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>疫情追踪</title>
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
</head>
<body>
<br>
<div class="layui-form-item">
    <div class="layui-input-inline">
    	<input id="passengerID" type="text" name="passengerID" class="layui-input" placeholder="请输入确诊乘客证件号" >
    </div>
    <div class="layui-input-inline">
    	<input id="time" type="date" name="time" class="layui-input" placeholder="请输入查找日期" >
    </div>
    <div class="layui-input-inline">
		<input type="button" class="layui-btn" value="查找乘客乘车动态" onclick="FindVictim();">
    </div>
</div>
<div id="div1"></div>
<script type="text/javascript" src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript">
var passenger_ID;
var time;
function FindVictim(){
	passenger_ID=$("#passengerID").val();
	time=$("#time").val();
	createXMLHttpRequest();  
    var url = "findVictim.jsp?passenger_ID="+passenger_ID+"&time="+time+" ";  
    XMLHttpReq.open("GET", url, true);
    XMLHttpReq.onreadystatechange = processResponse;
    XMLHttpReq.send(null);
}
function createXMLHttpRequest() {  
    if(window.XMLHttpRequest) { //Mozilla 浏览器  
        XMLHttpReq = new XMLHttpRequest();  
    }  
    else if (window.ActiveXObject) { // IE浏览器  
        try {  
            XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");  
        } catch (e) {  
            try {  
                XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");  
            } catch (e) {}  
        }  
    }  
} 
function processResponse() {  
    if (XMLHttpReq.readyState == 4) { // 判断对象状态  
        if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息  
        	document.getElementById("div1").innerHTML=XMLHttpReq.responseText;
        } else { 
            window.alert("您所请求的页面有异常。");  
        }  
    }  
}
</script>
</body>
</html>