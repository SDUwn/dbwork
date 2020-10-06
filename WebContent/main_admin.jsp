<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
img{background:#fff;border-color:#aaa #ccc #ddd #bbb;border-style:solid;border-width:1px;color:inherit;padding:2px;vertical-align:top;width:600px;height:280px;}
</style>
</head>
<body>

<blockquote class="layui-elem-quote">
  <a href="page_admin/manageNews.jsp">管理新闻</a>
</blockquote>

<div class="layui-carousel" id="test1" lay-filter="test1">
  <div carousel-item="">
    <div><img src="D:\OneDrive\大数据 大三\数据库课设\plane1.png" alt="description"/></div>
    <div><img src="D:\OneDrive\大数据 大三\数据库课设\plane2.jpg" alt="description"/></div>
    <div><img src="D:\OneDrive\大数据 大三\数据库课设\plane3.png" alt="description"/></div>
    <div><img src="D:\OneDrive\大数据 大三\数据库课设\plane4.jpg" alt="description"/></div>
    <div><img src="D:\OneDrive\大数据 大三\数据库课设\plane5.jpg" alt="description"/></div>
  </div>
</div> 
<script src="layui/layui.js" charset="utf-8"></script>
<script>
layui.use(['carousel', 'form'], function(){
  var carousel = layui.carousel
  ,form = layui.form;
  
  carousel.render({
    elem: '#test1'
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