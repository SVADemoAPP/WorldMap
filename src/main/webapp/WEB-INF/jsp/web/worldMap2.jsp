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
    width:1680px;
    height:1050px;
}
.mainContent{
    margin: 0px 0 0px 0;
    height:940px;
    padding-top: 50px;
    padding-bottom:60px;
}
.chart{
    width:330px;
    height:220px;
    position:absolute;
    left:60px;
    top:470px;
    border-color:#00edff;
    border-left-width:6px;
    border-top-width:8px;
    border-right-width:3px;
    border-bottom-width:8px;
    border-style: solid;
    box-shadow: 3px 3px 3px rgba(0,0,0,0.4);
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
            <!-- <div id="chart" class="chart"></div>
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
	<script src="<c:url value='/plugins/echarts4/coordMap.js'/>" type="text/javascript"></script>
	<!-- END PAGE LEVEL SCRIPTS -->

	<script type="text/javascript">
var dom = document.getElementById("container");
var myChart = echarts.init(dom);
var groupArea = {};
option = null;
option = {
    title: {
        show: false
    },
    color:['#749f83',  '#ca8622', '#bda29a','#6e7074'],
    legend:{
    	show:true,
    	left:'center',
    	bottom:30,
    	textStyle:{
    		color:"white"
    	},
    	tooltip: {
            show: true,
            /*
            formatter:function(params){
                var str = "";
                var detail = groupArea[params.name];
                if(detail){
                    var total = 0;
                    for(var i in detail){
                        total += detail[i].value;
                    }
                    var suplist = _.pluck(detail, "suppliers");
                    var supuniq = _.uniq(_.flatten(suplist))
                    str += "HQ局长:" + detail[0].officer;
                    str += "<br/>主管：" + detail[0].mainer;
                    str += "<br/>PO总数：" + total;
                    str += "<br/>运营商总数：" + supuniq.length;
                }else{
                    str = params.name;
                }
                return str;
            }*/
        },
        selectedMode:'single',
    },
    tooltip: {
        trigger: 'item',
        formatter: function (params) {
            var str = "";
            var data = params.data;
           
            str += "区域：" + data.area;
            str += "<br/>目标达成率：" + data.value*100+"%";
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
        min: 0,
        max: 1,
        text:['High','Low'],
        precision:2,
        left:130,
        bottom:30,
        realtime: false,
        calculable: true,
        textStyle:{
            color:'white'
        },
        formatter: function (value) {
            return value*100 + "%"; // 范围标签显示内容。
        },
        inRange: {
            color: ['lightskyblue','yellow', 'orangered']
        }
    },
    /*
    visualMap: {
        type:"piecewise",
        pieces: [
            {gt: 0.6},
            {gt: 0.3, lte: 0.6},
            {gt: 0, lte: 0.3},
            //{value: 0, label: '0，有拓展意愿区'},
            //{value: -1, label: '不拓展区及无意愿区', color: 'grey'}
        ],
        itemWidth:30,
        itemHeight:30,
        showLabel:true,
        textStyle:{
        	color:'white'
        },
        textGap:10,
        itemGap:0,
        itemSymbol:'rect',
        left:130,
        bottom:30,
        text:['High','Low'],
        realtime: false,
        calculable: true,
        inRange: {
            color: ['#48596d','#105fe8','#61adff','#66ffaf','#ffb666','#ff5f5f'],
            symbol:'rect'
        }
    },*/
    series: []
};
$(document).ready(function() {
	$.post("/wm/getData",null,function(data){
	    if(data.data){
	    	makeSeries(data.data);
	    }
	    
        myChart.setOption(option, true);
        //makeNewChart(data.data);
	});
});

function makeSeries(datas){
	var countryList = groupByCountry(datas);
	//var highestCountry = findHighest(countryList);
	groupArea = groupByArea(countryList);
	var fullCountry = fillCountry(countryList);
	
    var count = 0;
    for(var i in groupArea){
    	var dataOld = groupArea[i];
    	var totalPo = 0;
    	var totalExpect = 0;
    	for(var j in dataOld){
    		totalPo += dataOld[j].value;
    		totalExpect += dataOld[j].expect;
    	}
    	for(var k in dataOld){
    		dataOld[k].po = dataOld[k].value;
    		dataOld[k].value = (totalPo / totalExpect).toFixed(4);
        }
    	var si = {
            name: i,
            type: 'map',
            nameMap:nameMap,
            mapType: 'world',
            showLegendSymbol:false,
            roam: false,
            geoIndex: count,
            itemStyle:{
            },
            tooltip:{
            	formatter:function(params){
            		var str = "";
                    var data = params.data;
                   
                    str += "区域：" + data.area;
                    str += "<br/>目标达成率：" + data.value*100+"%";
                    return str;
            	}
            },
            emphasis:{
                label:{
                    show:true,
                    color:'black'
                }
            },
            data:dataOld
        };
    	option.series.push(si);
    	count++;
    }
    // 总览
    var newList = _.flatten(_.values(groupArea),true);
    
    var s1 = {
        name: '总览',
        type: 'map',
        nameMap:nameMap,
        mapType: 'world',
        showLegendSymbol:false,
        roam: false,
        emphasis:{
            label:{
                show:true,
                color:'black'
            }
        },
        data:newList
    };
    option.series.unshift(s1);
    
}

function groupByCountry(data){
	var list = []
	var group = _.groupBy(data, '国家');
	for(var i in group){
		var gTemp = group[i];
		var temp = {};
		for(var j in gTemp){
			if(temp['name']){
				temp['value'] = temp['value'] + parseInt(gTemp[j]['PO数']);
                temp['suppliers'].push(gTemp[j]['运营商']);
                temp['jan'] = temp['jan'] + parseInt(gTemp[j]['一月']);
                temp['feb'] = temp['feb'] + parseInt(gTemp[j]['二月']);
                temp['mar'] = temp['mar'] + parseInt(gTemp[j]['三月']);
                temp['apr'] = temp['apr'] + parseInt(gTemp[j]['四月']);
                temp['may'] = temp['may'] + parseInt(gTemp[j]['五月']);
                temp['expect'] = temp['expect'] + parseInt(gTemp[j]['预期']);
			}else{
				temp['area'] = gTemp[j]['片区'];
				temp['name'] = gTemp[j]['国家'];
				temp['officer'] = gTemp[j]['HQ局长'];
				temp['mainer'] = gTemp[j]['区域主管'];
				temp['isForbiden'] = gTemp[j]['不拓展及无意愿区域'];
				temp['isTend'] = gTemp[j]['意愿局点'];
				temp['value'] = parseInt(gTemp[j]['PO数']);
				temp['suppliers'] = [gTemp[j]['运营商']];
				temp['jan'] = parseInt(gTemp[j]['一月']);
                temp['feb'] = parseInt(gTemp[j]['二月']);
                temp['mar'] = parseInt(gTemp[j]['三月']);
                temp['apr'] = parseInt(gTemp[j]['四月']);
                temp['may'] = parseInt(gTemp[j]['五月']);
                temp['expect'] = parseInt(gTemp[j]['预期']);
			}
		}
		list.push(temp);
	}
	return list;
}

function findHighest(datas){
	var temp = _.max(datas, function(data){ return parseInt(data.value); });
	temp.coord = coordConvert[temp.name];
	temp.symbol = 'image://./images/d.png';
	temp.symbolOffset = [0,'-50%'];
    return temp;
}


function fillCountry(datas){
	var newlist = [];
	var obj = coordConvert;
	for(var i in coordConvert){
		var flag = true;
		for(var j in datas){
			var tempj = datas[j];
			if(tempj.name == i){
				flag = false;
				break;
			}
		}
		if(flag){
			newlist.push({'name':i, value:-1, 'isTend':'N'});
		}
	}
	return newlist.concat(datas);
}

function groupByArea(datas){
	var group = _.groupBy(datas, 'area');
    return group;
}

function makeNewChart(data){
	var list = []
	// 获取各个区域各个月份的PO数
	for(var i in groupArea){
		var temp = {};
		temp["name"] = i;
		var detail = groupArea[i];
		var total = 0,
		    totalJan = 0,
		    totalFeb = 0,
		    totalMar = 0,
		    totalApr = 0,
		    totalMay = 0;
        for(var i in detail){
            total += detail[i].value;
            totalJan += detail[i].jan;
            totalFeb += detail[i].feb;
            totalMar += detail[i].mar;
            totalApr += detail[i].apr;
            totalMay += detail[i].may;
        }
        temp["po"] = total;
        temp["poJan"] = totalJan;
        temp["poFeb"] = totalFeb;
        temp["poMar"] = totalMar;
        temp["poApr"] = totalApr;
        temp["poMay"] = totalMay;
        list.push(temp);
	}
	
	var xAxisList = ["一月","二月","三月","四月","五月"];
	
	var dataList = [];
	for(var j = 0; j<list.length; j++){
		var t = {type:'line'};
		t["name"] = list[j].name;
		t["data"] = [
		             list[j].poJan,
		             list[j].poJan+list[j].poFeb,
		             list[j].poJan+list[j].poFeb+list[j].poMar,
		             list[j].poJan+list[j].poFeb+list[j].poMar+list[j].poApr,
		             list[j].poJan+list[j].poFeb+list[j].poMar+list[j].poApr+list[j].poMay
		             ];
		dataList.push(t);
	}
	
	var dom = document.getElementById("chart");
	var chart2 = echarts.init(dom);
	var option = {
	    title: {
	        show: false
	    },
	    textStyle:{
	    	color:"#fff"
	    },
	    backgroundColor:"#062c3e",
	    tooltip: {
	        trigger: 'axis'
	    },
	    legend: {
	        show:true,
	        textStyle:{
	        	color:"white"
	        }
	    },
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '3%',
	        containLabel: true
	    },
	    xAxis: {
	        type: 'category',
	        boundaryGap: false,
	        data: xAxisList
	    },
	    yAxis: {
	        type: 'value'
	    },
	    series: dataList
	};
	chart2.setOption(option, true);
}

       </script>
	<!-- END JAVASCRIPTS -->
</body>
</html>