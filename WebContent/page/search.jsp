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
    String SQL="";
    String startcity=request.getParameter("startcity");
	String endcity=request.getParameter("endcity");
	String starttime=request.getParameter("starttime");
%>
<table class="layui-table">
  <thead>
    <tr>
      	<th>航班号</th>
      	<th>飞行时间</th>
       	<th>出发城市</th>
       	<th>出发机场</th>
        <th>出发时间</th>
        <th>到达城市</th>
        <th>到达机场</th>
        <th>到达时间</th>
        <th>航空公司</th>
        <th>票价起步</th>
        <th>飞机机型</th>
        <th>订票</th>
    </tr> 
  </thead>
  <tbody>
<% 
SQL="SELECT flight_ID,plane_type,company_name,A_price,B_price,C_price,a.city as start_city,b.city as end_city,a.airport_name as start_airport,b.airport_name as end_airport,start_time,end_time ";
SQL+="from flight,airport as a,airport as b,plane,company ";
if(starttime.equals("")){
    SQL+="where start_ID=a.airport_ID and end_ID=b.airport_ID and flight.plane_ID=plane.plane_ID and flight_state='正常' and plane.company_ID=company.company_ID and a.city='"+startcity+"' and b.city='"+endcity+"'";
	System.out.println(SQL);
}else{
   	SQL+="where start_ID=a.airport_ID and end_ID=b.airport_ID and flight.plane_ID=plane.plane_ID and flight_state='正常' and plane.company_ID=company.company_ID and a.city='"+startcity+"' and b.city='"+endcity+"'and date(start_time)>='"+starttime+"'";
	System.out.println(SQL);
}
	Dbutil util=new Dbutil();
	ResultSet rs1=util.query(SQL);
	//if(rs1.isBeforeFirst()){
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
%>
		<tr>
    		<td><%=flight.flight_id %></td>
    		<td><%=flight.getTime(flight.start_time,flight.end_time) %></td>
    		<td><%=flight.start_city %></td>
    		<td><%=flight.start_airport %></td>
    		<td><%=flight.start_time %></td>
    		<td><%=flight.end_city %></td>
    		<td><%=flight.end_airport %></td>
    		<td><%=flight.end_time %></td>
    		<td><%=flight.company_name %></td>
    		<td><%=flight.C_price %></td>
    		<td><%=flight.plane_type %></td>
    		<td><input type="button" class="layui-btn" name="book" value="预定"></td>
    	</tr>
<%}%>
	</tbody>
</table>
<label class="layui-form-label">换乘方案</label>
<table class="layui-table">
  <thead>
    <tr>
      	<th>航班号</th>
       	<th>出发城市</th>
       	<th>出发机场</th>
        <th>出发时间</th>
        <th>到达城市</th>
        <th>到达机场</th>
        <th>到达时间</th>
        <th>航空公司</th>
        <th>票价起步</th>
        <th>飞机机型</th>
        <th>订票</th>
    </tr> 
  </thead>
  <tbody>
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
	
	ResultSet change=util.query("select airport_name,city from airport where airport_ID =(select end_ID from flight where flight_ID='"+one.flight_id+"')");
	while(change.next()){
	one.end_airport=change.getString("airport_name");
	one.end_city=change.getString("city");
	two.start_airport=change.getString("airport_name");
	two.start_city=change.getString("city");}
%>
<tr>
    		<td><%=one.flight_id %></td>
    		<td><%=one.start_city %></td>
    		<td><%=one.start_airport %></td>
    		<td><%=one.start_time %></td>
    		<td><%=one.end_city %></td>
    		<td><%=one.end_airport %></td>
    		<td><%=one.end_time %></td>
    		<td><%=one.company_name %></td>
    		<td><%=one.C_price %></td>
    		<td><%=one.plane_type %></td>
    		<td><input type="button" class="layui-btn" name="book" value="预定"></td>
</tr>
<tr>
    		<td><%=two.flight_id %></td>
    		<td><%=two.start_city %></td>
    		<td><%=two.start_airport %></td>
    		<td><%=two.start_time %></td>
    		<td><%=two.end_city %></td>
    		<td><%=two.end_airport %></td>
    		<td><%=two.end_time %></td>
    		<td><%=two.company_name %></td>
    		<td><%=two.C_price %></td>
    		<td><%=two.plane_type %></td>
    		<td><input type="button" class="layui-btn" name="book" value="预定"></td>
</tr>
<tr></tr><tr></tr>
<%
}
%>
</tbody>
</table>
<%
util.close();  
%>
