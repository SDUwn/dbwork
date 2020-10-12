<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Flight" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>航班管理</title>
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
</head>
<body>
<div class="layui-form-item">
    <div class="layui-input-inline">
    	<input id="flight_ID" type="text" name="flightID" class="layui-input" placeholder="请输入航班号" >
    </div>
    <div class="layui-input-inline">
		<input type="button" class="layui-btn" value="查找航班" onclick="findFlight()">
    </div>
    <div class="layui-input-inline">
		<input type="button" class="layui-btn" value="添加航班" onclick="addFlight()">
    </div>
</div>
<div id="div1">
<table class="layui-table" id="tab">
  <thead>
    <tr>
      	<th >航班号</th>
      	<th >飞行时间</th>
       	<th >飞机编号</th>
       	<th >出发地</th>
        <th >出发时间</th>
        <th >到达地</th>
        <th >到达时间</th>
        <th >航班状态</th>
        <th >票价A</th>
        <th >票价B</th>
        <th >票价C</th>
        <th >编辑</th>        
        <th >删除</th>
        <th >查看</th>
    </tr> 
  </thead>
  <tbody>
<%
Dbutil util=new Dbutil();
ResultSet rs=null;
String SQL="select * from flight ";
//String SQL="SELECT flight_ID,plane_type,company_name,A_price,B_price,C_price,a.city as start_city,b.city as end_city,a.airport_name as start_airport,b.airport_name as end_airport,start_time,end_time from flight,airport as a,airport as b,plane,company where start_ID=a.airport_ID and end_ID=b.airport_ID and flight.plane_ID=plane.plane_ID and flight_state='正常' and plane.company_ID=company.company_ID ";
rs=util.query(SQL);
while(rs.next()){
	Flight flight=new Flight();
	flight.flight_id=rs.getInt("flight_ID");
	flight.plane_id=rs.getInt("plane_ID");
	flight.start_id=rs.getInt("start_ID");
	flight.start_time=rs.getString("start_time");
	flight.end_id=rs.getInt("end_ID");
	flight.end_time=rs.getString("end_time");
	flight.flight_state=rs.getString("flight_state");
	flight.A_price=rs.getDouble("A_price");
	flight.B_price=rs.getDouble("B_price");
	flight.C_price=rs.getDouble("C_price");
	%>
	<tr>
    		<td><%=flight.flight_id %></td>    
    		<td><%=flight.getTime(flight.start_time, flight.end_time) %></td>		
    		<td><%=flight.plane_id %></td>
    		<td><%=flight.start_id %></td>
    		<td><%=flight.start_time %></td>
    		<td><%=flight.end_id %></td>
    		<td><%=flight.end_time %></td>
    		<td><%=flight.flight_state %></td>
    		<td><%=flight.A_price %></td>    		
    		<td><%=flight.B_price %></td>    		
    		<td><%=flight.C_price %></td>
    		<td><input type="button" class="layui-btn layui-btn-warm layui-btn-xs edit" name="edit" value="编辑" ></td>    		
    		<td><input type="button" class="layui-btn layui-btn-danger layui-btn-xs delete" name="delete" value="删除"></td>    		
    		<td><input type="button" class="layui-btn layui-btn-xs view" name="view" value="查看"></td>
    </tr>
	<% 
	}
	util.close();
	%>
</tbody>
</table>
</div>
<script type="text/javascript" src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="../layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
var flightID;
$(function() {
	$("#div1").on("click", ":button", function(event) {
		if($(this).attr("name")=='edit'){
			flightID=$(this).closest("tr").find("td").eq(0).text();
			window.location.href="flight/editFlight.jsp?flight_ID="+flightID+"";
		}else if($(this).attr("name")=='delete'){
			flightID=$(this).closest("tr").find("td").eq(0).text();
			$(this).closest("tr").empty();
			window.location.href("flight/doDeleteFlight.jsp?flight_ID="+flightID+"");
		}else{
			flightID=$(this).closest("tr").find("td").eq(0).text();
			window.location.href("flight/viewFlight.jsp?flight_ID="+flightID+"");
		}
	});
});
var flight_ID;
function findFlight(){
	$("#tab").empty();
	 flight_ID=$("#flight_ID").val();
	 createXMLHttpRequest();  
	    var url = "flight/search_admin.jsp?flight_ID="+flight_ID+"";  
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
function addFlight(){
	window.location.href="flight/addFlight.jsp";
}
</script>
</body>
</html>