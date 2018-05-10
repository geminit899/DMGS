<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  Date: 2018/5/8
  Time: 下午12:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>DMGS</title>
    <meta name="description" content="this is my page">

    <script src="/js/jquery-1.10.2.js"></script>
    <script src="/js/bootstrap.js"></script>

    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/css/front/index.css">
    <link rel="stylesheet" type="text/css" href="/css/front/util.css">

</head>
<body>
    <div class="container">

        <jsp:include page="util/header.jsp"></jsp:include>

        <!-- Swiper -->
        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" style="margin-top: 20px;">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                <li data-target="#carousel-example-generic" data-slide-to="3"></li>
            </ol>

            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox">
                <div class="item active">
                    <img src="http://www.dsac.cn/file/gundong/6e22ff27-9c5f-401a-bdb5-78bbd37fb120.jpg" alt="...">
                </div>
                <div class="item">
                    <img src="http://www.dsac.cn/file/gundong/a35dde4f-9a45-4d96-a828-7354509a2a0f.jpg" alt="...">
                </div>
                <div class="item">
                    <img src="http://www.dsac.cn/file/gundong/1fb486d9-b3ab-42ae-b1cd-6a6292c9ce26.jpg" alt="...">
                </div>
                <div class="item">
                    <img src="http://www.dsac.cn/file/gundong/bd7e515c-be3f-459c-ad1e-cdbd9fc328c9.jpg" alt="...">
                </div>
            </div>

            <!-- Controls -->
            <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
        <!-- Swiper End -->

        <!-- echarts begin -->
        <div class="echarts row">
            <!-- left map -->
            <div class="col-lg-8 col-md-8 col-sm-8">
                <div id="map" style="width: 100%;"></div>
            </div>
            <!-- //left map -->
            <!-- right charts -->
            <div class="col-lg-4 col-md-4 col-sm-4">
                <div id="charts" style="width: 100%;"></div>
            </div>
            <!-- //right charts -->
        </div>
        <!-- //echarts end -->

        <!-- main body begin -->
        <div class="row">
            <!-- left side -->
            <div class="col-lg-8 col-md-8 col-sm-8">
                <div id="news" class="block">
                    <div class="title row" style="margin: 0 0 0 0;">
                        <div class="col-lg-8 col-md-8 col-sm-8">
                            <h4 style="margin-top: 10px;">新闻快讯</h4>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <h4 style="margin-top: 10px;text-align: right;">
                                <a href="#" style="color: white;">more...</a>
                            </h4>
                        </div>
                    </div>
                    <div class="content">
                        <c:forEach items="${newsList}" var="news">
                            <h5>
                                <a href="#" style="color: darkgray;">${news.title}</a>
                            </h5>
                            <hr style="margin-top: 10px;margin-bottom: 10px;" color="gray" />
                        </c:forEach>
                    </div>
                </div>
                <div id="knowledge" class="block">
                    <div class="title row" style="margin: 0 0 0 0;">
                        <div class="col-lg-8 col-md-8 col-sm-8">
                            <h4 style="margin-top: 10px;">科普宣传</h4>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <h4 style="margin-top: 10px;text-align: right;">
                                <a href="#" style="color: white;">more...</a>
                            </h4>
                        </div>
                    </div>
                    <div class="content">
                        <c:forEach items="${knowledgeList}" var="knowledge">
                            <h5>
                                <a href="#" style="color: darkgray;">${knowledge.title}</a>
                            </h5>
                            <hr style="margin-top: 10px;margin-bottom: 10px;" color="gray" />
                        </c:forEach>
                    </div>
                </div>
            </div>
            <!-- //left side -->
            <!-- right side -->
            <div class="col-lg-4 col-md-4 col-sm-4">
                <div id="share" class="block">
                    <div class="title row" style="margin: 0 0 0 0;">
                        <div class="col-lg-8 col-md-8 col-sm-8">
                            <h4 style="margin-top: 10px;">数据共享</h4>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <h4 style="margin-top: 10px;text-align: right;">
                                <a href="#" style="color: white;">more...</a>
                            </h4>
                        </div>
                    </div>
                    <div class="content">
                        <c:forEach items="${shareList}" var="share">
                            <h5>
                                <a href="#" style="color: darkgray;">${share.title}</a>
                            </h5>
                            <hr style="margin-top: 10px;margin-bottom: 10px;" color="gray" />
                        </c:forEach>
                    </div>
                </div>
                <div id="law" class="block">
                    <div class="title row" style="margin: 0 0 0 0;">
                        <div class="col-lg-8 col-md-8 col-sm-8">
                            <h4 style="margin-top: 10px;">政策法规</h4>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <h4 style="margin-top: 10px;text-align: right;">
                                <a href="#" style="color: white;">more...</a>
                            </h4>
                        </div>
                    </div>
                    <div class="content">
                        <c:forEach items="${lawList}" var="law">
                            <h5>
                                <a href="#" style="color: darkgray;">${law.title}</a>
                            </h5>
                            <hr style="margin-top: 10px;margin-bottom: 10px;" color="gray" />
                        </c:forEach>
                    </div>
                </div>
            </div>
            <!-- //right side -->
        </div>
        <!-- //main body begin -->

        <jsp:include page="util/footer.jsp"></jsp:include>

        <script src="/js/echarts.js"></script>
        <script src="/js/china.js"></script>

        <script type="text/javascript">
            var e = document.getElementById("map");
            var height = parseInt(window.getComputedStyle(e).width);

            $("#map").attr("style", "height: " + height * 0.8 + "px;width: 100%;");
            $("#charts").attr("style", "height: " + height * 0.8 + "px;width: 100%;");
        </script>

        <script type="text/javascript">
            var myChart = echarts.init(document.getElementById('map'));

            var temperatureData = [];
            var earthquakeData = [];
            var geoCoordMap = eval(${geoJsonObject});

            var minT = 0;
            var maxT = 0;

            for (var i = 0; i<eval(${nllt.size()}); i++) {
                temperatureData.push({'name':${nllt}[i].name, 'value': ${nllt}[i].temperature, 'time':''});
                temperature = ${nllt}[i].temperature;
                if ( parseInt(temperature) < minT )
                    minT = parseInt(temperature);
                if ( parseInt(temperature) > maxT )
                    maxT = parseInt(temperature);
            }

            for (var i = 0; i<eval(${earthquakeInfo.size()}); i++) {
                earthquakeData.push({'name':${earthquakeInfo}[i].name, 'value': ${earthquakeInfo}[i].degree*10,
                                     'time': ${earthquakeInfo}[i].time});
            }

            var convertData = function (data) {
                var res = [];
                for (var i = 0; i < data.length; i++) {
                    var geoCoord = geoCoordMap[data[i].name];
                    if (geoCoord) {
                        res.push({
                            name: data[i].name,
                            value: geoCoord.concat(data[i].value),
                            label: data[i].time,
                        });
                    }
                }
                return res;
            };

            option = {
                backgroundColor: '#FFFFFF',
                visualMap: {
                    min: minT,
                    max: maxT,
                    calculable: true,
                    color: ['#d94e5d','#eac736','#50a3ba'],
                    textStyle: {
                        color: '#234577'
                    },
                    hoverLink:false,
                },
                tooltip : {
                    trigger: 'item',
                    formatter: function (params) {
                        switch ( params.seriesName )
                        {
                            case "气温":
                                name = params.name;
                                temperature = params.value[2];
                                str = "城市：" + name + "<br/>温度：" + temperature;
                                return str;
                            case "地震":
                                name = params.name;
                                degree = params.value[2]/10;
                                time = params.data.label;
                                str = "位置：" + name + "<br/>震级：" + degree + "<br/>时间：" + time;
                                return str;
                        }
                    },
                },
                legend: {
                    x:'center',
                    y: 'top',
                    data:['气温','地震'],
                },
                color:['#eac736','#d94e5d'],
                geo: {
                    map: 'china',
                    label: {
                        emphasis: {
                            show: false
                        }
                    },
                    roam: false,
                    itemStyle: {
                        normal: {
                            areaColor: '#347EBE',
                            borderColor: '#111'
                        },
                        emphasis: {
                            areaColor: '#36648B'
                        }
                    }
                },
                series : [
                    {
                        name: '气温',
                        type: 'scatter',
                        coordinateSystem: 'geo',
                        data: convertData(temperatureData),
                        symbolSize: 5,
                        label: {
                            normal: {
                                show: false
                            },
                            emphasis: {
                                show: false
                            }
                        },
                        itemStyle: {
                            emphasis: {
                                borderColor: '#fff',
                                borderWidth: 1
                            }
                        }
                    },
                    {
                        name: '地震',
                        type: 'scatter',
                        coordinateSystem: 'geo',
                        data: convertData(earthquakeData),
                        symbol: 'pin',
                        symbolSize: function (val) {
                            return val[2];
                        },
                        label: {
                            normal: {
                                position: 'right',
                                show: false
                            },
                            emphasis: {
                                show: false
                            }
                        }
                    }
                ]
            };
            myChart.setOption(option);
        </script>

        <script type="text/javascript">
            var myChart = echarts.init(document.getElementById('charts'));
            option = {
                backgroundColor: '#FFFFFF',
                title : {
                    text: '南丁格尔玫瑰图',
                    x:'center'
                },
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    x : 'center',
                    y : 'bottom',
                    data:['rose1','rose2','rose3','rose4','rose5','rose6','rose7','rose8']
                },
                calculable : true,
                series : [
                    {
                        name:'半径模式',
                        type:'pie',
                        radius : [20, 90],
                        center : ['50%', '25%'],
                        roseType : 'radius',
                        label: {
                            normal: {
                                show: false
                            },
                            emphasis: {
                                show: true
                            }
                        },
                        lableLine: {
                            normal: {
                                show: false
                            },
                            emphasis: {
                                show: true
                            }
                        },
                        data:[
                            {value:10, name:'rose1'},
                            {value:5, name:'rose2'},
                            {value:15, name:'rose3'},
                            {value:25, name:'rose4'},
                            {value:20, name:'rose5'},
                            {value:35, name:'rose6'},
                            {value:30, name:'rose7'},
                            {value:40, name:'rose8'}
                        ]
                    },
                    {
                        name:'面积模式',
                        type:'pie',
                        radius : [30, 90],
                        center : ['50%', '65%'],
                        roseType : 'area',
                        data:[
                            {value:10, name:'rose1'},
                            {value:5, name:'rose2'},
                            {value:15, name:'rose3'},
                            {value:25, name:'rose4'},
                            {value:20, name:'rose5'},
                            {value:35, name:'rose6'},
                            {value:30, name:'rose7'},
                            {value:40, name:'rose8'}
                        ]
                    }
                ]
            };

            myChart.setOption(option);
        </script>

    </div>
</body>
</html>
