<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Db.Dbutil" %>
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
SQL="select ticket.flight_ID as flightID,start_ID,end_ID,start_time,end_time,aa.airport_name as start_airport,aa.city as start_city,bb.airport_name as end_airport,bb.city as end_city ";
SQL+=" from ticket,flight,airport as aa,airport as bb ";
SQL+=" where passenger_ID='"+passenger_ID+"' and ticket_state='已用' ";
SQL+=" and ticket.flight_ID=flight.flight_ID and date(start_time)='"+time+"' ";
SQL+=" and flight.start_ID=aa.airport_ID and flight.end_ID=bb.airport_ID ";
rs=util.query(SQL);
while(rs.next()){
	%>
	<li class="layui-timeline-item">
    <i class="layui-icon layui-timeline-axis"></i>
    <div class="layui-timeline-content layui-text">
      <div class="layui-timeline-title">
	      <%=rs.getString("start_time") %>,该乘客在<%=rs.getString("start_city") %>市的<%=rs.getString("start_airport") %>机场乘坐<%=rs.getInt("flightID") %>号航班，
	      <br>
	      <%=rs.getString("end_time") %>，该乘客在<%=rs.getString("end_city") %>市的<%=rs.getString("end_airport") %>机场落地。
	      <br>
	      <a href="findOthers.jsp?flightID=<%=rs.getString("flightID") %>">查看该航班同行乘客</a>
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