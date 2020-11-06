<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Db.Dbutil" %>
<%@ page import="java.sql.*" %>

<%
String ticket_ID=request.getParameter("ticket_ID").toString();
Dbutil util=new Dbutil();
ResultSet rs=null;
String SQL="";
SQL=" update ticket ";
SQL+=" set ticket_state='已退',returntime=NOW() ";
SQL+=" where ticket_ID="+ticket_ID+" ";
util.update(SQL);
SQL="select isStop1,isStop2,flight_ID,seat_ID from ticket where ticket_ID="+ticket_ID+" ";
rs=util.query(SQL);
int stop1=-1,stop2=-1,flight_ID=0,seat_ID=0;
if(rs.next()){
	stop1=Integer.parseInt(rs.getString("isStop1"));
	stop2=Integer.parseInt(rs.getString("isStop2"));
	flight_ID=rs.getInt("flight_ID");
	seat_ID=rs.getInt("seat_ID");
}
if(util.query("select 1 from stop where stop.flight_ID='"+flight_ID+"' ").next()){
	if(stop1==0&&stop2==0)
		SQL="update flight_seat_1 set seat_state1='正常',seat_state2='正常' where seat_ID='"+seat_ID+"' and flight_ID='"+flight_ID+"' ";
	else if(stop1==1&&stop2==0)
		SQL="update flight_seat_1 set seat_state1='正常' where seat_ID='"+seat_ID+"' and flight_ID='"+flight_ID+"'";
	else
		SQL="update flight_seat_1 set seat_state2='正常' where seat_ID='"+seat_ID+"' and flight_ID='"+flight_ID+"'";
}else{
SQL="update flight_seat "; 
SQL+=" set seat_state='正常' ";
SQL+=" where seat_ID='"+seat_ID+"' and flight_ID='"+flight_ID+"' ";
}
System.out.println(SQL);
util.update(SQL);
util.close();
%>
