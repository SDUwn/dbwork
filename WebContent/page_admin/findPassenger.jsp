<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Passenger" %>
<%@ page import="java.sql.*" %>
<%
String passenger_ID=request.getParameter("passenger_ID");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<form class="layui-form">
<table class="layui-table">
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
String SQL="select * from passenger where cernum='"+passenger_ID+"' ";
rs=util.query(SQL);
if(rs.next()){
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
    		if(pass.state.equals("正常")){
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
<script type="text/javascript" src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="../layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
layui.use('form', function(){
	  var form = layui.form
	  ,layer = layui.layer
	  ,layedit = layui.layedit
	  ,laydate = layui.laydate;

	  form.on('switch(switchTest)', function(data){
		  passenger_ID=$(this).closest("tr").find("td").eq(4).text();
		    state=$(this).closest("tr").find("td").eq(9).text();
		    createXMLHttpRequest();  
		    var url = "doChangeState.jsp?passenger_ID="+passenger_ID+"&state="+state+" ";  
		    XMLHttpReq.open("GET", url, true);  
		    XMLHttpReq.send(null);
		  });
	});
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

var flight_ID;
function findPassenger(){
	$("#form1").empty();
	passenger_ID=$("#passengerID").val();
	window.location.href="findPassenger.jsp?passenger_ID="+passenger_ID+" ";
}
</script>
</body>
</html>