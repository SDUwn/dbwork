<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Seat" %>
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
Dbutil util=new Dbutil();
String ticket_ID=request.getParameter("ticket_ID");
String flight_ID=request.getParameter("flight_ID");
ResultSet rss=util.query("select isStop1,isStop2 from ticket where ticket_ID='"+ticket_ID+"' ");
int stop1=0,stop2=0;
if(rss.next()){
 stop1=Integer.parseInt(rss.getString("isStop1"));
 stop2=Integer.parseInt(rss.getString("isStop2"));
 }
ResultSet rs=null;
String cert_num=null;
String SQL="select passenger_ID from ticket where ticket_ID='"+ticket_ID+"' ";
rs=util.query(SQL);
if(rs.next()){cert_num=rs.getString("passenger_ID");}
%>
<form class="layui-form" action="doChange1.jsp?ticket_ID=<%=ticket_ID %>" method="post">
	<div class="layui-form-item">
	 <label class="layui-form-label">乘客证件号</label>
     <div class="layui-input-inline">
        <input name=passenger class="layui-input" type="text"  value="<%=cert_num %>" readonly="readonly">
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
    <ul>
     <%
     if(stop1==0&&stop2==0){
     	if(util.query("select 1 from stop where flight_ID='"+flight_ID+"'").next()){
     		SQL=" select flight_seat_1.seat_ID,cabin_type,seat_type,seat_location,A_price,B_price,C_price ";
     		SQL+=" FROM plane_seat,flight_seat_1,flight ";
     		SQL+=" where flight.flight_ID='"+flight_ID+"' and seat_state1='正常' and seat_state2='正常' and flight.plane_ID=plane_seat.plane_ID ";
     		SQL+=" and flight_seat_1.flight_ID=flight.flight_ID ";
     		SQL+=" and plane_seat.seat_ID=flight_seat_1.seat_ID ";
     		SQL+=" order by seat_location ";
     	}else{
         SQL=" select flight_seat.seat_ID,cabin_type,seat_type,seat_location,A_price,B_price,C_price ";
         SQL+=" FROM plane_seat,flight_seat,flight ";
         SQL+=" where seat_state='正常' and flight.plane_ID=plane_seat.plane_ID ";
         SQL+=" and flight_seat.flight_ID=flight.flight_ID and flight.flight_ID='"+flight_ID+"' ";
         SQL+=" and plane_seat.seat_ID=flight_seat.seat_ID order by seat_location" ;}
      }else if(stop1==1&&stop2==0){
     	 SQL=" SELECT flight_seat_1.seat_ID,A1_price as A_price,B1_price as B_price,C1_price as C_price,seat_type,seat_location,cabin_type ";
     	 SQL+=" from flight_seat_1,stop,plane_seat,flight ";
          SQL+=" where flight_seat_1.flight_ID='"+flight_ID+"' and seat_state1='正常' and stop.flight_ID=flight_seat_1.flight_ID ";
          SQL+=" and plane_seat.seat_ID=flight_seat_1.seat_ID and flight_seat_1.flight_ID=flight.flight_ID and flight.plane_ID=plane_seat.plane_ID ";    	 
      }else{
     	 SQL=" SELECT flight_seat_1.seat_ID,A2_price as A_price,B2_price as B_price,C2_price as C_price,seat_type,seat_location,cabin_type ";
     	 SQL+=" from flight_seat_1,stop,plane_seat,flight ";
          SQL+=" where flight_seat_1.flight_ID='"+flight_ID+"' and seat_state2='正常' and stop.flight_ID=flight_seat_1.flight_ID ";
          SQL+=" and plane_seat.seat_ID=flight_seat_1.seat_ID and flight_seat_1.flight_ID=flight.flight_ID and flight.plane_ID=plane_seat.plane_ID ";    	 
      }
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
		<li><input type="radio"  name="seat_type" title="类型：<%=seat.seat_type %>&nbsp&nbsp&nbsp位置：<%=seat.seat_location %>&nbsp&nbsp&nbsp 价格:<%=seat.price %>" value="<%=seat.seat_ID %>,<%=seat.price %>"></li>
   	   <%}
       		util.close();
       %>
       </ul>
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
layui.use('form', function(){
  var form = layui.form;
  form.render();
});
</script>
</html>