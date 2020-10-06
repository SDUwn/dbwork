<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Flight" %>
<%@ page import="java.sql.*" %>
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
int flight_ID=Integer.parseInt(request.getParameter("flight_ID"));
Dbutil util=new Dbutil();
ResultSet rs=null;
String SQL="";
SQL="select * from flight where flight_ID='"+flight_ID+"' ";
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
