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
String stop_ID=request.getParameter("stop");
String arrivetime=request.getParameter("arrivetime");
String stoptime=request.getParameter("stoptime");
String A_price=request.getParameter("A_price"),B_price=request.getParameter("B_price"),C_price=request.getParameter("C_price"),A1_price=request.getParameter("A1_price"),B1_price=request.getParameter("B1_price"),C1_price=request.getParameter("C1_price"),A2_price=request.getParameter("A2_price"),B2_price=request.getParameter("B2_price"),C2_price=request.getParameter("C2_price");
//System.out.println(flight_ID+"|"+plane_ID+"|"+start_ID+"|"+end_ID+"|"+start_time+"|"+end_time+"|"+A_price);
String SQL="";
Dbutil util=new Dbutil();
ResultSet rs=null;
SQL="select * from flight_seat where flight_ID='"+flight_ID+"' and seat_state='已占' ";
if(util.query(SQL).next()){
	%>
	<script type="text/javascript">
	alert("已有乘客订座，无法更改航班！");
	window.location.href="../ticket_admin.jsp"
	</script>
	<% 
	return;
}else{
SQL="update flight set plane_ID='"+plane_ID+"',start_ID='"+start_ID+"',start_time='"+start_time+"',end_ID='"+end_ID+"',end_time='"+end_time+"',A_price='"+A_price+"',B_price='"+B_price+"',C_price='"+C_price+"' where flight_ID='"+flight_ID+"' ";
util.update(SQL);
if(util.query("select 1 from stop where flight_ID='"+flight_ID+"' ").next()){
	SQL="delete from stop where flight_ID='"+flight_ID+"' ";
	util.update(SQL);
	SQL="delete from flight_seat_1 where flight_ID='"+flight_ID+"' ";
	util.update(SQL);
}else{
	SQL="delete from flight_seat where flight_ID='"+flight_ID+"' ";
	util.update(SQL);
}
if(stop_ID.equals("null")){
	SQL="select seat_ID from plane_seat where plane_ID='"+plane_ID+"' ";
	rs=util.query(SQL);
	while(rs.next()){
		util.update("insert into flight_seat values('"+flight_ID+"','"+rs.getInt("seat_ID")+"','正常')");
	}
}else{
	SQL="select seat_ID from plane_seat where plane_ID='"+plane_ID+"' ";
	rs=util.query(SQL);
	while(rs.next()){
		util.update("insert into flight_seat_1 values('"+flight_ID+"','"+rs.getInt("seat_ID")+"','正常','正常')");
	}
	SQL="insert into stop values('"+flight_ID+"','"+stop_ID+"','"+arrivetime+"','"+stoptime+"','"+A1_price+"','"+B1_price+"','"+C1_price+"','"+A2_price+"','"+B2_price+"','"+C2_price+"')";
	util.update(SQL);
}
util.close();
flag=true;
%>
<script type="text/javascript">
if(<%=flag %>==true){
	alert("修改成功！");
}
</script>
<%} %>
<script type="text/javascript">	
window.location.href="../ticket_admin.jsp";
</script>
</body>
</html>