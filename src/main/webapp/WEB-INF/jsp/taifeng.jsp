<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: geminit
  Date: 2018/5/11
  Time: 下午3:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="http://api.map.baidu.com/api?v=2.0&ak=vI5PtgwwZxwXNO1RGSz35fxmHnVGWmWi"></script>
<script src="/js/echarts.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<div class="row">
    <!-- IMPORT jsp begin -->
    <div id="map" style="width: 100%;"></div>
    <div style="text-align: center;">
        <h3 style="color: #234577;">台风排行</h3>
    </div>
    <table class="table table-bordered" border="1" id="table-user">
        <tr align="center">
            <td class="success" width="25%"><label>发生地</label></td>
            <td class="success" width="10%"><label>风力</label></td>
            <td class="success" width="15%"><label>时间</label></td>
            <td class="success" width="25%"><label>发生地</label></td>
            <td class="success" width="10%"><label>风力</label></td>
            <td class="success" width="15%"><label>时间</label></td>
        </tr>
        <c:forEach begin="0" end="${list.size()-1}" var="i" step="2">
            <tr class="table-bordered" align="center">
                <td>${list[i].name}</td>
                <td>${list[i].value}</td>
                <td>${list[i].time}</td>
                <c:if test="${(i+1)<list.size()}">
                    <td>${list[i+1].name}</td>
                    <td>${list[i+1].value}</td>
                    <td>${list[i+1].time}</td>
                </c:if>
            </tr>
        </c:forEach>
    </table>
    <script type="text/javascript">
        var width = $("#map").width();
        var height = parseInt(0.8 * width);
        $("#map").attr("style", "width: 100%;height:" + height + "px;");
    </script>

    <script type="text/javascript">
        var geoCoordMap = eval(${geoJsonObject});
        var jsonDatas = eval(${jsonArray});
        var names = [];
        var data = [];

        for ( var i = 0; i < jsonDatas.length ; i++ ) {
            var jsonData = jsonDatas[i];
            var thisData = [];

            for ( var j = 0; j < jsonData.length; j++) {
                thisData.push({'name':jsonData[j].name, 'degree':jsonData[j].degree, 'time':jsonData[j].time});
            }

            var thisName = jsonData[0].name.split("-")[0];

            names.push(thisName);
            data.push(thisData);
        }

        var myChart = echarts.init(document.getElementById('map'));

        var convertLineData = function (data) {
            var res = [];
            var geocoods = [];
            for (var i = 0; i < data.length; i++) {
                var dataItem = data[i];
                var coord = geoCoordMap[dataItem.name];
                geocoods.push(coord);
            }
            res.push({coords:geocoods});
            return res;
        };

        var convertPointData = function (data) {
            var geocoods = [];
            for (var i = 0; i < data.length; i++) {
                var dataItem = data[i];
                var coord = geoCoordMap[dataItem.name];
                geocoods.push({
                    name: dataItem.name,
                    value: coord.concat(dataItem.degree).concat(dataItem.time),
                });
            }
            return geocoods;
        };

        var series = [];
        for ( var i = 0; i < data.length; i++ ) {
            series.push({
                    name: names[i],
                    type: 'lines',
                    polyline:true,
                    zlevel: 1,
                    effect: {
                        show: true,
                        constantSpeed: 10,
                        trailLength: 0.7,
                        color: '#fff',
                        symbolSize: 3
                    },
                    coordinateSystem: 'bmap',
                    data: convertLineData(data[i])
                },
                {
                    name: names[i],
                    type: 'lines',
                    polyline:true,
                    zlevel: 3,
                    effect: {
                        show: true,
                        constantSpeed: 10,
                        trailLength: 0,
                        symbol: 'diamond',
                        symbolSize: 15,
                        color: '#fff'
                    },
                    coordinateSystem: 'bmap',
                    data: convertLineData(data[i])
                },
                {
                    name: names[i],
                    type: 'effectScatter',
                    zlevel: 2,
                    rippleEffect: {
                        brushType: 'stroke'
                    },
                    label: {
                        normal: {
                            show: false,
                        }
                    },
                    symbolSize: 7,
                    coordinateSystem: 'bmap',
                    data: convertPointData(data[i])
                }
            );
        }

        option = {
            tooltip : {
                trigger: 'item',
                formatter: function (params) {
                    switch ( params.componentSubType )
                    {
                        case "lines":
                            return params.seriesName;
                        case "effectScatter":
                            var name = params.seriesName;
                            var degree = params.data.value[2];
                            var time = params.data.value[3];
                            str = "名字：" + name + "<br/>风力：" + degree + "级<br/>时间：" + time;
                            return str;
                    }
                },
            },
            legend: {
                y: 'top',
                x:'center',
                data:names,
                textStyle: {
                    color: '#000'
                }
            },
            bmap: {
                center: [114.114129, 27.550339],
                zoom: 5,
                roam: true,
            },
            series : series
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>

    <script type="text/javascript">

    </script>
    <!-- //IMPORT jsp end -->
</div>
