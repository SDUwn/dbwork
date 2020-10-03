<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Bean.Passenger" %>
<%@ page import="Bean.Seat" %>
<%@ page import="Db.Dbutil" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Layui</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
</head>
<body>
<%
String flight_ID=request.getParameter("flight_ID");
String cert_num=session.getAttribute("cert_num").toString();
String user_ID=session.getAttribute("ID").toString();
Dbutil util=new Dbutil();
String SQL="";
ResultSet rs=null;
%>
<form class="layui-form" action="doBook.jsp" method="post">
	<div class="layui-form-item">
	 <label class="layui-form-label">选择乘客</label>
	 <button class="layui-btn layui-btn-primary" type="button" onclick="addPass();">添加乘客</button>
     <div class="layui-input-inline">
      <select name="passenger">
        <%
        SQL="select passenger_name,cernum from passenger where user_ID='"+user_ID+"'";
        rs=util.query(SQL);
        Passenger pass=new Passenger();
        while(rs.next()){
        	pass.pass_name=rs.getString("passenger_name");
        	pass.cert_num=rs.getString("cernum");
        %>
        <option value="<%=pass.cert_num %>"><%=pass.pass_name %></option>
        <%} %>
      </select>
    </div>
  	</div>
  	<div class="layui-form-item">
    <label class="layui-form-label">航班号</label>
    <div class="layui-input-inline">
      <input name="flight" class="layui-input" type="text"  value="<%=flight_ID %>" readonly="readonly">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">座位类型</label>
    <div class="layui-input-block">
     <%
        SQL=" select flight_seat.seat_ID,cabin_type,seat_type,seat_location,A_price,B_price,C_price ";
        SQL+=" FROM plane_seat,flight_seat,flight ";
        SQL+=" where seat_state='normal' and flight.plane_ID=plane_seat.plane_ID ";
        SQL+=" and flight_seat.flight_ID=flight.flight_ID and flight.flight_ID='"+flight_ID+"' ";
        SQL+=" and plane_seat.seat_ID=flight_seat.seat_ID " ;
        rs=util.query(SQL);
        Seat seat=new Seat();
        while(rs.next()){
        	seat.seat_ID=rs.getInt("seat_ID");
        	seat.cabin_type=rs.getString("cabin_type");
        	seat.seat_type=rs.getString("seat_type");
        	seat.seat_location=rs.getString("seat_location");
        	if(seat.seat_type.equals("A"))seat.price=rs.getDouble("A_price");
        	else if(seat.seat_type.equals("B"))seat.price=rs.getDouble("B_price");
        	else seat.price=rs.getDouble("C_price");
        %>
      <input name="seat_type" title="类型：<%=seat.seat_type %><br>价格:<%=seat.price %>" type="radio"  value="<%=seat.seat_ID %>,<%=seat.price %>">
    <%}
       util.close();
       %>
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" type="submit">提交</button>
      <button class="layui-btn layui-btn-primary" type="reset">重置</button>
    </div>
  </div>
</form>
</body>
<script src="../layui/layui.js" charset="UTF-8"></script>
<script type="text/javascript" src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script>
layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate;
});
function addPass(){
	window.location.href="add_passenger.jsp";
}
</script>
</html>



