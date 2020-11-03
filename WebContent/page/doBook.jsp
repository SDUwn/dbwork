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
int stop1=Integer.parseInt(request.getParameter("stop1"));
int stop2=Integer.parseInt(request.getParameter("stop2"));
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
SQL=" insert into ticket(flight_ID,passenger_ID,seat_ID,price,ticket_state,user_ID,booktime,isStop1,isStop2) ";
SQL+=" values('"+flight_ID+"','"+cert_num+"','"+seat_ID+"','"+price+"','已订','"+user_ID+"',NOW(),'"+stop1+"','"+stop2+"' )";
util.update(SQL);
%>
<%
if(stop1==0&&stop2==0){
	if(util.query("select 1 from stop where flight_ID='"+flight_ID+"' ").next()){
		SQL=" update flight_seat_1 ";
		SQL+=" set seat_state1='已占',seat_state2='已占' ";
		SQL+=" where flight_ID='"+flight_ID+"' and seat_ID='"+seat_ID+"' ";
	}else{
	SQL=" update flight_seat ";
	SQL+=" set seat_state='已占' ";
	SQL+=" where flight_ID='"+flight_ID+"' and seat_ID='"+seat_ID+"' ";
	}
}else if(stop1==1&&stop2==0){
	SQL=" update flight_seat_1 ";
	SQL+=" set seat_state1='已占' ";
	SQL+=" where flight_ID='"+flight_ID+"' and seat_ID='"+seat_ID+"' ";
}else{
	SQL=" update flight_seat_1 ";
	SQL+=" set seat_state2='已占' ";
	SQL+=" where flight_ID='"+flight_ID+"' and seat_ID='"+seat_ID+"' ";
}
util.update(SQL);
util.close();
flag=true;
if(flag){
%>
<script type="text/javascript">
alert("订票成功！");
window.location.href="bookedTicket.jsp";
</script>
<%
}
%>
</html>