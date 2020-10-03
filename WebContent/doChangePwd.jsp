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
<%
	String pwd_before=request.getParameter("pwd_before");
	String pwd_now=request.getParameter("pwd_now");
	String pwd_ensure=request.getParameter("pwd_ensure");
	String user_ID=session.getAttribute("ID").toString();
	Dbutil util=new Dbutil();
	ResultSet rs=null;
	String SQL="";
	SQL="select * from user where user_ID='"+user_ID+"' and password='"+pwd_before+"' ";
	rs=util.query(SQL);
	if(!rs.next()){
		%>
		<script>
		alert("原密码错误!")
		window.location.href="changePassword.jsp";
		</script>
		<%
	}
	if(pwd_now.equals(pwd_ensure)){
		SQL="update user set password='"+pwd_now+"' where user_ID='"+user_ID+"' and password='"+pwd_before+"' ";
		util.update(SQL);
		util.close();
		%>
<script>
alert("修改成功!请重新登录");
window.location.href="login.jsp";
</script>
		<% 
	}else{
		%>
<script type="text/javascript">
alert("请输入一致的密码！");
window.location.href="changePassword.jsp"
</script>
<%
	}
	%>
</html>