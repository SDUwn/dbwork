<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Db.Dbutil" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
response.setContentType("text/html;charset=utf-8");  
request.setCharacterEncoding("utf-8");
String comment=request.getParameter("comment");
String score=request.getParameter("score");
String user_ID=session.getAttribute("ID").toString();
System.out.println(comment+" "+score+" "+user_ID);
Dbutil util=new Dbutil();
ResultSet rs=null;
String SQL="";
SQL="insert into comment(user_ID,score,comment,commit_time) values ('"+user_ID+"','"+score+"','"+comment+"',NOW())";
util.update(SQL);
util.close();
%>
<script>
alert("提交成功！感谢您的反馈！");
window.location.href="comment.jsp";
</script>
</body>
</html>