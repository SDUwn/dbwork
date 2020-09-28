<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String flight_ID=request.getParameter("flightID");
String user_ID=session.getAttribute("ID").toString();
System.out.println(flight_ID+"  "+user_ID);
%>