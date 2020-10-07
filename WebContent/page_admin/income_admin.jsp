<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Ticket" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>第一个 ECharts 实例</title>
    <!-- 引入 echarts.js -->
    <script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>
</head>
<%
String SQL="";
Dbutil util=new Dbutil();
ResultSet rs=null;
SQL=" select date(booktime),sum(price) ";
SQL+=" from ticket ";
SQL+=" where ticket_state='normal' ";
SQL+=" group by date(booktime) ";
rs=util.query(SQL);
//rs.last();// 移动到最后
//int length=rs.getRow();// 获得结果集长度
//double sum_price[]=new double[length];
//String date[]=new String[length];
//rs.beforeFirst();//移动到第一个元素的前面 
//int i=0;
String sum1="",sum2="",sum3="";
String dates="";
while(rs.next()){
	sum1+=""+rs.getDouble("sum(price)")+" ,";
	//sum_price[i]=rs.getDouble("sum(price)");
	dates+="'"+rs.getString("date(booktime)")+"' ,";
	//date[i]=rs.getString("date(booktime)");
	//i++;
}
SQL=" select date(booktime),sum(price) ";
SQL+=" from ticket ";
SQL+=" where ticket_state='returned' ";
SQL+=" group by date(booktime) ";
rs=util.query(SQL);
while(rs.next()){
	sum2+=""+rs.getDouble("sum(price)")+" ,";
}
util.close();
%>
<body>
<div>
    <div id="main" style="width: 600px;height:400px;"></div>
    <div id="main1" style="width: 600px;height:400px;"></div>
</div>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        var myChart1 = echarts.init(document.getElementById('main1'));

        // 指定图表的配置项和数据
        var option = {
        	    title: {
        	        text: '销售额'
        	    },
        	    tooltip: {
        	        trigger: 'axis'
        	    },
        	    legend: {
        	        data: ['已订票','已退票']
        	    },
        	    grid: {
        	        left: '3%',
        	        right: '4%',
        	        bottom: '3%',
        	        containLabel: true
        	    },
        	    toolbox: {
        	        feature: {
        	            saveAsImage: {}
        	        }
        	    },
        	    xAxis: {
        	        type: 'category',
        	        boundaryGap: false,
        	        data: [<%=dates%>]
        	    },
        	    yAxis: {
        	        type: 'value'
        	    },
        	    series: [
        	        {
        	            name: '已订票',
        	            type: 'line',
        	            stack: '总量',
        	            areaStyle: {},
        	            data: [<%=sum1%>]
        	        },
        	        {
        	            name: '已退票',
        	            type: 'line',
        	            stack: '总量',
        	            areaStyle: {},
        	            data: [<%=sum1%>]
        	        }
        	    ]
        	};

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>
</body>
</html>