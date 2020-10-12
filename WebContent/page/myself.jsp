<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="Bean.Passenger" %>
<%@ page import="Db.Dbutil" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>个人信息</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
</head>
<body>
<%
Dbutil util=new Dbutil();
String SQL="";
ResultSet rs=null;
%>
<%
		Passenger passenger=new Passenger();
		//int ID=Integer.parseInt(request.getSession().getAttribute("ID").toString());
		int ID=Integer.parseInt(session.getAttribute("ID").toString());
		SQL="select * from passenger where user_ID='"+ID+"' and is_main='Y' ";
		rs=util.query(SQL);
		if(rs.next()){
			passenger.pass_name=rs.getString("Passenger_name");
			passenger.sex=rs.getString("sex");
			passenger.age=rs.getInt("age");
			passenger.cert_type=rs.getString("certype");
			passenger.cert_num=rs.getString("cernum");
			passenger.telephone=rs.getString("phone");
			passenger.mail=rs.getString("mail");
			passenger.address=rs.getString("address");
			passenger.state=rs.getString("state");
			session.setAttribute("cert_num", passenger.cert_num);
			session.setAttribute("cert_type",passenger.cert_type);
		}else{
			passenger.pass_name="暂无";
			passenger.sex="暂无";
			passenger.age=0;
			passenger.cert_type="暂无";
			passenger.cert_num="暂无";
			passenger.telephone="暂无";
			passenger.mail="暂无";
			passenger.address="暂无";
			passenger.state="暂无";
			session.setAttribute("cert_num", "null");
			session.setAttribute("cert_type", "null");
			out.println("暂无乘客信息，请前去维护！");
		}
%>
<%
util.close();
%>
		<form class='layui-form' action=''>
			<div class='layui-form-item'>
				<label class='layui-form-label'>姓名</label>
				<div class='layui-input-inline'>
					<input name='Pass_name' class='layui-input' type='text' placeholder='<%=passenger.pass_name%>' disabled='disabled'>
				</div>
			</div>
			<div class='layui-form-item'>
			    <label class='layui-form-label'>性别</label>
			    <div class='layui-input-inline'>
			      <input name='pass_name' class='layui-input' type='text' placeholder='<%=passenger.sex %>' disabled='disabled'>
			    </div>
			  </div>
			   <div class='layui-form-item'>
			    <label class='layui-form-label'>年龄</label>
			    <div class='layui-input-inline'>
			      <input name='pass_name' class='layui-input' type='text' placeholder='<%=passenger.age %>' disabled='disabled'>
			    </div>
			  </div>
			  <div class='layui-form-item'>
			    <label class='layui-form-label'>证件类型</label>
			    <div class='layui-input-inline'>
			      <input name='pass_name' class='layui-input' type='text' placeholder='<%=passenger.cert_type %>' disabled='disabled'>
			    </div>
			  </div>
			  <div class='layui-form-item'>
			    <label class='layui-form-label'>证件号码</label>
			    <div class='layui-input-inline'>
			      <input name='cert_num' class='layui-input' type='text' placeholder='<%=passenger.cert_num %>'  disabled='disabled'>
			    </div>
			  </div>
			  <div class='layui-form-item'>
			    <label class='layui-form-label'>手机号码</label>
			    <div class='layui-input-inline'>
			      <input name='telephone' class='layui-input' type='tel' placeholder='<%=passenger.telephone %>' disabled='disabled'>
			    </div>
			  </div>
			  <div class='layui-form-item'>
			    <label class='layui-form-label'>邮箱</label>
			    <div class='layui-input-inline'>
			      <input name='mail' class='layui-input' type='email' placeholder='<%=passenger.mail %>' disabled='disabled'>
			    </div>
			  </div>
			  <div class='layui-form-item'>
			    <label class='layui-form-label'>地址</label>
			    <div class='layui-input-inline'>
			      <input name='address' class='layui-input' type='text' placeholder='<%=passenger.address %>' disabled='disabled'>
			    </div>
			  </div>
			  <div class='layui-form-item'>
			    <label class='layui-form-label'>状态</label>
			    <div class='layui-input-inline'>
			      <input name='address' class='layui-input' type='text' placeholder='<%=passenger.state %>' disabled='disabled'>
			    </div>
			  </div>
		</form>
</body>

</html>