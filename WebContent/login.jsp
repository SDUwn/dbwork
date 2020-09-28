<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>欢迎登录飞机售票系统</title>
<link href="css/login.css" type="text/css" rel="stylesheet">
</head>

<body bgcolor="#fef4d9">
<font color="green"><%=session.getAttribute("info") %>!</font>

	<hr><br>Welcome to this <font color="green">Login Page</font>!<br>
	<form action="do_login.jsp" method="post">
	<h2>Please input your message:</h2><br>
	用户名:<input type="text" name="name"><br><br>
	密码:  <input type="password" name="password"><br><br>
	<input type="checkbox" name="admin" value="admin">管理员登录<br><br>
	<input type="submit" value="登陆"><input type="reset"><br>
	</form>
	<br>
	<a href="register.jsp">没有账号？注册</a>
</body>
</html>