<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Flight" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
boolean flag=false;
String flight_ID=request.getParameter("flight_ID");
String plane_ID=request.getParameter("plane_ID");
String start_ID=request.getParameter("start");
String end_ID=request.getParameter("end");
String start_time=request.getParameter("starttime");
String end_time=request.getParameter("endtime");
String A_price=request.getParameter("A_price"),B_price=request.getParameter("B_price"),C_price=request.getParameter("C_price");
//System.out.println(flight_ID+"|"+plane_ID+"|"+start_ID+"|"+end_ID+"|"+start_time+"|"+end_time+"|"+A_price);
String SQL="";
Dbutil util=new Dbutil();
ResultSet rs=null;
SQL="insert into flight values('"+flight_ID+"','"+plane_ID+"','"+start_ID+"','"+start_time+"','"+end_ID+"','"+end_time+"','normal','"+A_price+"','"+B_price+"','"+C_price+"') ";
util.update(SQL);
rs=util.query("select seat_ID from plane_seat where plane_ID='"+plane_ID+"' ");
while(rs.next()){
	util.update("insert into flight_seat values('"+flight_ID+"','"+rs.getInt("seat_ID")+"','normal')");
}
util.close();
flag=true;
%>
<script type="text/javascript">
if(<%=flag %>==true){
	alert("添加成功！");
	window.location.href="ticket_admin.jsp";
}
</script>
</body>
</html>