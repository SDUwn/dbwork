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
response.setContentType("text/html;charset=utf-8");  
request.setCharacterEncoding("utf-8");
String news_ID=request.getParameter("news_ID");
String SQL="select * from news where news_ID='"+news_ID+"' ";
Dbutil util =new Dbutil();
ResultSet rs=null;
rs=util.query(SQL);
if(rs.next()){
%>
<form class="layui-form" action="doEditNews.jsp?news_ID=<%=news_ID %> " method="post">
	<div class="layui-form-item">
	    <label class="layui-form-label">通知标题</label>
	    <div class="layui-input-block">
	      <input name="news_title" class="layui-input" type="text" value="<%=rs.getString("news_title") %>" >
	    </div>
    </div>
    <div class="layui-form-item layui-form-text">
	    <label class="layui-form-label">通知内容</label>
	    <div class="layui-input-block">
	      <textarea name="news_content" class="layui-textarea" ><%=rs.getString("news_content")%></textarea>
	    </div>
    </div>
    <div class="layui-form-item">
	    <div class="layui-input-block">
	      <button class="layui-btn" type="submit">提交</button>
	      <button class="layui-btn layui-btn-primary" type="reset">重置</button>
	      <button type="button" class="layui-btn" onclick="test()">返回</button>
	    </div>
	</div>
</form>
<%}
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