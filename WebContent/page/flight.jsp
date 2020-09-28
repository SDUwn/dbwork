<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Flight" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>航班查询</title>
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
</head>

<%
Dbutil util=new Dbutil();
String queryNumberSQL="";
%>

<body>
<script type="text/javascript" src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<div class="layui-form-item">
    <label class="layui-form-label">出发城市</label>
    <div class="layui-input-inline">
      <input id="sc" name="startcity" class="layui-input" type="text" placeholder="请输入城市名" autocomplete="off" required="required">
    </div>
    <label class="layui-form-label">到达城市</label>
    <div class="layui-input-inline">
      <input id="ec" name="endcity" class="layui-input" type="text" placeholder="请输入城市名" autocomplete="off" required="required">
    </div>
</div>
<div class="layui-form-item">
    <label class="layui-form-label">出发日期</label>
    <div class="layui-input-inline">
      <input id="st" name="starttime" class="layui-input" type="date" placeholder="请选择时间" autocomplete="off" required="required">
    </div>
    &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp<input type="button" class="layui-btn" value="查询" onclick="search()">
</div>

<div id="div1">

<table class="layui-table">
  <thead>
    <tr>
      	<th>航班号</th>
       	<th>出发城市</th>
       	<th>出发机场</th>
        <th>出发时间</th>
        <th>到达城市</th>
        <th>到达机场</th>
        <th>到达时间</th>
        <th>航空公司</th>
        <th>票价起步</th>
        <th>订票</th>
    </tr> 
  </thead>
  <tbody>
    <%
    queryNumberSQL="SELECT flight_ID,plane_type,company_name,A_price,B_price,C_price,a.city as start_city,b.city as end_city,a.airport_name as start_airport,b.airport_name as end_airport,start_time,end_time from flight,airport as a,airport as b,plane,company where start_ID=a.airport_ID and end_ID=b.airport_ID and flight.plane_ID=plane.plane_ID and flight_state='normal' and plane.company_ID=company.company_ID ";
    ResultSet rs=util.query(queryNumberSQL);
    while(rs.next()){
    	Flight flight=new Flight();
    	flight.flight_id=rs.getInt("flight_id");
    	flight.start_city=rs.getString("start_city");
    	flight.start_airport=rs.getString("start_airport");
    	flight.end_city=rs.getString("end_city");
    	flight.end_airport=rs.getString("end_airport");
    	flight.A_price=rs.getDouble("A_price");
    	flight.B_price=rs.getDouble("B_price");
    	flight.C_price=rs.getDouble("C_price");
    	flight.company_name=rs.getString("company_name");
    	flight.start_time=rs.getString("start_time"); 
    	flight.end_time=rs.getString("end_time");
    	flight.plane_type=rs.getString("plane_type");
    %>
    	<tr>
    		<td><%=flight.flight_id %></td>
    		<td><%=flight.start_city %></td>
    		<td><%=flight.start_airport %></td>
    		<td><%=flight.start_time %></td>
    		<td><%=flight.end_city %></td>
    		<td><%=flight.end_airport %></td>
    		<td><%=flight.end_time %></td>
    		<td><%=flight.company_name %></td>
    		<td><%=flight.C_price %></td>
    		<td><input type="button" class="layui-btn" name="book" value="预定"></td>
    	</tr>
    	
    <%
    }
    util.close();
    %>
  </tbody>
</table>
</div>

<script type="text/javascript">
var XMLHttpReq; 
var startcity,endcity,startcity;
var flightID;
$(function() {
	$("#div1").on("click", ":button", function(event) {
		//$("#text").val($(this).closest("tr").find("td").eq(0).text());
		flightID=$(this).closest("tr").find("td").eq(0).text();
		createXMLHttpRequest();
		var url = "doBook.jsp?flightID="+flightID+"";  
	    XMLHttpReq.open("GET", url, true);  
	    XMLHttpReq.onreadystatechange = processResponse1;//指定响应函数  
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
 
// 处理返回信息函数  
function processResponse() {  
    if (XMLHttpReq.readyState == 4) { // 判断对象状态  
        if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息  
            document.getElementById("div1").innerHTML=XMLHttpReq.responseText;
        } else { 
            window.alert("您所请求的页面有异常。");  
        }  
    }  
}  
function processResponse1() {  
    if (XMLHttpReq.readyState == 4) { // 判断对象状态  
        if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息  
            document.getElementById("div1").innerHTML=XMLHttpReq.responseText;
        } else { 
            window.alert("您所请求的页面有异常。");  
        }  
    }  
} 
function search(){
	$("#tab").empty();
	 startcity=$("#sc").val();
	 endcity=$("#ec").val();
	 starttime=$("#st").val();
	 createXMLHttpRequest();  
	    var url = "search.jsp?startcity="+startcity+"&endcity="+endcity+"&starttime="+starttime+"";  
	    XMLHttpReq.open("GET", url, true);  
	    XMLHttpReq.onreadystatechange = processResponse;//指定响应函数  
	    XMLHttpReq.send(null);
}
</script>
</body>
</html>