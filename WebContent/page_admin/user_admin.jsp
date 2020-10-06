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
<title>乘客管理</title>
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
</head>
<body>
<br>
<div class="layui-form-item">
    <div class="layui-input-inline">
    	<input id="passengerID" type="text" name="passengerID" class="layui-input" placeholder="请输入乘客证件号" >
    </div>
    <div class="layui-input-inline">
		<input type="button" class="layui-btn" value="查找乘客" onclick="findPassenger()">
    </div>
</div>
<div id="div1">
<form class="layui-form" id="form1">
<table id="table1" class="layui-table" lay-size='sm'>
  <thead>
    <tr>
      	<th >姓名</th>
       	<th >性别</th>
       	<th >年龄</th>
        <th >证件类型</th>
        <th >证件号码</th>
        <th >电话</th>
        <th >邮箱</th>
        <th >地址</th>
        <th >用户</th>
        <th >状态</th>
    </tr> 
  </thead>
  <tbody>
<%
Dbutil util=new Dbutil();
ResultSet rs=null;
String SQL="select * from passenger";
rs=util.query(SQL);
while(rs.next()){
	Passenger pass=new Passenger();
	pass.pass_name=rs.getString("passenger_name");
	pass.sex=rs.getString("sex");
	pass.age=rs.getInt("age");
	pass.cert_type=rs.getString("certype");
	pass.cert_num=rs.getString("cernum");
	pass.telephone=rs.getString("phone");
	pass.mail=rs.getString("mail");
	pass.address=rs.getString("address");
	pass.user_ID=rs.getInt("user_ID");
	pass.state=rs.getString("state");
	%>
	<tr>
    		<td><%=pass.pass_name %></td>    		
    		<td><%=pass.sex %></td>
    		<td><%=pass.age %></td>
    		<td><%=pass.cert_type %></td>
    		<td><%=pass.cert_num %></td>
    		<td><%=pass.telephone %></td>
    		<td><%=pass.mail %></td>
    		<td><%=pass.address %></td>    		
    		<td><%=pass.user_ID %></td>
    		<%
    		if(pass.state.equals("normal")){
    		%>  		
    <td><input name="state" type="checkbox" checked="" lay-skin="switch" lay-filter="switchTest" lay-text="正常|禁用" ></td>
    		<%
    		}else{
    		%>
    <td><input name="state" type="checkbox" lay-skin="switch" lay-filter="switchTest" lay-text="正常|禁用" ></td>
    		<%	
    		}
    		%>
    </tr>
	<% 
	}
	util.close();
	%>
</tbody>
</table>
</form>
</div>
<script type="text/javascript" src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="../layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">

layui.use('form', function(){
	  var form = layui.form
	  ,layer = layui.layer
	  ,layedit = layui.layedit
	  ,laydate = layui.laydate;

	  form.on('switch(switchTest)', function(data){
	    alert($(this).closest("tr").text());
	  });
});

var flight_ID;
function findPassenger(){
	$("#form1").empty();
	 passenger_ID=$("#passengerID").val();
	 createXMLHttpRequest();  
	    var url = "findPassenger.jsp?passenger_ID="+passenger_ID+"";  
	    XMLHttpReq.open("GET", url, true);  
	    XMLHttpReq.onreadystatechange = processResponse;//指定响应函数  
	    XMLHttpReq.send(null);
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
</script>
</body>
</html>