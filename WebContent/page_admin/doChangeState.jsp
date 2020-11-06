<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="Db.Dbutil"%>
<%
String passenger_ID=request.getParameter("passenger_ID");
String state=request.getParameter("state");
System.out.println(passenger_ID+state);
Dbutil util =new Dbutil();
ResultSet rs=null;
String SQL="";
if(state.equals("禁用")){
SQL="update passenger set state='受限' where cernum='"+passenger_ID+"' ";
util.update(SQL);
SQL="update ticket set ticket_state='受限'  where ticket_state='已订' and passenger_ID='"+passenger_ID+"' ";
util.update(SQL);
SQL="select ticket_ID,flight_ID,isStop1,isStop2 from ticket where passenger_ID='"+passenger_ID+"' ";
rs=util.query(SQL);
while(rs.next()){
	if(util.query("select 1 from stop where flight_ID='"+rs.getString("flight_ID")+"'").next()){
		if(rs.getString("isStop1").equals("0")&&rs.getString("isStop2").equals("0")){
			util.update("update flight_seat_1 set seat_state1='正常',seat_state2='正常' where (flight_ID,seat_ID) in(select flight_ID,seat_ID from ticket where ticket_ID='"+rs.getString("ticket_ID")+"' )");
		}else if(rs.getString("isStop1").equals("1")&&rs.getString("isStop2").equals("0")){
			util.update("update flight_seat_1 set seat_state1='正常' where (flight_ID,seat_ID) in(select flight_ID,seat_ID from ticket where ticket_ID='"+rs.getString("ticket_ID")+"' )");
		}else{
			util.update("update flight_seat_1 set seat_state2='正常' where (flight_ID,seat_ID) in(select flight_ID,seat_ID from ticket where ticket_ID='"+rs.getString("ticket_ID")+"' )");
		}
	}else{
		util.update("update flight_seat set seat_state='正常'  where (flight_ID,seat_ID) in(select flight_ID,seat_ID from ticket where ticket_ID='"+rs.getString("ticket_ID")+"' )");
	}
}
}else{
	SQL="update passenger set state='正常' where cernum='"+passenger_ID+"' ";
	util.update(SQL);
	//若恢复正常状态，该人之前定的航班与座位可能已经被其他人订走，所以此人该重新订票
	//SQL="update ticket set ticket_state='normal' where ticket_state='limited' and passenger_ID='"+passenger_ID+"'  ";
	//util.update(SQL);
}
util.close();
%>