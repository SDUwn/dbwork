<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Db.Dbutil" %>
<%@ page import="java.sql.*" %>
<%@ page import="Bean.Ticket" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户反馈</title>
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
  <style type="text/css">body{margin: 2em 0.5em 0.5em 0em;}</style>
</head>
<body>
<%
Dbutil util=new Dbutil();
String SQL="";
ResultSet rs=null;
%>
<table class="layui-table" lay-filter="parse-table-demo" >
  <thead>
    <tr>
    	<th lay-data="{field:'1', width:100,fixed:'left'}">用户ID</th>
       	<th lay-data="{field:'2', width:100, sort: true}">评分</th>
        <th lay-data="{field:'3', width:550}">评价</th>        
        <th lay-data="{field:'4', width:200,sort:true}">时间</th>
    </tr> 
  </thead>
  <tbody>
<%
SQL="select * from comment";
rs=util.query(SQL);
while(rs.next()){
%>
		<tr>
		   	<td><%=rs.getInt("user_ID") %></td>
    		<td><%=rs.getInt("score") %></td>
    		<td><%=rs.getString("comment") %></td>
    		<td><%=rs.getString("commit_time") %></td>
    	</tr>

<%
}
util.close();
%>
</tbody>
</table>
</body>
<script type="text/javascript" src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="../layui/layui.js" charset="utf-8"></script>
<script>
layui.use('table', function(){
	  var table = layui.table;
	      table.init('parse-table-demo', { //转化静态表格
	        //height: 'full-500'
			page:true
	      });
	    });
</script>
</body>
</html>




