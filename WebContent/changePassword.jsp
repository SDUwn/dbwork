<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>修改密码</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="layui/css/layui.css"  media="all">
  <style type="text/css">body{margin: 10em 5em 5em 30em;}</style>
</head>
<body>
<form class='layui-form' action='doChangePwd.jsp' method="post">
			<div class='layui-form-item'>
				<label class='layui-form-label'>原密码</label>
				<div class='layui-input-inline'>
					<input name='pwd_before' class='layui-input' type='password'>
				</div>
			</div>
			<div class='layui-form-item'>
				<label class='layui-form-label'>现密码</label>
				<div class='layui-input-inline'>
					<input name='pwd_now' class='layui-input' type='password'>
				</div>
			</div>
			<div class='layui-form-item'>
				<label class='layui-form-label'>确认密码</label>
				<div class='layui-input-inline'>
					<input name='pwd_ensure' class='layui-input' type='password'>
				</div>
			</div>
			<div class="layui-form-item">
			    <div class="layui-input-block">
			      <button class="layui-btn" type="submit" onclick="changePwd()">提交</button>
			      <button class="layui-btn layui-btn-primary" type="reset">重置</button>
			    </div>
		  	</div>
</form>
</body>
</html>