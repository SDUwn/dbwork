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
SQL+=" set ticket_state='returned' ";
SQL+=" where ticket_ID="+ticket_ID+" ";
util.update(SQL);
System.out.println(SQL);
SQL="update flight_seat "; 
SQL+=" set seat_state='normal' ";
SQL+=" where (flight_ID,seat_ID) in (select flight_ID,seat_ID from ticket where ticket.ticket_ID="+ticket_ID+") ";
util.update(SQL);
System.out.println(SQL);
util.close();
%>
