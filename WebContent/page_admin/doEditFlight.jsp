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
System.out.println(flight_ID+"|"+plane_ID+"|"+start_ID+"|"+end_ID+"|"+start_time+"|"+end_time+"|"+A_price);
String SQL="";
Dbutil util=new Dbutil();
ResultSet rs=null;
SQL="update flight set plane_ID='"+plane_ID+"',start_ID='"+start_ID+"',start_time='"+start_time+"',end_ID='"+end_ID+"',end_time='"+end_time+"',A_price='"+A_price+"',B_price='"+B_price+"',C_price='"+C_price+"' where flight_ID='"+flight_ID+"' ";
util.update(SQL);
util.close();
flag=true;
%>
<script type="text/javascript">
if(<%=flag %>==true){
	alert("修改成功！");
	window.location.href="ticket_admin.jsp";
}
</script>
</body>
</html>