<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<%@ page import="java.sql.*" %>
<%@ page import="Db.Dbutil"  %>
<%@ page import="Bean.Seat" %>
<html>
<%
boolean flag=false;
String user_ID=session.getAttribute("ID").toString();
String flight_ID=request.getParameter("flight");
String cert_num=request.getParameter("passenger");
String ticket_ID=request.getParameter("ticket_ID");
String seat=null;
String seat_ID=null;
String price=null;
float baby_rate,child_rate,student_rate;
try{
	seat=request.getParameter("seat_type");
	String[] seat_info = seat.split(",");
	seat_ID=seat_info[0];
	price=seat_info[1];
}catch(Exception e){
%>
<script>alert("暂无余票！");</script>
<%
	return;
}
%>	

<% 
String SQL="";
ResultSet rs=null;
Dbutil util=new Dbutil();
%>
<%
SQL=" insert into ticket(flight_ID,passenger_ID,seat_ID,price,ticket_state,user_ID,booktime) ";
SQL+=" values('"+flight_ID+"','"+cert_num+"','"+seat_ID+"','"+price+"','已订','"+user_ID+"',NOW() )";
util.update(SQL);
%>
<%
SQL=" update flight_seat ";
SQL+=" set seat_state='已占' ";
SQL+=" where flight_ID='"+flight_ID+"' and seat_ID='"+seat_ID+"' ";
util.update(SQL);
SQL=" update ticket ";
SQL+=" set ticket_state='已退',returntime=NOW() ";
SQL+=" where ticket_ID="+ticket_ID+" ";
util.update(SQL);
SQL="update flight_seat "; 
SQL+=" set seat_state='正常' ";
SQL+=" where (flight_ID,seat_ID) in (select flight_ID,seat_ID from ticket where ticket.ticket_ID="+ticket_ID+") ";
util.update(SQL);
util.close();
flag=true;
if(flag){
%>
<script type="text/javascript">
alert("改签成功！");
window.location.href="bookedTicket.jsp";
</script>
<%
}
%>
</html>