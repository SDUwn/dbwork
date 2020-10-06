<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="Db.Dbutil"%>
<%
String passenger_ID=request.getParameter("passenger_ID");
String state=request.getParameter("state");
Dbutil util =new Dbutil();
ResultSet rs=null;
String SQL="";
if(state.equals("禁用")){
SQL="update passenger set state='limited' where cernum='"+passenger_ID+"' ";
util.update(SQL);
SQL="update ticket set ticket_state='limited' where ticket_state='normal' and passenger_ID='"+passenger_ID+"' ";
util.update(SQL);
}else{
	SQL="update passenger set state='normal' where cernum='"+passenger_ID+"' ";
	util.update(SQL);
	SQL="update ticket set ticket_state='normal' where ticket_state='limited' and passenger_ID='"+passenger_ID+"'  ";
	util.update(SQL);
}
util.close();
%>