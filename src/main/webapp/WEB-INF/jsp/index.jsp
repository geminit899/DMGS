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
        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <c:forEach begin="0" end="${indexImgArray.size()}" var="i" varStatus="status">
                    <li data-target="#carousel-example-generic" data-slide-to="${i}"<c:if test="${status.first}"> class="active"</c:if>></li>
                </c:forEach>
            </ol>

            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox">
                <c:forEach items="${indexImgArray}" var="indexImg" varStatus="status">
                    <div class="item<c:if test="${status.first}"> active</c:if>">
                        <a href="${indexImg.a}">
                            <img src="${indexImg.img}" alt="..."  style="height: 500px; width: 100%">
                        </a>
                    </div>
                </c:forEach>
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
        <div id="echarts"></div>
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
                                <a href="/page?prefix=news" style="color: white;">more...</a>
                            </h4>
                        </div>
                    </div>
                    <div class="content">
                        <c:forEach items="${newsList}" var="news">
                            <h5>
                                <a href="/content?type=news&id=${news.id}" style="color: darkgray;">${news.title}</a>
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
                                <a href="/page?prefix=knowledge" style="color: white;">more...</a>
                            </h4>
                        </div>
                    </div>
                    <div class="content">
                        <c:forEach items="${knowledgeList}" var="knowledge">
                            <h5>
                                <a href="/content?type=knowledge&id=${knowledge.id}" style="color: darkgray;">${knowledge.title}</a>
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
                                <a href="/share" style="color: white;">more...</a>
                            </h4>
                        </div>
                    </div>
                    <div class="content">
                        <c:forEach items="${shareList}" var="share">
                            <h5 style="color: darkgray;">
                                ${share}
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
                                <a href="/page?prefix=law" style="color: white;">more...</a>
                            </h4>
                        </div>
                    </div>
                    <div class="content">
                        <c:forEach items="${lawList}" var="law">
                            <h5>
                                <a href="/content?type=law&id=${law.id}" style="color: darkgray;">
                                    <c:if test="${law.title.length()>23}">
                                        ${law.title.substring(0, 22)}...
                                    </c:if>
                                    <c:if test="${law.title.length()<=23}">
                                        ${law.title}
                                    </c:if>
                                </a>
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
            var e = document.getElementById("echarts");
            var height = parseInt(window.getComputedStyle(e).width);

            $("#echarts").attr("style", "height: " + height * 0.3 + "px;width: 100%;");
        </script>

        <script type="text/javascript">
            var myChart = echarts.init(document.getElementById('echarts'));

            var month = ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'];

            var earthquakeBarData = {};
            var earthquakePieData = {};
            var taifengValues = [];
            var taifengData = {};

            var eathquake_max = 0;
            var taifeng_max = 0;

            for ( var i = 0; i < ${earthquakeList.size()-1}; i++ ) {
                earthquakeBarData[${earthquakeList}[i].value] = ${earthquakeList}[i].num;
                if ( i < 5 ) {
                    earthquakePieData[${earthquakeList}[i].value] = ${earthquakeList}[i].num;
                }
                if ( eathquake_max < parseInt(${earthquakeList}[i].num) )
                    eathquake_max = parseInt(${earthquakeList}[i].num);
            }

            for ( var i = 0; i < ${taifengList.size()}; i++ ) {
                var value = parseInt(${taifengList}[i].value.split("-")[1]);
                taifengValues.push(value);
            }

            for ( var i = 0; i < month.length; i++ ){
                taifengData[month[i]] = 0;
            }

            for ( var i = 0; i < taifengValues.length; i++ ){
                var theMonth = taifengValues[i];
                taifengData[month[theMonth]] = ${taifengList}[i].num;
            }

            var leftIndex = ${earthquakeList.size()-1};
            earthquakePieData[${earthquakeList}[leftIndex].value] = ${earthquakeList}[leftIndex].num;

            option = {
                backgroundColor: '#fff',
                tooltip: {},
                title: [{
                    text: '地震多发地区',
                    x: '25%',
                    textAlign: 'center'
                }, {
                    text: '今年各月台风发生次数',
                    x: '75%',
                    textAlign: 'center'
                }],
                grid: [{
                    top: 10,
                    width: '40%',
                    bottom: 10,
                    left: 10,
                    containLabel: true
                },{
                    top: 50,
                    width: '48%',
                    bottom: 10,
                    left: '50%',
                    containLabel: true
                }],
                xAxis: [{
                    type: 'value',
                    max: eathquake_max,
                    splitLine: {
                        show: false
                    }
                },{
                    gridIndex: 1,
                    type : 'category',
                    boundaryGap : false,
                    data : month,
                }],
                yAxis: [{
                    type: 'category',
                    data: Object.keys(earthquakeBarData),
                    splitLine: {
                        show: false
                    }
                },{
                    type: 'value',
                    gridIndex: 1,
                }],
                series: [{
                    type: 'bar',
                    stack: 'earthquake',
                    z: 3,
                    label: {
                        normal: {
                            position: 'right',
                            show: true
                        }
                    },
                    data: Object.keys(earthquakeBarData).map(function (key) {
                        return earthquakeBarData[key];
                    })
                },{
                    type: 'bar',
                    stack: 'taifeng',
                    xAxisIndex: 1,
                    yAxisIndex: 1,
                    z: 3,
                    label: {
                        normal: {
                            show: false
                        }
                    },
                    data: Object.keys(taifengData).map(function (key) {
                        return taifengData[key];
                    })
                }, {
                    type: 'pie',
                    radius: [0, '30%'],
                    center: ['35%', '40%'],
                    data: Object.keys(earthquakePieData).map(function (key) {
                        return {
                            name: key,
                            value: earthquakePieData[key]
                        }
                    })
                }]
            }

            myChart.setOption(option);
        </script>
    </div>
</body>
</html>
