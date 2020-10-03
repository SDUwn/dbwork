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
String user_name=request.getParameter("user_name");
String password=request.getParameter("password");
String telephone=request.getParameter("telephone");
System.out.println(user_name);

%>
<%
 Dbutil util=new Dbutil();
 ResultSet rs=null;
 boolean flag=false;
 rs=util.query("select * from user where user_name='"+user_name+"'and password='"+password+"'");
	if(rs.next()){
		out.print("用户已经存在  "+"请<a href=\"login.jsp\">登录</a>");
	}else{
		util.update("insert into user(user_name,password,phone)values('"+user_name+"','"+password+"','"+telephone+"')");  
		flag=true;
	}
 %>
 <%
 util.close();
 %>
 <%
 if(flag==true)
	 session.setAttribute("info", "注册成功，请登录!");//将name的内容赋值给UserName
 %>
 <jsp:forward page="index.html"></jsp:forward>//跳转页面
</body>
</html>