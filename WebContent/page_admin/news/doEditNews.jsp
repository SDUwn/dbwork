<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Flight" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<%
response.setContentType("text/html;charset=utf-8");  
request.setCharacterEncoding("utf-8");
boolean flag=false;
String news_ID=request.getParameter("news_ID");
String news_title=request.getParameter("news_title");
String news_content=request.getParameter("news_content");
String admin_ID=session.getAttribute("ID").toString();
String SQL="update news set news_title='"+news_title+"',news_content='"+news_content+"',admin_ID='"+admin_ID+"',edit_time=NOW() where news_ID='"+news_ID+"' ";
Dbutil util=new Dbutil();
util.update(SQL);
util.close();
flag=true;
%>
<script type="text/javascript">
if(<%=flag %>==true){
	alert("修改成功！");
	window.location.href="../manageNews.jsp";
}
</script>
</body>
</html>