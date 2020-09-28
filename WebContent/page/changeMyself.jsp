<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>修改用户信息</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
  <style type="text/css">body{margin: 2em 0.5em 0.5em 1em;}</style>
</head>
<%
String cert_num=session.getAttribute("cert_num").toString();
String cert_type=session.getAttribute("cert_type").toString();
%>
<body>
<form class="layui-form" action="doChangeMyself.jsp" method="post">
  <div class="layui-form-item">
    <label class="layui-form-label">姓名</label>
    <div class="layui-input-inline">
      <input name="pass_name" class="layui-input" type="text" placeholder="请输入姓名" autocomplete="off" required="required">
    </div>
  </div>
   <div class="layui-form-item" pane="">
    <label class="layui-form-label">性别</label>
    <div class="layui-input-block">
      <input name="sex" title="男" type="radio" checked="" value="male">
      <input name="sex" title="女" type="radio" value="female">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">年龄</label>
    <div class="layui-input-inline">
      <input name="age" class="layui-input" type="number" placeholder="请输入年龄" autocomplete="off">
    </div>
  </div>
  <%if(cert_num.equals("null")){%>
   <div class="layui-form-item">
    <label class="layui-form-label">证件类型</label>
    <div class="layui-input-inline">
      <select name="cert_type">
        <option value="IDcard">中国大陆居民身份证</option>
        <option value="passport">护照</option>
      </select>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">证件号码</label>
    <div class="layui-input-inline">
      <input name="cert_num" class="layui-input" type="text" placeholder="请输入证件号"  required="required">
    </div>
  </div>
  <%}else {%>
	  <div class="layui-form-item">
    <label class="layui-form-label">证件类型</label>
    <div class="layui-input-inline">
      <input name="cert_num" class="layui-input" type="text" placeholder="<%=cert_type %>"  disabled="disabled">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">证件号码</label>
    <div class="layui-input-inline">
      <input name="cert_num" class="layui-input" type="text" placeholder="<%=cert_num %>"  disabled="disabled">
    </div>
  </div>
  <%}%>
  
  <div class="layui-form-item">
    <label class="layui-form-label">手机号码</label>
    <div class="layui-input-inline">
      <input name="telephone" class="layui-input" type="tel" placeholder="请输入电话号码">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">邮箱</label>
    <div class="layui-input-inline">
      <input name="mail" class="layui-input" type="email" placeholder="请输入邮箱">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">地址</label>
    <div class="layui-input-inline">
      <input name="address" class="layui-input" type="text" placeholder="请输入地址">
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" type="submit">提交</button>
      <button class="layui-btn layui-btn-primary" type="reset">重置</button>
    </div>
  </div>
</form>
</body>

<script src="../layui/layui.js" charset="UTF-8"></script>
<script>
layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate;
});
</script>
</html>