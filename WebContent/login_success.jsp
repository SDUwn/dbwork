<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>飞机售票系统</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta http-equiv="Access-Control-Allow-Origin" content="*">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		<link rel="icon" href="favicon.ico">     <!-- 网页顶部头图标 -->
		<link rel="stylesheet" href="layui/css/layui.css" />   <!-- layui   css样式表 -->
		<link rel="stylesheet" type="text/css" href="css/public.css" />  <!-- 公用的css样式表 -->
		<link rel="stylesheet" href="css/index.css" />     <!-- 后台首页样式表 -->
	</head>
	<body class="main_body white">
	<%String UserName=session.getAttribute("UserName").toString();%>
		<div class="layui-layout layui-layout-admin">
			<!-- 顶部 -->
			<div class="layui-header header lt">
				<div class="layui-main mag0">
					<a href="#" class="logo" alt="文字标题">欢迎来到飞机售票系统</a>
					<!-- 显示/隐藏菜单 -->
					<a href="javascript:;" class="seraph hideMenu icon-caidan"></a>

					<!-- 顶部右侧菜单 -->
					<ul class="layui-nav top_menu">
						<li class="layui-nav-item" pc>
							<a href="javascript:;" class="clearSession"><i class="layui-icon" data-icon="&#xe640;">&#xe640;</i><cite style="padding-left: 2px;">清除缓存</cite></a>
						</li>
						<li class="layui-nav-item" id="userInfo">
							<a href="javascript:;">
								<img src="images/face_wn.jpg" class="layui-nav-img userAvatar" width="35" height="35">
								<cite class="adminName"><%=UserName %></cite>&nbsp;</a>
							<dl class="layui-nav-child">
								<dd><a href="index.html" class="transform"><i class="layui-icon">&#xe66f;</i><cite>切换账号</cite></a></dd>
								<dd><a href="changePassword.jsp"><i class="layui-icon ">&#xe770;</i><cite>修改密码</cite></a></dd>
								<dd><a href="index.html" class="signOut"><i class="layui-icon">&#xe682;</i><cite>退出</cite></a></dd>
							</dl>
						</li>
					</ul>
				</div>
			</div>

			<div class=" main_body_content" style="overflow: hidden;">
				<!-- 左侧导航 -->
				<div class="layui-side layui-bg-black lt">
					<div class="navBar layui-side-scroll" id="navBar">
						<ul class="layui-nav layui-nav-tree">
							<li class="layui-nav-item layui-this">
								<a href="javascript:;" data-url="main.jsp">
									<i class="layui-icon" data-icon=""></i>
									<cite>首页</cite>
								</a>
							</li>
						</ul>
					</div>
				</div>
				<!-- 主体内容 -->
				<div class="layui-tab-content clildFrame">
					<div class="layui-tab-item layui-show">
						<div class="main_hd with_extra">
							<h2>首页</h2>
						</div>
						<iframe src="main.jsp" frameborder="0" scrolling="no" id="iframe"></iframe>
					</div>
				</div>
			</div>

			<div class="footer">
				<p><span>© 数据库课设 2020</span></p>
			</div>
		</div>


		<!-- 移动导航 -->
		<div class="site-mobile-shade"></div>
		<div class="site-tree-mobile"><i class="layui-icon">&#xe66b;</i></div>


		<script type="text/javascript" src="layui/layui.js"></script>
		<script type="text/javascript" src="js/index.js"></script>

	</body>
</html>
    