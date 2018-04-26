<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="../shared/taglib.jsp"%>

<html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SVA APP demo</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<meta name="MobileOptimized" content="320">
<!-- BEGIN PAGE LEVEL PLUGIN STYLES -->
<!-- END PAGE LEVEL PLUGIN STYLES -->
<style type="text/css">
body{
    margin: 0;
}
.main-body{
    background:url(./images/bg.png);
    background-size:100% 100%;
    width:100%;
    height:1080px;
    padding-top: 70px;
}
.mainContent{
    margin: 0px 0 20px 0;
    height:1080px;
}
</style>

<link rel="shortcut icon" href="favicon.ico" />
</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body>
	<!-- BEGIN CONTAINER -->
	<div class="main-body">
		<!-- BEGIN PAGE -->
		<div class="mainContent">
			<div id="container" style="height:100%;"></div>
		</div>
		<!-- END PAGE -->
	</div>
	<!-- END CONTAINER -->

	<%@ include file="../shared/importJs.jsp"%>
	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="<c:url value='/plugins/echarts4/echarts.min.js'/>"
		type="text/javascript"></script>
	<script src="<c:url value='/plugins/echarts4/world.js'/>" type="text/javascript"></script>
	<script src="<c:url value='/plugins/echarts4/data.js'/>" type="text/javascript"></script>
	<script src="<c:url value='/plugins/echarts4/countryNameConvert.js'/>" type="text/javascript"></script>
	<!-- END PAGE LEVEL SCRIPTS -->

	<script type="text/javascript">
var ownerMap = {
		"西欧":"李广俊",
		"非洲":"孟广元",
		"中亚":"张三",
		"俄罗斯":"李四"
};
var dom = document.getElementById("container");
var myChart = echarts.init(dom);
var app = {};
option = null;
option = {
    title: {
        show: false
    },
    color:['#749f83',  '#ca8622', '#bda29a','#6e7074'],
    legend:{
    	show:true,
    	left:'center',
    	top:'bottom',
    	tooltip: {
            show: true,
            formatter:function(params){
            	var str = "owner:";
            	str += ownerMap[params.name];
            	return str;
            }
        },
        selectedMode:'single',
    },
    tooltip: {
        trigger: 'item',
        formatter: function (params) {
            var str = "";
            
            if(params.value == -2){
                return "不在此国家进行拓展";
            }else if(params.value == -1){
            	return "国家：" + params.name + "无拓展意愿";
            }else if(params.value == 0){
            	return "国家：" + params.name + "有拓展意愿";
            }
            
            var data = params.data;
            str += "国家：" + params.name;
            str += "<br/>供应商个数：" + data.suppliers.length;
            str += "<br/>供应商名称：<br/>" + data.suppliers;
            str += "<br/>测试PO个数：" + data.testPO;
            str += "<br/>商用PO个数：" + data.businessPO;
            str += "<br/>上线PO个数：" + data.onNetPO;
            return str;
        }
    },
    toolbox: {
        show: true,
        orient: 'vertical',
        left: 'right',
        top: 'center',
        feature: {
            dataView: {readOnly: false},
            restore: {},
            saveAsImage: {}
        }
    },
    visualMap: {
        type:"piecewise",
        pieces: [
            {gt: 1500},
            {gt: 1000, lte: 1500},
            {gt: 500, lte: 1000},
            {gt: 50, lte: 500},
            {gt: 0, lte: 50},
            {value: 0, label: '0，有拓展意愿区'},
            {value: -1, label: '0，无拓展意愿区'},
            {value: -2, label: '不拓展区', color: 'grey'}
        ],
        itemWidth:20,
        itemHeight:20,
        showLabel:true,
        itemGap:0,
        itemSymbol:'rect',
        left:70,
        bottom:20,
        text:['High','Low'],
        realtime: false,
        calculable: true,
        inRange: {
            color: ['#48596d','#105fe8','#61adff','#66ffaf','#ffb666','#ff5f5f'],
            symbol:'rect'
        }
    },
    series: [
        {
            name: '总览',
            type: 'map',
            nameMap:nameMap,
            mapType: 'world',
            showLegendSymbol:false,
            roam: false,
            itemStyle:{
                emphasis:{label:{show:true}}
            },
            data:dataC
        }
    ]
};
;
if (option && typeof option === "object") {
    myChart.setOption(option, true);
}
       </script>
	<!-- END JAVASCRIPTS -->
</body>
</html>