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
<%
String flight_ID=request.getParameter("flight_ID");
System.out.println(flight_ID);
Dbutil util=new Dbutil();
ResultSet rs=null;
String SQL="";
SQL="select * from ticket where flight_ID='"+flight_ID+"' ";
rs=util.query(SQL);
if(rs.next()){
	%>
	<script type="text/javascript">
	alert("无法删除！乘客已订票！");
	window.location.href="../ticket_admin.jsp"
	</script>
	
	<%
	return;
}
SQL="delete from flight where flight_ID='"+flight_ID+"' ";
util.update(SQL);
util.close();
%>
<script type="text/javascript">window.location.href="../ticket_admin.jsp"</script>
</body>
</html>