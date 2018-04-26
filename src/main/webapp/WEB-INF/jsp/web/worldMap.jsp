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
    background:#000;
}
.main-body{
    background:url(./images/bg.png);
    background-size:100% 100%;
    width:100%;
    height:800px;
}
.mainContent{
    margin: 0px 0 20px 0;
    height:800px;
    padding-top: 30px;
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
		"俄罗斯":"李四",
		"东欧":'王五',
		"东南亚":"赵六",
		"南太平洋":"孙琦",
		"南美":"周八"
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
    	bottom:80,
    	textStyle:{
    		color:"white"
    	},
    	tooltip: {
            show: true,
            formatter:function(params){
            	var str = "owner:";
            	if(ownerMap[params.name]){
            		str += ownerMap[params.name];
            	}else{
            		str = params.name;
            	}
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
        top: 'center',
        right: 50,
        iconStyle:{
        	color:'white'
        },
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
        itemHeight:18,
        showLabel:true,
        textStyle:{
        	color:'white'
        },
        textGap:10,
        itemGap:0,
        itemSymbol:'rect',
        left:100,
        bottom:80,
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
            },
            emphasis:{
                label:{
                    show:true,
                    color:'black'
                }
            },
            data:dataC,
            markPoint:{
            	symbolSize:60,
            	itemStyle:{
            		color:'#bc494d',
            	},
            	data:[
            	      {name: '印度', value: 2000, coord:[77,20],symbol:'pin'} // TODO 图片
            	]
            	
            }
        },
        {
            name: '西欧',
            type: 'map',
            nameMap:nameMap,
            mapType: 'world',
            showLegendSymbol:false,
            roam: false,
            itemStyle:{
            },
            emphasis:{
                label:{
                    show:true,
                    color:'black'
                }
            },
            data:[
                {name: '德国', value: 0}
            ]
        },
        {
            name: '非洲',
            type: 'map',
            nameMap:nameMap,
            mapType: 'world',
            showLegendSymbol:false,
            roam: false,
            itemStyle:{
            },
            emphasis:{
                label:{
                    show:true,
                    color:'black'
                }
            },
            data:[
                {name: '阿尔及利亚', value: 0},
                {name: '南非', value: 30, suppliers:['CC'], testPO:10, businessPO:10, onNetPO:10}
            ]
        },
        {
            name: '中亚',
            type: 'map',
            nameMap:nameMap,
            mapType: 'world',
            showLegendSymbol:false,
            roam: false,
            itemStyle:{
            },
            emphasis:{
                label:{
                    show:true,
                    color:'black'
                }
            },
            data:[
                {name: '塔吉克斯坦', value: 30, suppliers:['CC'], testPO:10, businessPO:10, onNetPO:10},
                {name: '吉尔吉斯斯坦', value: 800, suppliers:['VDF'], testPO:100, businessPO:300, onNetPO:300}
            ]
        },
        {
            name: '俄罗斯',
            type: 'map',
            nameMap:nameMap,
            mapType: 'world',
            showLegendSymbol:false,
            roam: false,
            itemStyle:{
            },
            emphasis:{
                label:{
                    show:true,
                    color:'black'
                }
            },
            data:[
                {name: '俄罗斯', value: 300, suppliers:['CC'], testPO:100, businessPO:100, onNetPO:100}
            ]
        },
        {
            name: '东欧',
            type: 'map',
            nameMap:nameMap,
            mapType: 'world',
            showLegendSymbol:false,
            roam: false,
            itemStyle:{
            },
            emphasis:{
                label:{
                    show:true,
                    color:'black'
                }
            },
            data:[
                {name: '波兰', value: 300, suppliers:['CC'], testPO:100, businessPO:100, onNetPO:100}
            ]
        },
        {
            name: '东南亚',
            type: 'map',
            nameMap:nameMap,
            mapType: 'world',
            showLegendSymbol:false,
            roam: false,
            itemStyle:{
            },
            emphasis:{
                label:{
                    show:true,
                    color:'black'
                }
            },
            data:[
                {name: '泰国', value: 30, suppliers:['CC'], testPO:10, businessPO:10, onNetPO:10}
            ]
        },
        {
            name: '南太平洋',
            type: 'map',
            nameMap:nameMap,
            mapType: 'world',
            showLegendSymbol:false,
            roam: false,
            itemStyle:{
            },
            emphasis:{
                label:{
                    show:true,
                    color:'black'
                }
            },
            data:[
                {name: '澳大利亚', value: 1600, suppliers:['VDF','TEL','CC'], testPO:300, businessPO:600, onNetPO:600}
            ]
        },
        {
            name: '南美',
            type: 'map',
            nameMap:nameMap,
            mapType: 'world',
            showLegendSymbol:false,
            roam: false,
            itemStyle:{
            },
            emphasis:{
                label:{
                    show:true,
                    color:'black'
                }
            },
            data:[
                {name: '巴西', value: 1200, suppliers:['VDF','CC'], testPO:200, businessPO:500, onNetPO:500}
            ]
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