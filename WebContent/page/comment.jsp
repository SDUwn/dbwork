<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Db.Dbutil" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
</head>
<style>
.wrapper{width:300px; margin:10px auto; font:14px/1.5 arial;}
/*tab*/
#star{overflow:hidden;}
#star li{
float:left;
width:20px;
height:20px;
margin:2px;
display:inline;
color:#999;
font:bold 18px arial;
cursor:pointer
}
#star .act{
color:yellow
}
#star_word{
width:80px;
height:30px;
line-height:30px;
border:1px solid #ccc;
margin:10px;
text-align:center;
display:none
}
</style>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
  <legend>打分</legend>
</fieldset>
<div class="wrapper">
<span id="result"></span>
<ul id="star">
<li>★</li>
<li>★</li>
<li>★</li>
<li>★</li>
<li>★</li>
</ul>
<div id="star_word">一般</div>
</div> 
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
  <legend>评价</legend>
</fieldset> 
  <div class="layui-form-item layui-form-text">
  	<label class="layui-form-label">评价输入框</label>
    <div class="layui-input-block">
      <textarea id="words" class="layui-textarea" placeholder="请输入评价内容"></textarea>
    </div>
  </div>
   <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" onclick="send_comment()">立即提交</button>
      <button class="layui-btn layui-btn-primary" type="reset">重置</button>
    </div>
  </div>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
  <legend>历史评价</legend>
</fieldset> 
<%
String user_ID=session.getAttribute("ID").toString();
Dbutil util=new Dbutil();
String SQL="";
ResultSet rs=null;
%>
<table class="layui-table" lay-filter="parse-table-demo" >
  <thead>
    <tr>
    	<th lay-data="{field:'1', width:100,fixed:'left'}">用户ID</th>
       	<th lay-data="{field:'2', width:100}">评分</th>
        <th lay-data="{field:'3', width:550}">评价</th>        
        <th lay-data="{field:'4', width:200}">时间</th>
    </tr> 
  </thead>
  <tbody>
<%
SQL="select * from comment where user_ID='"+user_ID+"' ";
rs=util.query(SQL);
while(rs.next()){
%>
		<tr>
		   	<td><%=rs.getInt("user_ID") %></td>
    		<td><%=rs.getInt("score") %></td>
    		<td><%=rs.getString("comment") %></td>
    		<td><%=rs.getString("commit_time") %></td>
    	</tr>

<%
}
util.close();
%>
</tbody>
</table>
</body>
<script type="text/javascript" src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="../layui/layui.js" charset="utf-8"></script>
<script>
layui.use('table', function(){
	  var table = layui.table;
	      table.init('parse-table-demo', { //转化静态表格
	        //height: 'full-500'
			page:true
	      });
	    });
var score;
var words;
window.onload = function(){
	 var star = document.getElementById("star");
	 var star_li = star.getElementsByTagName("li");
	 var star_word = document.getElementById("star_word");
	 var result = document.getElementById("result");
	 var i=0;
	 var j=0;
	 var flag=false;
	 var len = star_li.length;
	 var word = ['很差','差','一般',"好","很好"]
	 for(i=0; i<len; i++){
	 star_li[i].index = i;
	 star_li[i].onmouseover = function(){
	 star_word.style.display = "block";
	 star_word.innerHTML = word[this.index];
	 for(i=0; i<=this.index; i++){
	  star_li[i].className = "act";
	 }
	 flag=false;
	 }
	 star_li[i].onmouseout = function(){
	 if(flag==false){
	 star_word.style.display = "none";
	 for(i=0; i<len; i++){
	  star_li[i].className = "";
	 }}
	 }
	 star_li[i].onclick = function(){
		 score=this.index+1;
		 for(j=0; j< (this.index+1); j++){
			  star_li[j].className = "act";
			 }
		 flag=true;
		 }
	  }
	}
	
function send_comment(){
	words=$("#words").val();
	window.location.href="doSendComment.jsp?comment="+words+"&score="+score+"";	
}
</script>
</html>