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
boolean flag=false;
String news_ID=request.getParameter("news_ID");
String SQL="delete from news where news_ID='"+news_ID+"' ";
Dbutil util=new Dbutil();
util.update(SQL);
flag=true;
%>
<script type="text/javascript">
if(<%=flag%>==true){
	alert("删除成功！");
	window.location.href="../manageNews.jsp";
}
</script>
</body>
</html>