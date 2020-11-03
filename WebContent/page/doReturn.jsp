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
if(util.query("select 1 from stop where stop.flight_ID in (select flight_ID from ticket where ticket_ID="+ticket_ID+")").next()){
	SQL="update flight_seat_1 set seat_state1='正常',seat_state2='正常' where (flight_ID,seat_ID) in (select flight_ID,seat_ID from ticket where ticket.ticket_ID="+ticket_ID+") ";
}else{
SQL="update flight_seat "; 
SQL+=" set seat_state='正常' ";
SQL+=" where (flight_ID,seat_ID) in (select flight_ID,seat_ID from ticket where ticket.ticket_ID="+ticket_ID+") ";}
util.update(SQL);
util.close();
%>
