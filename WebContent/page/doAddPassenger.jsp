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
String pass_name=request.getParameter("pass_name");
String sex=request.getParameter("sex");
int age=Integer.parseInt(request.getParameter("age").toString());
String cert_type=request.getParameter("cert_type");
String cert_num=request.getParameter("cert_num");
String telephone=request.getParameter("telephone");
String mail=request.getParameter("mail");
String address=request.getParameter("address");
String user_ID=session.getAttribute("ID").toString();
Dbutil util=new Dbutil();
String SQL="";
ResultSet rs=null;
boolean flag=false;
%>

<%
		SQL="insert into passenger(passenger_name,sex,age,certype,cernum,mail,phone,state,address,user_ID)values('"+pass_name+"','"+sex+"','"+age+"','"+cert_type+"','"+cert_num+"','"+mail+"','"+telephone+"','normal','"+address+"','"+user_ID+"')";
		util.update(SQL);  
		flag=true;
%>
<%
util.close();
if(flag==true){
%>
<script type="text/javascript">
alert("添加成功！");
window.location.href="flight.jsp";
</script>
<%
}
%>
</html>