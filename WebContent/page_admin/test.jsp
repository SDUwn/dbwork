<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Flight" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>航班管理</title>
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
</head>
<body>
<div id="div1">
<table class="layui-table">
  <thead>
    <tr>
      	<th >航班号</th>
       	<th >飞机编号</th>
       	<th >出发地</th>
        <th >出发时间</th>
        <th >到达地</th>
        <th >到达时间</th>
        <th >航班状态</th>
        <th >票价A</th>
        <th >票价B</th>
        <th >票价C</th>
        <th >编辑</th>        
        <th >删除</th>
        <th >查看</th>
    </tr> 
  </thead>
  <tbody>
<%
Dbutil util=new Dbutil();
ResultSet rs=null;
String SQL="select * from flight";
rs=util.query(SQL);
while(rs.next()){
	Flight flight=new Flight();
	flight.flight_id=rs.getInt("flight_ID");
	flight.plane_id=rs.getInt("plane_ID");
	flight.start_id=rs.getInt("start_ID");
	flight.start_time=rs.getString("start_time");
	flight.end_id=rs.getInt("end_ID");
	flight.end_time=rs.getString("end_time");
	flight.flight_state=rs.getString("flight_state");
	flight.A_price=rs.getDouble("A_price");
	flight.B_price=rs.getDouble("B_price");
	flight.C_price=rs.getDouble("C_price");
	%>
	<tr>
    		<td><%=flight.flight_id %></td>    		
    		<td><%=flight.plane_id %></td>
    		<td><%=flight.start_id %></td>
    		<td><%=flight.start_time %></td>
    		<td><%=flight.end_id %></td>
    		<td><%=flight.end_time %></td>
    		<td><%=flight.flight_state %></td>
    		<td><%=flight.A_price %></td>    		
    		<td><%=flight.B_price %></td>    		
    		<td><%=flight.C_price %></td>
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
</div>
<script type="text/javascript" src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="../layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
layui.use('table', function(){
	  var table = layui.table;
	      table.init('parse-table-demo', { 
			page:true
	      });
	    });
$(".edit").on("click",function(event) {
	alert($(this).closest("tr").find("td").eq(0).text());
});
$(".delete").on("click",function(event) {
	alert($(this).closest("tr").find("td").eq(0).text());
});
$(".view").on("click",function(event) {
	alert($(this).closest("tr").find("td").eq(0).text());
});

</script>
</body>
</html>