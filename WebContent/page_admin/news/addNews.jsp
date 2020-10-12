<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<br>
<form class="layui-form" action="doAddNews.jsp" method="post">
  <div class="layui-form-item">
    <label class="layui-form-label">通知标题</label>
    <div class="layui-input-block">
      <input name="news_title" class="layui-input" type="text" placeholder="请输入标题"  required="required">
    </div>
  </div>
  
   <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">通知内容</label>
    <div class="layui-input-block">
      <textarea name="news_content" class="layui-textarea" placeholder="请输入内容" required="required"></textarea>
    </div>
  </div>
  <div class="layui-form-item">
	    <div class="layui-input-block">
	      <button class="layui-btn" type="submit">提交</button>
	      <button class="layui-btn layui-btn-primary" type="reset">重置</button>
	    </div>
	  </div>
  </form>
  <script src="../../layui/layui.js" charset="UTF-8"></script>
</body>
</html>