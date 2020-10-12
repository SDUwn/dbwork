<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.News" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>通知管理</title>
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
</head>
<body>
<div class="layui-form-item">
    <div class="layui-input-inline">
    	<input id="news" type="text" name="news" class="layui-input" placeholder="请输入查找关键字" >
    </div>
    <div class="layui-input-inline">
		<input type="button" class="layui-btn" value="查找通知" onclick="findNews()">
    </div>
    <div class="layui-input-inline">
		<input type="button" class="layui-btn" value="添加通知" onclick="addNews()">
    </div>
</div>
<div id="div1">
<table class="layui-table" id="tab">
  <thead>
    <tr>
      	<th >通知ID</th>
       	<th >通知标题</th>
       	<th >作者</th>
        <th >编辑时间</th>
        <th >编辑</th>        
        <th >删除</th>
        <th >查看</th>
    </tr> 
  </thead>
  <tbody>
<% 
String SQL="";
Dbutil util=new Dbutil();
ResultSet rs=null;
SQL="select * from news";
rs=util.query(SQL);
while(rs.next()){
	News n=new News();
	n.news_ID=rs.getInt("news_ID");
	n.news_title=rs.getString("news_title");
	n.admin_ID=rs.getInt("admin_ID");
	n.edit_time=rs.getString("edit_time");
	%>
	<tr>
    		<td><%=n.news_ID %></td>    		
    		<td><%=n.news_title %></td>
    		<td><%=n.admin_ID %></td>
    		<td><%=n.edit_time %></td>
    		<td><input type="button" class="layui-btn layui-btn-warm layui-btn-xs edit" name="edit" value="编辑" ></td>    		
    		<td><input type="button" class="layui-btn layui-btn-danger layui-btn-xs delete" name="delete" value="删除"></td>    		
    		<td><input type="button" class="layui-btn layui-btn-xs view" name="view" value="查看"></td>
    </tr>
	<%
}
util.close();
%>   
</tbody>
</table>
</div>
<script type="text/javascript" src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="../layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
var newsID;
$(function() {
	$("#div1").on("click", ":button", function(event) {
		if($(this).attr("name")=='edit'){
			newsID=$(this).closest("tr").find("td").eq(0).text();
			window.location.href="news/editNews.jsp?news_ID="+newsID+"";
		}else if($(this).attr("name")=='delete'){
			newsID=$(this).closest("tr").find("td").eq(0).text();
			$(this).closest("tr").empty();
			window.location.href("news/doDeleteNews.jsp?news_ID="+newsID+"");
		}else{
			newsID=$(this).closest("tr").find("td").eq(0).text();
			window.location.href("news/viewNews.jsp?news_ID="+newsID+"");
		}
	});
});
function findNews(){
	$("#tab").empty();
	 news_content=$("#news").val();
	 createXMLHttpRequest();  
	    var url = "news/searchNews.jsp?news_content="+news_content+"";  
	    XMLHttpReq.open("GET", url, true);  
	    XMLHttpReq.onreadystatechange = processResponse;//指定响应函数  
	    XMLHttpReq.send(null);
}
function processResponse() {  
    if (XMLHttpReq.readyState == 4) { // 判断对象状态  
        if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息  
        	document.getElementById("div1").innerHTML=XMLHttpReq.responseText;
        } else { 
            window.alert("您所请求的页面有异常。");  
        }  
    }  
}
function createXMLHttpRequest() {  
    if(window.XMLHttpRequest) { //Mozilla 浏览器  
        XMLHttpReq = new XMLHttpRequest();  
    }  
    else if (window.ActiveXObject) { // IE浏览器  
        try {  
            XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");  
        } catch (e) {  
            try {  
                XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");  
            } catch (e) {}  
        }  
    }  
} 
function addNews(){
	window.location.href="news/addNews.jsp";
}
</script>
</body>
</html>