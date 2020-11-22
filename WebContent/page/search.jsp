<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Flight" %>
<%@ page import="java.time.LocalDate" %>
      
<%  
    //设置输出信息的格式及字符集  
    response.setContentType("text/xml; charset=UTF-8");  
    response.setHeader("Cache-Control","no-cache"); 
    String SQL="",SQL2="",SQL3="";
    String startcity=request.getParameter("startcity");
	String endcity=request.getParameter("endcity");
	String starttime=request.getParameter("starttime");
%>
<% 
SQL="SELECT flight_ID,plane_type,company_name,A_price,B_price,C_price,a.city as start_city,b.city as end_city,a.airport_name as start_airport,b.airport_name as end_airport,start_time,end_time ";
SQL+="from flight,airport as a,airport as b,plane,company ";
if(starttime.equals("")){
    SQL+="where start_ID=a.airport_ID and end_ID=b.airport_ID and flight.plane_ID=plane.plane_ID and flight_state='正常' and plane.company_ID=company.company_ID and a.city='"+startcity+"' and b.city='"+endcity+"'";
}else{
   	SQL+="where start_ID=a.airport_ID and end_ID=b.airport_ID and flight.plane_ID=plane.plane_ID and flight_state='正常' and plane.company_ID=company.company_ID and a.city='"+startcity+"' and b.city='"+endcity+"'and date(start_time)>='"+starttime+"'";
}
	Dbutil util=new Dbutil();
	ResultSet rs_1=null,rs_2=null,rs_3=null;
	ResultSet rs1=util.query(SQL);
	while(rs1.next()){
		Flight flight=new Flight();
		flight.flight_id=rs1.getInt("flight_id");
		flight.start_city=rs1.getString("start_city");
		flight.start_airport=rs1.getString("start_airport");
		flight.end_city=rs1.getString("end_city");
		flight.end_airport=rs1.getString("end_airport");
		flight.A_price=rs1.getDouble("A_price");
		flight.B_price=rs1.getDouble("B_price");
		flight.C_price=rs1.getDouble("C_price");
		flight.company_name=rs1.getString("company_name");
		flight.start_time=rs1.getString("start_time"); 
		flight.end_time=rs1.getString("end_time");
		flight.plane_type=rs1.getString("plane_type");
		if(util.query("select 1 from flight_seat_1 where flight_ID='"+flight.flight_id+"'").next()) SQL2="select count(*) from flight_seat_1 where flight_ID='"+flight.flight_id+"' and seat_state1='正常' and seat_state2='正常' ";
		else SQL2="select count(*) from flight_seat where flight_ID='"+flight.flight_id+"' and seat_state='正常' ";
		System.out.println(SQL2);
    	rs_1=util.query(SQL2);
    	if(rs_1.next()){
    	flight.remain=rs_1.getInt(1);
    	}
    	SQL2="select city,stoptime  from stop,airport where stop.stop_ID=airport.airport_ID and flight_ID='"+flight.flight_id+"' ";
    	rs_1=util.query(SQL2);
    	if(rs_1.next()){flight.stop_airport=rs_1.getString("city");flight.stop_time=rs_1.getInt("stoptime");
%>
<div class="flight"><div><div id="base_bd"><div class="base_main"><div class="searchresult_content"><div class="cabinV2"><div><div><div><div class="search_box search_box_tag search_box_light Label_Flight"><div class="flight_card_content"><div class="search_table_header"><div class="day-lowest"><span>当日最低价</span></div><div class="inb logo"><div class="logo-item flight_logo"><div data-ubt-hover="c_flight_aircraftInfo"><span><span><strong><%=flight.company_name %></strong><span class="flight_ID"><%=flight.flight_id %></span></span></span></div></div><div data-ubt-hover="c_flight_aircraftInfo"><span class="direction_black_border low_text"><%=flight.plane_type %></span><div></div></div></div><div class="inb right"><div class="time_box"><strong class="time"><%=flight.start_time %></strong></div><div class="airport"><%=flight.start_city %>&nbsp&nbsp<%=flight.start_airport %></div></div><div class="inb center"><div class="arrow">经停：<%=flight.stop_airport %>（<%=flight.stop_time %>min)<br>----></div></div><div class="inb left"><div class="time_box"><strong class="time"><%=flight.end_time %></strong><span class="direction_blue_border new_tag" style="display: inline-block; cursor: help;" data-ubt-hover="c_flight_overNight" data-gift-code=""></span></div><div class="airport"><%=flight.end_city %>&nbsp&nbsp<%=flight.end_airport %></div></div><div class="inb service"><div class="service-item">飞行时间<br><div class="clearfix" data-ubt-hover="c_flight_punctualityRate_Flight"><div style="position: relative;"><%=flight.getTime(flight.start_time, flight.end_time) %><div></div></div></div></div></div><div class="inb price child_price lowest_price"><div><span class="base_price02"><dfn>¥</dfn><%=flight.C_price %></span><i>起</i> <br><div class="flight_price_tips"></div></div></div><div class="inb book middle"><button class="btn_book">订票</button><div>余票：<%=flight.remain %></div></div></div></div></div></div></div></div></div></div></div></div></div></div>
<%
}else{
	%>
<div class="flight"><div><div id="base_bd"><div class="base_main"><div class="searchresult_content"><div class="cabinV2"><div><div><div><div class="search_box search_box_tag search_box_light Label_Flight"><div class="flight_card_content"><div class="search_table_header"><div class="day-lowest"><span>当日最低价</span></div><div class="inb logo"><div class="logo-item flight_logo"><div data-ubt-hover="c_flight_aircraftInfo"><span><span><strong><%=flight.company_name %></strong><span class="flight_ID"><%=flight.flight_id %></span></span></span></div></div><div data-ubt-hover="c_flight_aircraftInfo"><span class="direction_black_border low_text"><%=flight.plane_type %></span><div></div></div></div><div class="inb right"><div class="time_box"><strong class="time"><%=flight.start_time %></strong></div><div class="airport"><%=flight.start_city %>&nbsp&nbsp<%=flight.start_airport %></div></div><div class="inb center"><div class="arrow">----></div></div><div class="inb left"><div class="time_box"><strong class="time"><%=flight.end_time %></strong><span class="direction_blue_border new_tag" style="display: inline-block; cursor: help;" data-ubt-hover="c_flight_overNight" data-gift-code=""></span></div><div class="airport"><%=flight.end_city %>&nbsp&nbsp<%=flight.end_airport %></div></div><div class="inb service"><div class="service-item">飞行时间<br><div class="clearfix" data-ubt-hover="c_flight_punctualityRate_Flight"><div style="position: relative;"><%=flight.getTime(flight.start_time, flight.end_time) %><div></div></div></div></div></div><div class="inb price child_price lowest_price"><div><span class="base_price02"><dfn>¥</dfn><%=flight.C_price %></span><i>起</i> <br><div class="flight_price_tips"></div></div></div><div class="inb book middle"><button class="btn_book">订票</button><div>余票：<%=flight.remain %></div></div></div></div></div></div></div></div></div></div></div></div></div></div>
	<%
}
    	}
%>
<label class="layui-form-label">经停方案</label>
<%
SQL=" select flight.flight_ID as flight_id,plane_type,company_name,`stop`.A1_price as A_price,`stop`.B1_price as B_price,`stop`.C1_price as C_price,a.city as start_city,b.city as end_city,a.airport_name as start_airport,b.airport_name as end_airport,start_time,arrivetime as end_time ";
SQL+=" from stop,flight,airport as a,airport as b,company,plane ";
SQL+=" where date(start_time)>='"+starttime+"' and a.city='"+startcity+"' and b.city='"+endcity+"' and flight.start_ID=a.airport_ID and stop.stop_ID=b.airport_ID and stop.flight_ID=flight.flight_ID ";
SQL+=" and flight.plane_ID=plane.plane_ID and flight_state='正常' and plane.company_ID=company.company_ID ";
rs1=util.query(SQL);
while(rs1.next()){
	Flight flight=new Flight();
	flight.flight_id=rs1.getInt("flight_id");
	flight.start_city=rs1.getString("start_city");
	flight.start_airport=rs1.getString("start_airport");
	flight.end_city=rs1.getString("end_city");
	flight.end_airport=rs1.getString("end_airport");
	flight.A_price=rs1.getDouble("A_price");
	flight.B_price=rs1.getDouble("B_price");
	flight.C_price=rs1.getDouble("C_price");
	flight.company_name=rs1.getString("company_name");
	flight.start_time=rs1.getString("start_time"); 
	flight.end_time=rs1.getString("end_time");
	flight.plane_type=rs1.getString("plane_type");
	SQL2="select count(*) from flight_seat_1 where flight_ID='"+flight.flight_id+"' and seat_state1='正常' ";
	rs_1=util.query(SQL2);
	if(rs_1.next()){
	flight.remain=rs_1.getInt(1);
	}
%>
<div class="flight"><div><div id="base_bd"><div class="base_main"><div class="searchresult_content"><div class="cabinV2"><div><div><div><div class="search_box search_box_tag search_box_light Label_Flight"><div class="flight_card_content"><div class="search_table_header"><div class="day-lowest"><span>当日最低价</span></div><div class="inb logo"><div class="logo-item flight_logo"><div data-ubt-hover="c_flight_aircraftInfo"><span><span><strong><%=flight.company_name %></strong><span class="flight_ID"><%=flight.flight_id %></span></span></span></div></div><div data-ubt-hover="c_flight_aircraftInfo"><span class="direction_black_border low_text"><%=flight.plane_type %></span><div></div></div></div><div class="inb right"><div class="time_box"><strong class="time"><%=flight.start_time %></strong></div><div class="airport"><%=flight.start_city %>&nbsp&nbsp<%=flight.start_airport %></div></div><div class="inb center"><div class="arrow">----></div></div><div class="inb left"><div class="time_box"><strong class="time"><%=flight.end_time %></strong><span class="direction_blue_border new_tag" style="display: inline-block; cursor: help;" data-ubt-hover="c_flight_overNight" data-gift-code=""></span></div><div class="airport"><%=flight.end_city %>&nbsp&nbsp<%=flight.end_airport %></div></div><div class="inb service"><div class="service-item">飞行时间<br><div class="clearfix" data-ubt-hover="c_flight_punctualityRate_Flight"><div style="position: relative;"><%=flight.getTime(flight.start_time, flight.end_time) %><div></div></div></div></div></div><div class="inb price child_price lowest_price"><div><span class="base_price02"><dfn>¥</dfn><%=flight.C_price %></span><i>起</i> <br><div class="flight_price_tips"></div></div></div><div class="inb book middle"><button class="btn_book_stop">订票</button><div>余票：<%=flight.remain %></div></div></div></div></div></div></div></div></div></div></div></div></div></div>
<%} %>
<%
SQL=" select flight.flight_ID as flight_id,plane_type,company_name,`stop`.A2_price as A_price,`stop`.B2_price as B_price,`stop`.C2_price as C_price,a.city as start_city,b.city as end_city,a.airport_name as start_airport,b.airport_name as end_airport,arrivetime as start_time,end_time ";
SQL+=" from stop,flight,airport as a,airport as b,company,plane ";
SQL+=" where date(arrivetime)>='"+starttime+"' and a.city='"+startcity+"' and b.city='"+endcity+"' and flight.end_ID=b.airport_ID and `stop`.stop_ID=a.airport_ID and `stop`.flight_ID=flight.flight_ID ";
SQL+=" and flight.plane_ID=plane.plane_ID and flight_state='正常' and plane.company_ID=company.company_ID ";
rs1=util.query(SQL);
while(rs1.next()){
	Flight flight=new Flight();
	flight.flight_id=rs1.getInt("flight_id");
	flight.start_city=rs1.getString("start_city");
	flight.start_airport=rs1.getString("start_airport");
	flight.end_city=rs1.getString("end_city");
	flight.end_airport=rs1.getString("end_airport");
	flight.A_price=rs1.getDouble("A_price");
	flight.B_price=rs1.getDouble("B_price");
	flight.C_price=rs1.getDouble("C_price");
	flight.company_name=rs1.getString("company_name");
	flight.start_time=rs1.getString("start_time"); 
	flight.end_time=rs1.getString("end_time");
	flight.plane_type=rs1.getString("plane_type");
	SQL2="select count(*) from flight_seat_1 where flight_ID='"+flight.flight_id+"' and seat_state2='正常' ";
	rs_1=util.query(SQL2);
	if(rs_1.next()){
	flight.remain=rs_1.getInt(1);
	}
%>
<div class="flight"><div><div id="base_bd"><div class="base_main"><div class="searchresult_content"><div class="cabinV2"><div><div><div><div class="search_box search_box_tag search_box_light Label_Flight"><div class="flight_card_content"><div class="search_table_header"><div class="day-lowest"><span>当日最低价</span></div><div class="inb logo"><div class="logo-item flight_logo"><div data-ubt-hover="c_flight_aircraftInfo"><span><span><strong><%=flight.company_name %></strong><span class="flight_ID"><%=flight.flight_id %></span></span></span></div></div><div data-ubt-hover="c_flight_aircraftInfo"><span class="direction_black_border low_text"><%=flight.plane_type %></span><div></div></div></div><div class="inb right"><div class="time_box"><strong class="time"><%=flight.start_time %></strong></div><div class="airport"><%=flight.start_city %>&nbsp&nbsp<%=flight.start_airport %></div></div><div class="inb center"><div class="arrow">----></div></div><div class="inb left"><div class="time_box"><strong class="time"><%=flight.end_time %></strong><span class="direction_blue_border new_tag" style="display: inline-block; cursor: help;" data-ubt-hover="c_flight_overNight" data-gift-code=""></span></div><div class="airport"><%=flight.end_city %>&nbsp&nbsp<%=flight.end_airport %></div></div><div class="inb service"><div class="service-item">飞行时间<br><div class="clearfix" data-ubt-hover="c_flight_punctualityRate_Flight"><div style="position: relative;"><%=flight.getTime(flight.start_time, flight.end_time) %><div></div></div></div></div></div><div class="inb price child_price lowest_price"><div><span class="base_price02"><dfn>¥</dfn><%=flight.C_price %></span><i>起</i> <br><div class="flight_price_tips"></div></div></div><div class="inb book middle"><button class="btn_book_stop2">订票</button><div>余票：<%=flight.remain %></div></div></div></div></div></div></div></div></div></div></div></div></div></div>
<%} %>

<label class="layui-form-label">换乘方案</label>
<%
String newSQL="";
newSQL+=" select ca.company_name,cb.company_name as company_name1,pa.plane_type,pb.plane_type as plane_type1, aa.city as start_city,aa.airport_name as start_airport,bb.city as end_city,bb.airport_name as end_airport, a.flight_ID,b.flight_ID as flight_ID1,a.C_price,b.C_price as C_price1,a.start_time,a.end_time,b.start_time as start_time1,b.end_time as end_time1 ";
newSQL+=" from flight as a,flight as b,airport as aa,airport as bb,plane as pa,plane as pb,company as ca,company as cb";
newSQL+=" where ca.company_ID=pa.company_ID and cb.company_ID=pb.company_ID and pa.plane_ID=a.plane_ID and pb.plane_ID=b.plane_ID and aa.city='"+startcity+"' and bb.city='"+endcity+"' and aa.airport_ID=a.start_ID and bb.airport_ID=b.end_ID and a.end_ID=b.start_ID and date(a.start_time)>='"+starttime+"' and a.end_time<b.start_time";
ResultSet rs2=util.query(newSQL);
while(rs2.next()){
	Flight one=new Flight(),two=new Flight();
	one.flight_id=rs2.getInt("flight_ID");
	one.start_city=rs2.getString("start_city");
	one.start_airport=rs2.getString("start_airport");
	//one.end_city=rs2.getString("end_city");
	//one.end_airport=rs2.getString("end_airport");
	//one.A_price=rs2.getDouble("A_price");
	//one.B_price=rs2.getDouble("B_price");
	one.C_price=rs2.getDouble("C_price");
	one.company_name=rs2.getString("company_name");
	one.start_time=rs2.getString("start_time"); 
	one.end_time=rs2.getString("end_time");
	one.plane_type=rs2.getString("plane_type");
	SQL3="select count(*) from flight_seat where flight_ID='"+one.flight_id+"' and seat_state='正常' ";
	rs_2=util.query(SQL3);
	if(rs_2.next())one.remain=rs_2.getInt(1);
	
	two.flight_id=rs2.getInt("flight_ID1");
	two.end_airport=rs2.getString("end_airport");
	two.end_city=rs2.getString("end_city");
	//two.end_city=rs2.getString("end_city");
	//two.end_airport=rs2.getString("end_airport");
	//two.A_price=rs2.getDouble("A_price");
	//two.B_price=rs2.getDouble("B_price");
	two.C_price=rs2.getDouble("C_price1");
	two.company_name=rs2.getString("company_name1");
	two.start_time=rs2.getString("start_time1"); 
	two.end_time=rs2.getString("end_time1");
	two.plane_type=rs2.getString("plane_type1");
	SQL3="select count(*) from flight_seat where flight_ID='"+two.flight_id+"' and seat_state='正常' ";
	rs_3=util.query(SQL3);
	if(rs_3.next())two.remain=rs_3.getInt(1);
	
	ResultSet change=util.query("select airport_name,city from airport where airport_ID =(select end_ID from flight where flight_ID='"+one.flight_id+"')");
	while(change.next()){
	one.end_airport=change.getString("airport_name");
	one.end_city=change.getString("city");
	two.start_airport=change.getString("airport_name");
	two.start_city=change.getString("city");}
%>
   <div class="flight"><div><div id="base_bd"><div class="base_main"><div class="searchresult_content"><div class="cabinV2"><div><div><div><div class="search_box search_box_tag search_box_light Label_flight"><div class="flight_card_content"><div class="search_table_header"><div class="day-lowest"><span>当日最低价</span></div><div class="inb logo"><div class="logo-item flight_logo"><div data-ubt-hover="c_flight_aircraftInfo"><span><span><strong><%=one.company_name %></strong><span class="flight_ID"><%=one.flight_id %></span></span></span></div></div><div data-ubt-hover="c_flight_aircraftInfo"><span class="direction_black_border low_text"><%=one.plane_type %></span><div></div></div></div><div class="inb right"><div class="time_box"><strong class="time"><%=one.start_time %></strong></div><div class="airport"><%=one.start_city %>&nbsp&nbsp<%=one.start_airport %></div></div><div class="inb center"><div class="arrow">----></div></div><div class="inb left"><div class="time_box"><strong class="time"><%=one.end_time %></strong><span class="direction_blue_border new_tag" style="display: inline-block; cursor: help;" data-ubt-hover="c_flight_overNight" data-gift-code=""></span></div><div class="airport"><%=one.end_city %>&nbsp&nbsp<%=one.end_airport %></div></div><div class="inb service"><div class="service-item">飞行时间<br><div class="clearfix" data-ubt-hover="c_flight_punctualityRate_flight"><div style="position: relative;"><%=one.getTime(one.start_time, one.end_time) %><div></div></div></div></div></div><div class="inb price child_price lowest_price"><div><span class="base_price02"><dfn>¥</dfn><%=one.C_price %></span><i>起</i> <br><div class="flight_price_tips"></div></div></div><div class="inb book middle"><button class="btn_book">订票</button><div>余票：<%=one.remain %></div></div></div></div></div></div></div></div></div></div></div></div></div></div>
   <div class="flight"><div><div id="base_bd"><div class="base_main"><div class="searchresult_content"><div class="cabinV2"><div><div><div><div class="search_box search_box_tag search_box_light Label_Flight"><div class="flight_card_content"><div class="search_table_header"><div class="day-lowest"><span>当日最低价</span></div><div class="inb logo"><div class="logo-item flight_logo"><div data-ubt-hover="c_flight_aircraftInfo"><span><span><strong><%=two.company_name %></strong><span class="flight_ID"><%=two.flight_id %></span></span></span></div></div><div data-ubt-hover="c_flight_aircraftInfo"><span class="direction_black_border low_text"><%=two.plane_type %></span><div></div></div></div><div class="inb right"><div class="time_box"><strong class="time"><%=two.start_time %></strong></div><div class="airport"><%=two.start_city %>&nbsp&nbsp<%=two.start_airport %></div></div><div class="inb center"><div class="arrow">----></div></div><div class="inb left"><div class="time_box"><strong class="time"><%=two.end_time %></strong><span class="direction_blue_border new_tag" style="display: inline-block; cursor: help;" data-ubt-hover="c_flight_overNight" data-gift-code=""></span></div><div class="airport"><%=two.end_city %>&nbsp&nbsp<%=two.end_airport %></div></div><div class="inb service"><div class="service-item">飞行时间<br><div class="clearfix" data-ubt-hover="c_flight_punctualityRate_Flight"><div style="position: relative;"><%=two.getTime(two.start_time, two.end_time) %><div></div></div></div></div></div><div class="inb price child_price lowest_price"><div><span class="base_price02"><dfn>¥</dfn><%=two.C_price %></span><i>起</i> <br><div class="flight_price_tips"></div></div></div><div class="inb book middle"><button class="btn_book">订票</button><div>余票：<%=two.remain %></div></div></div></div></div></div></div></div></div></div></div></div></div></div>
   
<br><br>
<%
}
util.close();  
%>
