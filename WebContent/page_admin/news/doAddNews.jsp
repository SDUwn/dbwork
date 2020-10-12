<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Db.Dbutil" %>
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
String admin_ID=session.getAttribute("ID").toString();
String news_title=request.getParameter("news_title");
String news_content=request.getParameter("news_content");
String SQL="insert into news(news_title,news_content,admin_ID,edit_time) values ('"+news_title+"','"+news_content+"','"+admin_ID+"', NOW())";
Dbutil util=new Dbutil();
util.update(SQL);
util.close();
%>
<script type="text/javascript">window.location.href="../manageNews.jsp"</script>
</body>
</html>