<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Flight" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
  <legend>乘客乘机历史动态</legend>
</fieldset> 
<ul class="layui-timeline">
<%
String passenger_ID=request.getParameter("passenger_ID");
String time=request.getParameter("time");
session.setAttribute("passenger_ID", passenger_ID);
session.setAttribute("time", time);
Dbutil util =new Dbutil();
ResultSet rs=null;
String SQL="";
SQL="select isStop1,isStop2,ticket.flight_ID as flight_ID,start_ID,end_ID,start_time,end_time,aa.airport_name as start_airport,aa.city as start_city,bb.airport_name as end_airport,bb.city as end_city ";
SQL+=" from ticket,flight,airport as aa,airport as bb ";
SQL+=" where passenger_ID='"+passenger_ID+"' and ticket_state='已用' ";
SQL+=" and ticket.flight_ID=flight.flight_ID and date(start_time)='"+time+"' ";
SQL+=" and flight.start_ID=aa.airport_ID and flight.end_ID=bb.airport_ID ";
rs=util.query(SQL);
while(rs.next()){
	Flight flight=new Flight();
	flight.flight_id=rs.getInt("flight_ID");
	int stop1=Integer.parseInt(rs.getString("isStop1"));
	int stop2=Integer.parseInt(rs.getString("isStop2"));
	if(stop1==0&&stop2==0){
		flight.start_city=rs.getString("start_city");
		flight.end_city=rs.getString("end_city");
		flight.start_airport=rs.getString("start_airport");
		flight.end_airport=rs.getString("end_airport");
		flight.start_time=rs.getString("start_time");
		flight.end_time=rs.getString("end_time");
	}else if(stop1==1&&stop2==0){
		flight.start_city=rs.getString("start_city");
		flight.start_airport=rs.getString("start_airport");
		flight.start_time=rs.getString("start_time");
		ResultSet rss=util.query("select city,airport_name,arrivetime from stop,airport where flight_ID='"+flight.flight_id+"' and stop.stop_ID=airport.airport_ID");
		if(rss.next()){
			flight.end_airport=rss.getString("airport_name");
			flight.end_city=rss.getString("city");
			flight.end_time=rss.getString("arrivetime");
		}
	}else{
		flight.end_city=rs.getString("end_city");
		flight.end_airport=rs.getString("end_airport");
		flight.end_time=rs.getString("end_time");
		ResultSet rss=util.query("select city,airport_name,arrivetime from stop,airport where flight_ID='"+flight.flight_id+"' and stop.stop_ID=airport.airport_ID");
		if(rss.next()){
			flight.start_airport=rss.getString("airport_name");
			flight.start_city=rss.getString("city");
			flight.start_time=rss.getString("arrivetime");
		}
	}
	%>
	<li class="layui-timeline-item">
    <i class="layui-icon layui-timeline-axis"></i>
    <div class="layui-timeline-content layui-text">
      <div class="layui-timeline-title">
	      <%=flight.start_time %>, 该乘客在<%=flight.start_city %>市的<%=flight.start_airport %>机场乘坐<%=flight.flight_id %>号航班，
	      <br>
	      <%=flight.end_time %>, 该乘客在<%=flight.end_city %>市的<%=flight.end_airport %>机场落地。
	      <br>
	      <a href="findOthers.jsp?flightID=<%=flight.flight_id %>">查看该航班乘客</a>
	  </div>
    </div>
  </li>
<% 
}
util.close();
%>
</ul>
</body>
</html>