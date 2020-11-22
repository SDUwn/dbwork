<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Flight" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>航班查询</title>
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
<style>
body {
	font-size: 12px;
	line-height: 1.5;
	font-family: Arial,"Hiragino Sans GB",宋体,sans-serif;
	color: #333;
}

.base_main {
	width: 945px;
	margin-right: 0px;
	float: right;
}
.version3 .base_main {
	width: 945px;
	margin-right: 0px;
	float: right;
}
/* @media screen and (max-width:1250px) */
.version3 .base_main {
	width: 980px;
	margin: 0;
}
#base_bd {
	zoom: 1;
	width: 1180px;
	margin: 0 auto;
	padding: 0;
	position: relative;
}
/* @media screen and (max-width:1250px) */
#base_bd {
	width: 980px;
	overflow: hidden;
}
.flight_card_content {
	border-bottom: 1px solid #eaeaea;
}
.search_table_header {
	width: auto;
	background-color: #fff;
	position: relative;
}
.search_box .day-lowest {
	position: absolute;
	top: 0px;
	left: 0px;
	font-size: 12px;
	background: rgba(38,194,142,0.1);
	color: #00a876;
	padding: 2px 20px 2px 10px;
	border-bottom-right-radius: 18px 36px;
	background: -o-linear-gradient(150deg, transparent 12px, rgba(38,194,142,0.1) 0) bottom right;
	background: linear-gradient(-60deg, transparent 12px, rgba(38,194,142,0.1) 0) bottom right;
}
.right {
	text-align: right;
}
.center {
	text-align: center;
}
.left {
	text-align: left;
}
.middle {
	vertical-align: middle;
}
.inb {
	display: inline-block;
}
.search_table_header .inb {
	padding: 28px 5px 24px;
	vertical-align: top;
}
.search_table_header .logo {
	width: 168px;
	padding-right: 0px;
	white-space: nowrap;
}
.search_table_header .right {
	padding-left: 0px;
	width: 126px;
}
/* @media screen and (max-width:1250px) */
.search_box_light .search_table_header .right {
	width: 156px;
}
.search_table_header .center {
	position: relative;
	width: 86px;
	height: 45px;
	text-align: center;
}
.search_table_header .left {
	width: 130px;
	padding-right: 0px;
}
/* @media screen and (max-width:1250px) */
.search_box_light .search_table_header .left {
	width: 150px;
}
.search_box .search_table_header .service {
	width: 40px;
	padding-left: 0px;
	text-align: center;
	padding-right: 15px;
}
.search_box .search_table_header .label {
	width: 128px;
	text-align: right;
	vertical-align: middle;
	padding-left: 0px;
	padding-right: 0px;
}
.search_table_header .price {
	padding-right: 0px;
	width: 90px;
	text-align: right;
}
.search_box .search_table_header .price {
	width: 114px;
	vertical-align: middle;
	padding-left: 0px;
	padding-right: 0px;
}
.search_table_header .price.child_price, .search_transfer_header .price.child_price {
	position: relative;
	padding-top: 20px;
	vertical-align: top;
}
.search_table_header .middle {
	vertical-align: middle;
}
.search_box .search_table_header .book {
	width: 65px;
	padding-left: 15px;
	padding-right: 0px;
}
.btn_book .btn_book_stop .btn_book_stop2{
	width: 44px;
	padding: 2px 0;
	line-height: 14px;
	border: 1px solid #E77C00;
	border-radius: 3px;
	-webkit-box-shadow: 0 1px 0 #8F6F4C;
	box-shadow: 0px 1px 0px #8f6f4c;
	color: green;
	font-weight: bold;
	background-color: #ffb000;
	-webkit-appearance: none;
	-moz-appearance: none;
	-ms-appearance: none;
	cursor: pointer;
	outline: none;
}
.search_box .btn_book, .search_box_vip .btn_book, .search_box .btn_disable, .search_box .alternates, .benefit_flt .btn_book, .benefit_flt .btn_disable, .near_flt .btn_book {
	display: inline-block;
	line-height: 16px;
	font-size: 14px;
	width: 65px;
	padding: 5px 0 4px;
	text-align: center;
	-webkit-box-shadow: none;
	box-shadow: none;
}
.search_box .btn_book_stop, .search_box_vip .btn_book_stop, .search_box .btn_disable, .search_box .alternates, .benefit_flt .btn_book_stop, .benefit_flt .btn_disable, .near_flt .btn_book_stop {
	display: inline-block;
	line-height: 16px;
	font-size: 14px;
	width: 65px;
	padding: 5px 0 4px;
	text-align: center;
	-webkit-box-shadow: none;
	box-shadow: none;
}
.search_box .btn_book_stop2, .search_box_vip .btn_book_stop2, .search_box .btn_disable, .search_box .alternates, .benefit_flt .btn_book_stop2, .benefit_flt .btn_disable, .near_flt .btn_book_stop2 {
	display: inline-block;
	line-height: 16px;
	font-size: 14px;
	width: 65px;
	padding: 5px 0 4px;
	text-align: center;
	-webkit-box-shadow: none;
	box-shadow: none;
}
.search_box .btn_book, .search_box_vip .btn_book {
	border-color: #ff9913;
}
.search_box .btn_book_stop, .search_box_vip .btn_book_stop {
	border-color: #ff9913;
}
.search_box .btn_book_stop2, .search_box_vip .btn_book_stop2 {
	border-color: #ff9913;
}
.search_table_header .btn_book {
	width: 65px;
	margin-top: 2px;
}
.search_table_header .btn_book_stop {
	width: 65px;
	margin-top: 2px;
}
.search_table_header .btn_book_stop2 {
	width: 65px;
	margin-top: 2px;
}
.cabinV2 .btn_book {
	border-radius: 4px;
	background: -o-linear-gradient(right, #FCAD00 0%, #FF7528 100%);
	background: -webkit-gradient(linear, left top, right top, from(#FCAD00), to(#FF7528));
	background: -o-linear-gradient(left, #FCAD00, #FF7528);
	background: linear-gradient(to right, #FCAD00, #FF7528);
}
.cabinV2 .btn_book > b {
	background-color: transparent;
	border-left: 5px solid transparent !important;
	border-right: 5px solid transparent !important;
}
.cabinV2 .btn_book_stop {
	border-radius: 4px;
	background: -o-linear-gradient(right, #FCAD00 0%, #FF7528 100%);
	background: -webkit-gradient(linear, left top, right top, from(#FCAD00), to(#FF7528));
	background: -o-linear-gradient(left, #FCAD00, #FF7528);
	background: linear-gradient(to right, #FCAD00, #FF7528);
}
.cabinV2 .btn_book_stop2 {
	border-radius: 4px;
	background: -o-linear-gradient(right, #FCAD00 0%, #FF7528 100%);
	background: -webkit-gradient(linear, left top, right top, from(#FCAD00), to(#FF7528));
	background: -o-linear-gradient(left, #FCAD00, #FF7528);
	background: linear-gradient(to right, #FCAD00, #FF7528);
}
.cabinV2 .btn_book_stop > b {
	background-color: transparent;
	border-left: 5px solid transparent !important;
	border-right: 5px solid transparent !important;
}
.cabinV2 .btn_book_stop2 > b {
	background-color: transparent;
	border-left: 5px solid transparent !important;
	border-right: 5px solid transparent !important;
}
.search_table_header .btn_book.arrow_down b {
	border-left: 5px solid #FFB000;
	border-right: 5px solid #FFB000;
	border-bottom: 0 none transparent;
	border-top: 5px solid #fff;
}
.base_price02 {
	font-size: 17px;
	color: #ff6600;
	line-height: 100%;
}
.base_price02 {
	font-family: tahoma;
}
.lowest_price .base_price02 {
	color: #bb0000;
}
.search_table_header .base_price02 {
	font-size: 30px;
}
.search_table_header .price.child_price .base_price02, .search_transfer_header .price.child_price .base_price02 {
	font-size: 22px;
}
em, i {
	font-style: normal;
}
.search_table_header .price i {
	font-style: normal;
	vertical-align: bottom;
	*vertical-align:3px: ;
}
.flight_price_tips {
	position: absolute;
	right: 0px;
}
.flight_price_tips div {
	line-height: 16px;
	color: #999;
	white-space: nowrap;
}
dfn {
	font-style: normal;
	font-family: Arial;
}
.base_price02 dfn {
	font-size: 12px;
	color: #333;
	font-family: Arial,Simsun;
	vertical-align: top;
	*vertical-align:3px: ;
	margin-right: 2px;
}
.lowest_price .base_price02 dfn {
	color: #bb0000;
}
.search_table_header .base_price02 dfn {
	line-height: 22px;
	*vertical-align:12px: ;
}
.search_table_header .service .service-item {
	display: inline-block;
	*display:inline: ;
	*zoom:1: ;
	color: #999;
	text-align: center;
	white-space: nowrap;
}
.search_box .search_table_header .service > div {
	display: inline-block;
	*display:inline: ;
	*zoom:1: ;
}
.clearfix {
	*zoom:1: ;
}
.search_table_header .time_box {
	position: relative;
}
.search_box .search_table_header .time_box {
	position: relative;
}
.search_table_header .time {
	font-size: 17px;
	line-height: 20px;
	font-family: Tahoma,Arial,sans-serif;
}

</style>
</head>

<%
response.setContentType("text/html;charset=utf-8");  
request.setCharacterEncoding("utf-8");
String ID=session.getAttribute("ID").toString();
String cert_num="null";
Dbutil util=new Dbutil();
String SQL="",SQL1="";
SQL="select cernum from passenger where user_ID='"+ID+"'";
ResultSet rs=null,rs1=null;
rs=util.query(SQL);
if(rs.next())
	cert_num=rs.getString("cernum");
session.setAttribute("cert_num", cert_num);
System.out.println(cert_num);
%>

<body>
<script type="text/javascript" src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<div class="layui-form-item">
    <label class="layui-form-label">出发城市</label>
    <div class="layui-input-inline">
      <input id="sc" name="startcity" class="layui-input" type="text" placeholder="请输入城市名" autocomplete="off" required="required">
    </div>
    <label class="layui-form-label">到达城市</label>
    <div class="layui-input-inline">
      <input id="ec" name="endcity" class="layui-input" type="text" placeholder="请输入城市名" autocomplete="off" required="required">
    </div>
</div>
<div class="layui-form-item">
    <label class="layui-form-label">出发日期</label>
    <div class="layui-input-inline">
      <input id="st" name="starttime" class="layui-input" type="date" placeholder="请选择时间" autocomplete="off" required="required">
    </div>
    &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp<input type="button" class="layui-btn" value="查询" onclick="search()">
</div>
<div id="div1">
    <%
    SQL="SELECT flight_ID,plane_type,company_name,A_price,B_price,C_price,a.city as start_city,b.city as end_city,a.airport_name as start_airport,b.airport_name as end_airport,start_time,end_time from flight,airport as a,airport as b,plane,company where start_ID=a.airport_ID and end_ID=b.airport_ID and flight.plane_ID=plane.plane_ID and flight_state='正常' and plane.company_ID=company.company_ID ";
    rs=util.query(SQL);
    while(rs.next()){
    	Flight flight=new Flight();
    	flight.flight_id=rs.getInt("flight_id");
    	flight.start_city=rs.getString("start_city");
    	flight.start_airport=rs.getString("start_airport");
    	flight.end_city=rs.getString("end_city");
    	flight.end_airport=rs.getString("end_airport");
    	flight.A_price=rs.getDouble("A_price");
    	flight.B_price=rs.getDouble("B_price");
    	flight.C_price=rs.getDouble("C_price");
    	flight.company_name=rs.getString("company_name");
    	flight.start_time=rs.getString("start_time"); 
    	flight.end_time=rs.getString("end_time");
    	flight.plane_type=rs.getString("plane_type");
    	if(util.query("select 1 from flight_seat_1 where flight_ID='"+flight.flight_id+"'").next()) SQL1="select count(*) from flight_seat_1 where flight_ID='"+flight.flight_id+"' and seat_state1='正常' and seat_state2='正常' ";
		else SQL1="select count(*) from flight_seat where flight_ID='"+flight.flight_id+"' and seat_state='正常' ";
		rs1=util.query(SQL1);
    	if(rs1.next())flight.remain=rs1.getInt(1);
    	SQL1="select city,stoptime  from stop,airport where stop.stop_ID=airport.airport_ID and flight_ID='"+flight.flight_id+"' ";
    	rs1=util.query(SQL1);
    	if(rs1.next()){flight.stop_airport=rs1.getString("city");flight.stop_time=rs1.getInt("stoptime");
    %>
    	<div class="flight"><div><div id="base_bd"><div class="base_main"><div class="searchresult_content"><div class="cabinV2"><div><div><div><div class="search_box search_box_tag search_box_light Label_Flight"><div class="flight_card_content"><div class="search_table_header"><div class="day-lowest"><span>当日最低价</span></div><div class="inb logo"><div class="logo-item flight_logo"><div data-ubt-hover="c_flight_aircraftInfo"><span><span><strong><%=flight.company_name %></strong><span class="flight_ID"><%=flight.flight_id %></span></span></span></div></div><div data-ubt-hover="c_flight_aircraftInfo"><span class="direction_black_border low_text"><%=flight.plane_type %></span><div></div></div></div><div class="inb right"><div class="time_box"><strong class="time"><%=flight.start_time %></strong></div><div class="airport"><%=flight.start_city %>&nbsp&nbsp<%=flight.start_airport %></div></div><div class="inb center"><div class="arrow">经停：<%=flight.stop_airport %>（<%=flight.stop_time %>min)<br>----></div></div><div class="inb left"><div class="time_box"><strong class="time"><%=flight.end_time %></strong><span class="direction_blue_border new_tag" style="display: inline-block; cursor: help;" data-ubt-hover="c_flight_overNight" data-gift-code=""></span></div><div class="airport"><%=flight.end_city %>&nbsp&nbsp<%=flight.end_airport %></div></div><div class="inb service"><div class="service-item">飞行时间<br><div class="clearfix" data-ubt-hover="c_flight_punctualityRate_Flight"><div style="position: relative;"><%=flight.getTime(flight.start_time, flight.end_time) %><div></div></div></div></div></div><div class="inb price child_price lowest_price"><div><span class="base_price02"><dfn>¥</dfn><%=flight.C_price %></span><i>起</i> <br><div class="flight_price_tips"></div></div></div><div class="inb book middle"><button class="btn_book">订票</button><div>余票：<%=flight.remain %></div></div></div></div></div></div></div></div></div></div></div></div></div></div>
    	
    <%
    }else{
    	%>
    	<div class="flight"><div><div id="base_bd"><div class="base_main"><div class="searchresult_content"><div class="cabinV2"><div><div><div><div class="search_box search_box_tag search_box_light Label_Flight"><div class="flight_card_content"><div class="search_table_header"><div class="day-lowest"><span>当日最低价</span></div><div class="inb logo"><div class="logo-item flight_logo"><div data-ubt-hover="c_flight_aircraftInfo"><span><span><strong><%=flight.company_name %></strong><span class="flight_ID"><%=flight.flight_id %></span></span></span></div></div><div data-ubt-hover="c_flight_aircraftInfo"><span class="direction_black_border low_text"><%=flight.plane_type %></span><div></div></div></div><div class="inb right"><div class="time_box"><strong class="time"><%=flight.start_time %></strong></div><div class="airport"><%=flight.start_city %>&nbsp&nbsp<%=flight.start_airport %></div></div><div class="inb center"><div class="arrow">----></div></div><div class="inb left"><div class="time_box"><strong class="time"><%=flight.end_time %></strong><span class="direction_blue_border new_tag" style="display: inline-block; cursor: help;" data-ubt-hover="c_flight_overNight" data-gift-code=""></span></div><div class="airport"><%=flight.end_city %>&nbsp&nbsp<%=flight.end_airport %></div></div><div class="inb service"><div class="service-item">飞行时间<br><div class="clearfix" data-ubt-hover="c_flight_punctualityRate_Flight"><div style="position: relative;"><%=flight.getTime(flight.start_time, flight.end_time) %><div></div></div></div></div></div><div class="inb price child_price lowest_price"><div><span class="base_price02"><dfn>¥</dfn><%=flight.C_price %></span><i>起</i> <br><div class="flight_price_tips"></div></div></div><div class="inb book middle"><button class="btn_book">订票</button><div>余票：<%=flight.remain %></div></div></div></div></div></div></div></div></div></div></div></div></div></div>
    	<% 
    }
    }
    util.close();
    %>
</div>
<script src="../layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript">
	    
var XMLHttpReq; 
var startcity,endcity,startcity;
var flightID;
var content_html;
var type;
if(<%=cert_num%>==null){
	content_html='<div style="padding: 20px 100px;">请先去完善乘客信息！</div>';
	type=1;
}else{
	content_html='..//page//generateTicket.jsp';
	type=2;
}
$(function() {
	$("#div1").on("click", ".btn_book", function(event) {
		flightID=$(this).parent().prev().prev().prev().prev().prev().prev().find(".flight_ID").text();
		if(<%=cert_num%>==null){
			makelayer1();
		}else{
			makelayer(flightID,0,0);
		}
	});
});
$(function() {
	$("#div1").on("click", ".btn_book_stop", function(event) {
		flightID=$(this).parent().prev().prev().prev().prev().prev().prev().find(".flight_ID").text();
		if(<%=cert_num%>==null){
			makelayer1();
		}else{
			makelayer(flightID,1,0);
		}
	});
});
$(function() {
	$("#div1").on("click", ".btn_book_stop2", function(event) {
		flightID=$(this).parent().prev().prev().prev().prev().prev().prev().find(".flight_ID").text();
		if(<%=cert_num%>==null){
			makelayer1();
		}else{
			makelayer(flightID,0,1);
		}
	});
});
var layer;
function makelayer(flightID,stop1,stop2){
	window.location.href="generateTicket.jsp?flight_ID="+flightID+"&stop1="+stop1+"&stop2="+stop2+" ";
}
function makelayer1(){
	alert("暂无乘客信息，请先去完善！");
	window.location.href="changeMyself.jsp";
}
function createXMLHttpRequest() {  
    if(window.XMLHttpRequest) { //Mozilla 浏览器  
        XMLHttpReq = new XMLHttpRequest();  
    }  
    else if (window.ActiveXObject) { // IE浏览器  
        try {  
            XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");  
        } catch (e) {  
            try {  
                XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");  
            } catch (e) {}  
        }  
    }  
}  
 
// 处理返回信息函数  
function processResponse() {  
    if (XMLHttpReq.readyState == 4) { // 判断对象状态  
        if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息  
            document.getElementById("div1").innerHTML=XMLHttpReq.responseText;
        } else { 
            window.alert("您所请求的页面有异常。");  
        }  
    }  
}  

function search(){
	$("#div1").empty();
	 startcity=$("#sc").val();
	 endcity=$("#ec").val();
	 starttime=$("#st").val();
	 createXMLHttpRequest();  
	    var url = "search.jsp?startcity="+startcity+"&endcity="+endcity+"&starttime="+starttime+"";  
	    XMLHttpReq.open("GET", url, true);  
	    XMLHttpReq.onreadystatechange = processResponse;//指定响应函数  
	    XMLHttpReq.send(null);
}
</script>
</body>
</html>