<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Flight" %>
<%@ page import="Bean.Plane" %>
<%@ page import="Bean.Airport" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../../layui/css/layui.css"  media="all">
</head>
<%
String flight_ID=request.getParameter("flight_ID");
System.out.println(flight_ID);
Dbutil util=new Dbutil();
ResultSet rs=null;
String SQL="";
Flight flight=new Flight();
%>
<%
SQL="SELECT plane_type,company_name,A_price,B_price,C_price,a.city as start_city,b.city as end_city,a.airport_name as start_airport,b.airport_name as end_airport,start_time,end_time from flight,airport as a,airport as b,plane,company where flight.flight_ID='"+flight_ID+"' and start_ID=a.airport_ID and end_ID=b.airport_ID and flight.plane_ID=plane.plane_ID and plane.company_ID=company.company_ID ";
rs=util.query(SQL);
while(rs.next()){
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
}
%>
<body>
  <div class="layui-form-item">
    <label class="layui-form-label">航班号</label>
    <div class="layui-input-inline">
      <input name="flight_ID" class="layui-input" type="text" placeholder="<%=flight_ID %>" disabled="disabled">
    </div>
    <label class="layui-form-label">飞行时间</label>
    <div class="layui-input-inline">
      <input name="time" class="layui-input" type="text" placeholder="<%=flight.getTime(flight.start_time, flight.end_time) %>" disabled="disabled">
    </div>
  </div>
   <div class="layui-form-item">
	 <label class="layui-form-label">航空公司</label>
     <div class="layui-input-inline">      
     	<input name="company" class="layui-input" type="text" placeholder="<%=flight.company_name %>" disabled="disabled">
    </div>
    <label class="layui-form-label">飞机型号</label>
    <div class="layui-input-inline">
      <input name="planeType" class="layui-input" type="text" placeholder="<%=flight.plane_type %>" disabled="disabled">
    </div>
  </div>
    <div class="layui-form-item">
	 <label class="layui-form-label">出发城市</label>
     <div class="layui-input-inline">
      	<input name="startcity" class="layui-input" type="text" placeholder="<%=flight.start_city %>" disabled="disabled">
    </div>
    <label class="layui-form-label">到达城市</label>
     <div class="layui-input-inline">
      	<input name="endcity" class="layui-input" type="text" placeholder="<%=flight.end_city %>" disabled="disabled">
    </div>
  </div>
  <div class="layui-form-item">
	 <label class="layui-form-label">出发机场</label>
     <div class="layui-input-inline">
      	<input name="startAirport" class="layui-input" type="text" placeholder="<%=flight.start_airport %>" disabled="disabled">
    </div>
     <label class="layui-form-label">到达机场</label>
     <div class="layui-input-inline">
      	<input name="endAirport" class="layui-input" type="text" placeholder="<%=flight.end_airport %>" disabled="disabled">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">出发时间</label>
    <div class="layui-input-inline">
      <input id="st" name="starttime" class="layui-input" type="datetime" placeholder="<%=flight.start_time %>" disabled="disabled">
    </div>
    <label class="layui-form-label">到达时间</label>
    <div class="layui-input-inline">
      <input id="et" name="endtime" class="layui-input" type="datetime" placeholder="<%=flight.end_time %>" disabled="disabled">
    </div>
  </div>
	<div class="layui-form-item">
    	<table class="layui-table">
    		<tr>
    			<td>头等舱价格</td>
    			<td>商务舱价格</td>
    			<td>普通舱价格</td>
    		</tr>
    		<tr>
    			<td><%=flight.A_price %></td>
    			<td><%=flight.B_price %></td>
    			<td><%=flight.C_price %></td>
    		</tr>
    	</table>
  	</div>
  	<%
  	SQL="select arrivetime,stoptime,city,airport_name,A1_price,B1_price,C1_price,A2_price,B2_price,C2_price from stop,airport where stop.stop_ID=airport.airport_ID and stop.flight_ID='"+flight_ID+"'";
  	rs=util.query(SQL);
  	if(rs.next()){
  		flight.stop_city=rs.getString("city");
  		flight.stop_airport=rs.getString("airport_name");
  		flight.A1_price=rs.getDouble("A1_price");
  		flight.B1_price=rs.getDouble("B1_price");
  		flight.C1_price=rs.getDouble("C1_price");
  		flight.A2_price=rs.getDouble("A2_price");
  		flight.B2_price=rs.getDouble("B2_price");
  		flight.C2_price=rs.getDouble("C2_price");
  		flight.arrive_time=rs.getString("arrivetime"); 
  		flight.stop_time=rs.getInt("stoptime");
  		%>
  <div class="layui-form-item">
	<label class="layui-form-label">经停城市</label>
     <div class="layui-input-inline">
      	<input name="startcity" class="layui-input" type="text" placeholder="<%=flight.stop_city %>" disabled="disabled">
    </div>
     <label class="layui-form-label">经停机场</label>
     <div class="layui-input-inline">
      	<input name="startAirport" class="layui-input" type="text" placeholder="<%=flight.stop_airport %>" disabled="disabled">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">到达时间</label>
    <div class="layui-input-inline">
      <input id="st" name="starttime" class="layui-input" type="datetime" placeholder="<%=flight.arrive_time %>" disabled="disabled">
    </div>
    <label class="layui-form-label">经停时间</label>
    <div class="layui-input-inline">
      <input id="et" name="endtime" class="layui-input" type="datetime" placeholder="<%=flight.stop_time %>" disabled="disabled">
    </div>
  </div>
	<div class="layui-form-item">
    	<table class="layui-table">
    		<tr>
    			<td>头等舱价格</td>
    			<td>商务舱价格</td>
    			<td>普通舱价格</td>
    		</tr>
    		<tr>
    			<td><%=flight.A1_price %>(前段)</td>
    			<td><%=flight.B1_price %>(前段)</td>
    			<td><%=flight.C1_price %>(前段)</td>
    		</tr>
    		<tr>
    			<td><%=flight.A2_price %>(后段)</td>
    			<td><%=flight.B2_price %>(后段)</td>
    			<td><%=flight.C2_price %>(后段)</td>
    		</tr>
    	</table>
  	</div>
  		<% 
  	}
  	%>
  	<div class="layui-form-item">
	    <div class="layui-input-block">
	      <button class="layui-btn" onclick="test()">返回</button>
	    </div>
	  </div>
</body>
<script src="../../layui/layui.js" charset="UTF-8"></script>
<script>
layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate;
});
function test(){
	window.location.href="javascript:history.go(-1)";
}
</script>
</html>