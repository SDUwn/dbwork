<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Db.Dbutil" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../../layui/css/layui.css"  media="all">
</head>
<body>
<%
String news_ID=request.getParameter("news_ID");
String SQL="select * from news where news_ID='"+news_ID+"' ";
Dbutil util =new Dbutil();
ResultSet rs=null;
rs=util.query(SQL);
if(rs.next()){
	%>
	<div class="layui-form-item">
	    <label class="layui-form-label">通知标题</label>
	    <div class="layui-input-block">
	      <input name="title" class="layui-input" type="text" placeholder="<%=rs.getString("news_title") %>" readonly="readonly">
	    </div>
    </div>
    <div class="layui-form-item">
	    <label class="layui-form-label">提交时间</label>
	    <div class="layui-input-block">
	      <input name="edit_time" class="layui-input" type="text" placeholder="<%=rs.getString("edit_time") %>" readonly="readonly">
	    </div>
    </div>
    <div class="layui-form-item">
	    <label class="layui-form-label">作者ID</label>
	    <div class="layui-input-block">
	      <input name="admin_ID" class="layui-input" type="text" placeholder="<%=rs.getInt("admin_ID") %>" readonly="readonly">
	    </div>
    </div>
    <div class="layui-form-item layui-form-text">
	    <label class="layui-form-label">通知内容</label>
	    <div class="layui-input-block">
	      <textarea class="layui-textarea" placeholder="<%=rs.getString("news_content")%>" readonly="readonly"></textarea>
	    </div>
    </div>
    <div class="layui-form-item">
	    <div class="layui-input-block">
	      <button class="layui-btn" onclick="test()">返回</button>
	    </div>
    </div>
  <% 
}
util.close();
%>
<script src="../../layui/layui.js" charset="UTF-8"></script>
<script>
layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate;
});
function test(){
	window.location.href="javascript:history.go(-1)";
}
</script>
</body>
</html>