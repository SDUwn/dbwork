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
<table class="layui-table" id="tab">
  <thead>
    <tr>
      	<th >通知ID</th>
       	<th >通知标题</th>
       	<th >作者</th>
        <th >编辑时间</th>
        <th >编辑</th>        
        <th >删除</th>
        <th >查看</th>
    </tr> 
  </thead>
  <tbody>
<%
String news_content=request.getParameter("news_content");
String SQL="select * from news where news_content like '%"+news_content+"%' or news_title like '%"+news_content+"%' ";
Dbutil util=new Dbutil();
ResultSet rs=null;
rs=util.query(SQL);
while(rs.next()){
	%>
	<tr>
    		<td><%=rs.getInt("news_ID") %></td>    		
    		<td><%=rs.getString("news_title") %></td>
    		<td><%=rs.getInt("admin_ID") %></td>
    		<td><%=rs.getString("edit_time") %></td>
    		<td><input type="button" class="layui-btn layui-btn-warm layui-btn-xs edit" name="edit" value="编辑" ></td>    		
    		<td><input type="button" class="layui-btn layui-btn-danger layui-btn-xs delete" name="delete" value="删除"></td>    		
    		<td><input type="button" class="layui-btn layui-btn-xs view" name="view" value="查看"></td>
    </tr>
	<%
}
util.close();
%>   
</tbody>
</table>
</body>
</html>