<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Passenger" %>
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
String passenger_ID=session.getAttribute("passenger_ID").toString();
String time=session.getAttribute("time").toString();

String flight_ID=request.getParameter("flightID");
String SQL="";
ResultSet rs=null;
Dbutil util =new Dbutil();
SQL="select distinct passenger_name,sex,age,certype,cernum,mail,phone,address,state,passenger.user_ID as userID ";
SQL+=" from ticket,passenger ";
SQL+=" where flight_ID='"+flight_ID+"' and ticket_state='used' and passenger_ID=cernum and ticket.user_ID=passenger.user_ID ";
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
	pass.user_ID=rs.getInt("userID");
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
<button class="layui-btn" onclick="doReturn()">返回</button>
<script type="text/javascript" src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="../layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
var passenger_ID;
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
function doReturn(){
	window.location.href="findVictim.jsp?passenger_ID=<%=passenger_ID%>&time=<%=time%> ";
}
</script>
</body>
</html>