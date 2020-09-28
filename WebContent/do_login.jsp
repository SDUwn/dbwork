<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Db.Dbutil" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>处理登录</title>
</head>
<body>
<%
 String name=request.getParameter("name");//获取name的参数值
 String password=request.getParameter("password");//获取password的参数值
 String admin=request.getParameter("admin");
%>

<%
 String queryNumberSQL="";
 ResultSet rs=null;
 int ID=-1;
 Dbutil util=new Dbutil();
 if(admin==null){
 	queryNumberSQL="SELECT * from user where user_name='"+name+"' and password='"+password+"'";
 	rs=util.query(queryNumberSQL);//执行数据库查询操作并获取结果集
 }else if(admin.equals("admin")){
	 	queryNumberSQL="SELECT * from admin where admin_name='"+name+"' and password='"+password+"'";
	 	rs=util.query(queryNumberSQL);//执行数据库查询操作并获取结果集
 }
 boolean flag=false;//初始化flag
 if(rs.next()){//判断结果
 flag=true;
 if(admin==null){ID=rs.getInt("user_ID");}
 else{ID=rs.getInt("admin_ID");}

 session.setAttribute("UserName", name);//将name的内容赋值给UserName
 session.setAttribute("ID", ID);
 }else{
 flag=false;
 System.out.println("您的账号或者密码错误");
 }
%>
<%
 if(flag){
	 if(admin==null){
%>
<jsp:forward page="login_success.jsp"></jsp:forward>//跳转页面
<%
	 }else{%>
<jsp:forward page="login_admin_success.jsp"></jsp:forward>//跳转页面
<%	 }
	}else{
%>
<jsp:forward page="login_failed.jsp"></jsp:forward>//跳转页面
<%
 }
util.close();
%>
</body>
</html>