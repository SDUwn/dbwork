<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Db.Dbutil" %>
<%@ page import="java.sql.*" %>
<%@ page import="Bean.Ticket" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>已订机票</title>
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
  <style type="text/css">body{margin: 2em 0.5em 0.5em 0em;}</style>
</head>
<body>
<%
String user_ID=session.getAttribute("ID").toString();
Dbutil util=new Dbutil();
String SQL="";
ResultSet rs=null;
%>
<table class="layui-table" lay-size='sm' lay-filter="parse-table-demo" lay-data="{id: 'idTest'}">
  <thead>
    <tr>
    	<th lay-data="{field:'1', width:100,fixed:'left'}">订单编号</th>
      	<th lay-data="{field:'2', width:100,fixed:'left'}">航班号</th>
       	<th lay-data="{field:'3', width:100,fixed:'left'}">乘客姓名</th>
       	<th lay-data="{field:'4', width:100}">机舱号</th>
        <th lay-data="{field:'5', width:100}">座位号</th>
        <th lay-data="{field:'6', width:100}">机票价格</th>
        <th lay-data="{field:'7', width:100}">出发时间</th>
        <th lay-data="{field:'8', width:100}">出发城市</th>
        <th lay-data="{field:'9', width:100}">出发机场</th>
        <th lay-data="{field:'10', width:100}">到达时间</th>
        <th lay-data="{field:'11', width:100}">到达城市</th>
        <th lay-data="{field:'12', width:100}">到达机场</th>
        <th lay-data="{field:'13', width:100}">失效原因</th>
    </tr> 
  </thead>
  <tbody>
<%
SQL="";
SQL+=" select ticket_ID,ticket.flight_ID,ticket.passenger_ID,passenger_name,price, ";
SQL+=" start_time,end_time,aa.airport_name as start_airport,bb.airport_name as end_airport,aa.city as start_city,bb.city as end_city,cabin_type,seat_location ";
SQL+=" from ticket,passenger,flight,airport as aa,airport as bb,plane_seat ";
SQL+=" where passenger.user_ID='"+user_ID+"' and ticket_state='timeout' and cernum=passenger_ID and ticket.flight_ID=flight.flight_ID "; 
SQL+=" and flight.start_ID=aa.airport_ID and flight.end_ID=bb.airport_ID ";
SQL+=" and flight.plane_ID=plane_seat.plane_ID and ticket.seat_ID=plane_seat.seat_ID ";
rs=util.query(SQL);
while(rs.next()){
	Ticket ticket=new Ticket();
	ticket.ticket_id=rs.getInt("ticket_ID");
	ticket.flight_id=rs.getInt("flight_ID");
	ticket.passenger_name=rs.getString("passenger_name");
	ticket.cabin_type=rs.getString("cabin_type");
	ticket.seat_location=rs.getString("seat_location");
	ticket.price=rs.getDouble("price");
	ticket.start_time=rs.getString("start_time");
	ticket.start_city=rs.getString("start_city");
	ticket.start_airport=rs.getString("start_airport");
	ticket.end_time=rs.getString("end_time");
	ticket.end_city=rs.getString("end_city");
	ticket.end_airport=rs.getString("end_airport");
%>
		<tr>
		   	<td><%=ticket.ticket_id %></td>
    		<td><%=ticket.flight_id %></td>
    		<td><%=ticket.passenger_name %></td>
    		<td><%=ticket.cabin_type %></td>
    		<td><%=ticket.seat_location %></td>
    		<td><%=ticket.price %></td>
    		<td><%=ticket.start_time %></td>
    		<td><%=ticket.start_city %></td>
    		<td><%=ticket.start_airport %></td>
    		<td><%=ticket.end_time %></td>
    		<td><%=ticket.end_city %></td>
    	    <td><%=ticket.end_airport %></td>
    	    <td>已过期</td>
    	</tr>

<%
}
%>
<%
SQL="";
SQL+=" select ticket_ID,ticket.flight_ID,ticket.passenger_ID,passenger_name,price, ";
SQL+=" start_time,end_time,aa.airport_name as start_airport,bb.airport_name as end_airport,aa.city as start_city,bb.city as end_city,cabin_type,seat_location ";
SQL+=" from ticket,passenger,flight,airport as aa,airport as bb,plane_seat ";
SQL+=" where passenger.user_ID='"+user_ID+"' and ticket_state='limited' and cernum=passenger_ID and ticket.flight_ID=flight.flight_ID "; 
SQL+=" and flight.start_ID=aa.airport_ID and flight.end_ID=bb.airport_ID ";
SQL+=" and flight.plane_ID=plane_seat.plane_ID and ticket.seat_ID=plane_seat.seat_ID ";
rs=util.query(SQL);
while(rs.next()){
	Ticket ticket=new Ticket();
	ticket.ticket_id=rs.getInt("ticket_ID");
	ticket.flight_id=rs.getInt("flight_ID");
	ticket.passenger_name=rs.getString("passenger_name");
	ticket.cabin_type=rs.getString("cabin_type");
	ticket.seat_location=rs.getString("seat_location");
	ticket.price=rs.getDouble("price");
	ticket.start_time=rs.getString("start_time");
	ticket.start_city=rs.getString("start_city");
	ticket.start_airport=rs.getString("start_airport");
	ticket.end_time=rs.getString("end_time");
	ticket.end_city=rs.getString("end_city");
	ticket.end_airport=rs.getString("end_airport");
%>
		<tr>
		   	<td><%=ticket.ticket_id %></td>
    		<td><%=ticket.flight_id %></td>
    		<td><%=ticket.passenger_name %></td>
    		<td><%=ticket.cabin_type %></td>
    		<td><%=ticket.seat_location %></td>
    		<td><%=ticket.price %></td>
    		<td><%=ticket.start_time %></td>
    		<td><%=ticket.start_city %></td>
    		<td><%=ticket.start_airport %></td>
    		<td><%=ticket.end_time %></td>
    		<td><%=ticket.end_city %></td>
    	    <td><%=ticket.end_airport %></td>
    	    <td>禁乘</td>
    	</tr>

<%
}
%>
<%
util.close();
%>
</tbody>
</table>
<script src="../layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
layui.use('table', function(){
	  var table = layui.table;
	      table.init('parse-table-demo', { //转化静态表格
	        //height: 'full-500'
			page:true
	      });
	    });
</script>
</body>
</html>




