<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Db.Dbutil" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="layui/css/layui.css"  media="all">
  <style type="text/css">
 body{margin: 10px;}
    .demo{height: 150px; line-height: 150px; text-align: center;}
    .demo1 { word-wrap:break-word;height: 200px; line-height:50px; }
  </style>
</head>
<body>
<div class="layui-carousel" id="test1" lay-filter="test1">
  <div carousel-item="">
<%
response.setContentType("text/html;charset=utf-8");  
request.setCharacterEncoding("utf-8");
Dbutil util=new Dbutil();
ResultSet rs=null;
String SQL="select * from news order by edit_time desc limit 5 ";
rs=util.query(SQL);
while(rs.next()){
%>
 <div>
	<h2 class="layui-bg-green demo" ><%=rs.getString("news_title")%></h2>
	<p class="demo-carousel demo1" style="{word-wrap:break-word;}"><%=rs.getString("news_content") %></p>  
  </div>
<%
}
util.close();
%>
  </div>
</div> 
<script src="layui/layui.js" charset="utf-8"></script>
<script>
layui.use(['carousel', 'form'], function(){
  var carousel = layui.carousel
  ,form = layui.form;
  
  carousel.render({
    elem: '#test1'
    ,width:'100%'
    ,height:'500px'
    ,arrow: 'always'
  });
  var $ = layui.$, active = {
		    set: function(othis){
		      var THIS = 'layui-bg-normal'
		      ,key = othis.data('key')
		      ,options = {};
		      
		      othis.css('background-color', '#5FB878').siblings().removeAttr('style'); 
		      options[key] = othis.data('value');
		      ins3.reload(options);
		    }
		  };
});
</script>

</body>
</html>