<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="Db.Dbutil" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
<%
response.setContentType("text/html;charset=utf-8");  
request.setCharacterEncoding("utf-8");
String pass_name=request.getParameter("pass_name");
String sex=request.getParameter("sex");
int age=Integer.parseInt(request.getParameter("age").toString());
String cert_type=session.getAttribute("cert_type").toString();
if(cert_type.equals("null")){
	cert_type=request.getParameter("cert_num");
}String cert_num=session.getAttribute("cert_num").toString();
if(cert_num.equals("null")){
	cert_num=request.getParameter("cert_num");
}
String telephone=request.getParameter("telephone");
String mail=request.getParameter("mail");
String address=request.getParameter("address");
int user_ID=Integer.parseInt(request.getSession().getAttribute("ID").toString());
Dbutil util=new Dbutil();
String SQL="";
ResultSet rs=null;
%>

<%
SQL="select * from passenger where cernum='"+cert_num+"'";
System.out.println(SQL);

rs=util.query(SQL);
	if(rs.next()){
		SQL="update passenger set passenger_name='"+pass_name+"',sex='"+sex+"', age='"+age+"', mail='"+mail+"', phone='"+telephone+"', address='"+address+"' where cernum='"+cert_num+"'";
		util.update(SQL); 
	}else{
		SQL="insert into passenger(passenger_name,sex,age,certype,cernum,mail,phone,state,address,is_main,user_ID)values('"+pass_name+"','"+sex+"','"+age+"','"+cert_type+"','"+cert_num+"','"+mail+"','"+telephone+"','正常','"+address+"','Y','"+user_ID+"')";
		util.update(SQL);  
	}
%>
<%
session.setAttribute("cert_num", cert_num);
util.close();
%>
<jsp:forward page="myself.jsp"></jsp:forward>
</html>