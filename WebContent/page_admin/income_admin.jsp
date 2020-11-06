<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Ticket" %>
<%@ page import="Bean.Flight" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui/css/layui.css"  media="all">    
    <script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>
</head>
<%
String SQL="";
Dbutil util=new Dbutil();
ResultSet rs=null;
SQL=" select date(booktime),sum(price) ";
SQL+=" from ticket ";
SQL+=" where ticket_state='已用' or ticket_state='已订' ";
SQL+=" group by date(booktime) ";
rs=util.query(SQL);
//rs.last();// 移动到最后
//int length=rs.getRow();// 获得结果集长度
//double sum_price[]=new double[length];
//String date[]=new String[length];
//rs.beforeFirst();//移动到第一个元素的前面 
//int i=0;
String sum1="",sum2="",sum3="";
String dates="";
while(rs.next()){
	sum1+=""+rs.getDouble("sum(price)")+" ,";
	//sum_price[i]=rs.getDouble("sum(price)");
	dates+="'"+rs.getString("date(booktime)")+"' ,";
	//date[i]=rs.getString("date(booktime)");
	//i++;
}
SQL=" select date(booktime),sum(price) ";
SQL+=" from ticket ";
SQL+=" where ticket_state='已退' or ticket_state='受限' ";
SQL+=" group by date(booktime) ";
rs=util.query(SQL);
while(rs.next()){
	sum2+=""+rs.getDouble("sum(price)")+" ,";
}
util.close();
%>
<body>
<div>
    <div id="main" style="width: 600px;height:400px;"></div>
</div>
<div>
<table class="layui-table" lay-size='sm' id="booked_tickets" lay-filter="parse-table-demo" lay-data="{id: 'idTest'}" >
  <thead>
    <tr>
    	<th lay-data="{field:'1', width:100,fixed:'left'}">订单编号</th>
      	<th lay-data="{field:'2', width:100,fixed:'left'}">航班号</th>
      	<th lay-data="{field:'3', width:100}">飞行时间</th>
       	<th lay-data="{field:'4', width:100}">乘客姓名</th>
       	<th lay-data="{field:'5', width:100}">机舱号</th>
        <th lay-data="{field:'6', width:100}">座位号</th>
        <th lay-data="{field:'7', width:100}">机票价格</th>
        <th lay-data="{field:'8', width:100}">出发时间</th>
        <th lay-data="{field:'9', width:100}">出发城市</th>
        <th lay-data="{field:'10', width:100}">出发机场</th>
        <th lay-data="{field:'11', width:100}">到达时间</th>
        <th lay-data="{field:'12', width:100}">到达城市</th>
        <th lay-data="{field:'13', width:100}">到达机场</th>
        <th lay-data="{field:'14', width:100}">机票状态</th>
    </tr> 
  </thead>
  <tbody>
<%
SQL="";
SQL+=" select ticket_state,ticket_ID,ticket.flight_ID,ticket.passenger_ID,passenger_name,price,isStop1,isStop2, ";
SQL+=" start_time,end_time,aa.airport_name as start_airport,bb.airport_name as end_airport,aa.city as start_city,bb.city as end_city,cabin_type,seat_location ";
SQL+=" from ticket,passenger,flight,airport as aa,airport as bb,plane_seat ";
SQL+=" where cernum=passenger_ID and ticket.flight_ID=flight.flight_ID "; 
SQL+=" and flight.start_ID=aa.airport_ID and flight.end_ID=bb.airport_ID ";
SQL+=" and flight.plane_ID=plane_seat.plane_ID and ticket.seat_ID=plane_seat.seat_ID ";
rs=util.query(SQL);
while(rs.next()){
	Ticket ticket=new Ticket();
	ticket.ticket_id=rs.getInt("ticket_ID");
	ticket.flight_id=rs.getInt("flight_ID");
	ticket.passenger_name=rs.getString("passenger_name");
	ticket.cabin_type=rs.getString("cabin_type");
	ticket.seat_location=rs.getString("seat_location");
	ticket.price=rs.getDouble("price");
	ticket.ticket_state=rs.getString("ticket_state");
	if(rs.getString("isStop1").equals("1")){
		ticket.start_time=rs.getString("start_time");
		ticket.start_city=rs.getString("start_city");
		ticket.start_airport=rs.getString("start_airport");
		String newSQL="select city,arrivetime,airport_name from stop,airport where flight_ID='"+ticket.flight_id+"' and stop_ID=airport_ID ";
		ResultSet rss=util.query(newSQL);
		if(rss.next()){
		ticket.end_time=rss.getString("arrivetime");
		ticket.end_city=rss.getString("city");
		ticket.end_airport=rss.getString("airport_name");}
	}else if(rs.getString("isStop2").equals("1")){
		String newSQL="select city,arrivetime,airport_name from stop,airport where flight_ID='"+ticket.flight_id+"' and stop_ID=airport_ID ";
		ResultSet rss=util.query(newSQL);
		if(rss.next()){
		ticket.start_time=rss.getString("arrivetime");
		ticket.start_city=rss.getString("city");
		ticket.start_airport=rss.getString("airport_name");}
		ticket.end_time=rs.getString("end_time");
		ticket.end_city=rs.getString("end_city");
		ticket.end_airport=rs.getString("end_airport");
	}else{
	ticket.start_time=rs.getString("start_time");
	ticket.start_city=rs.getString("start_city");
	ticket.start_airport=rs.getString("start_airport");
	ticket.end_time=rs.getString("end_time");
	ticket.end_city=rs.getString("end_city");
	ticket.end_airport=rs.getString("end_airport");
	}
%>
		<tr>
		   	<td><%=ticket.ticket_id %></td>
    		<td><%=ticket.flight_id %></td>
    		<td><%=new Flight().getTime(ticket.start_time,ticket.end_time) %>
    		<td><%=ticket.passenger_name %></td>
    		<td><%=ticket.cabin_type %></td>
    		<td><%=ticket.seat_location %></td>
    		<td><%=ticket.price %></td>
    		<td><%=ticket.start_time %></td>
    		<td><%=ticket.start_city %></td>
    		<td><%=ticket.start_airport %></td>
    		<td><%=ticket.end_time %></td>
    		<td><%=ticket.end_city %></td>
    	    <td><%=ticket.end_airport %></td>
    	    <td><%=ticket.ticket_state %></td>
    	</tr>

<%
}
util.close();
%>
</tbody>
</table>
</div>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        // 指定图表的配置项和数据
        var option = {
        	    title: {
        	        text: '销售额'
        	    },
        	    tooltip: {
        	        trigger: 'axis'
        	    },
        	    legend: {
        	        data: ['已订票','已退票']
        	    },
        	    grid: {
        	        left: '3%',
        	        right: '4%',
        	        bottom: '3%',
        	        containLabel: true
        	    },
        	    toolbox: {
        	        feature: {
        	            saveAsImage: {}
        	        }
        	    },
        	    xAxis: {
        	        type: 'category',
        	        boundaryGap: false,
        	        data: [<%=dates%>]
        	    },
        	    yAxis: {
        	        type: 'value'
        	    },
        	    series: [
        	        {
        	            name: '已订票',
        	            type: 'line',
        	            stack: '总量',
        	            areaStyle: {},
        	            data: [<%=sum1%>]
        	        },
        	        {
        	            name: '已退票',
        	            type: 'line',
        	            stack: '总量',
        	            areaStyle: {},
        	            data: [<%=sum1%>]
        	        }
        	    ]
        	};

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>
    <script src="../layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
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