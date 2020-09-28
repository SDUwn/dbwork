<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>注册</title>
<link href="css/login.css" type="text/css" rel="stylesheet">
</head>
<body bgcolor="#fef4d9">
<h2>账号注册</h2>
<form action="do_register.jsp" method="get">
姓名：<input type="text" name="user_name"><br><br>
密码：<input type="password" name="password"><br><br>
手机号：<input type="text" name="telephone"><br><br>
<input type="submit" value="确定">&nbsp;&nbsp;&nbsp;<input type="reset">
</form>
</body>
</html>