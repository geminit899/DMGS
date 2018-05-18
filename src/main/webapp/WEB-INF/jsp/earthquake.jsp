<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: geminit
  Date: 2018/5/11
  Time: 下午3:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/js/echarts-all-3.js"></script>
<script src="/js/mapbox-gl-dev.js"></script>
<script src="/js/EchartsLayer.js"></script>

<link rel="stylesheet" type="text/css" href="/css/front/mapbox-gl.css">
<div class="row">
    <!-- IMPORT jsp begin -->
    <div id="map" style="width: 100%;"></div>
    <div style="text-align: center;">
        <h3 style="color: #234577;">地震排行</h3>
    </div>
    <table class="table table-bordered" border="1" id="table-user" style="margin-top: 20px">
        <tr align="center">
            <td class="success" width="25%"><label>发生地</label></td>
            <td class="success" width="10%"><label>震级</label></td>
            <td class="success" width="15%"><label>时间</label></td>
            <td class="success" width="25%"><label>发生地</label></td>
            <td class="success" width="10%"><label>震级</label></td>
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
        var data = [];
        var geoCoordMap = eval(${geoJsonObject});

        for (var i = 0; i<eval(${jsonArray.size()}); i++) {
            data.push({'name':${jsonArray}[i].name, 'value': ${jsonArray}[i].value});
        }


        var map = new mapboxgl.Map({
            container: 'map', // container id
            style: {
                'version': 8,
                'sources': {},
                'layers': []
            },
            center: [104.114129, 37.550339], // starting position

            zoom: 3 // starting zoom
        })
        map.addControl(new mapboxgl.NavigationControl())
        // option2.GLMap.map=map;
        map.on('load', function () {
            map.addSource('google.tile', {
                'type': 'raster',
                'tiles': ['https://www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}'],
                'tileSize': 256
            })
            map.addLayer({
                'id': 'google',
                'type': 'raster',
                'source': 'google.tile'
            })

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

                title: {
                    text: '地震监测图',
                    left: 'center',
                    textStyle: {
                        color: '#fff'
                    }
                },
                visualMap: {
                    min: 0,
                    max: 10,
                    splitNumber: 5,
                    pieces: [{
                        min: 0,
                        max: 4,
                        color: '#8dc1a9'
                    }, {
                        min: 4,
                        max: 6,
                        color: '#e69d87'
                    }, {
                        min: 6,
                        max: 7,
                        color: '#ea7e53'
                    }, {
                        min: 7,
                        max: 8,
                        color: '#dd6b66'
                    }, {
                        min: 8,
                        color: '#d72400'
                    }],
                    textStyle: {
                        color: '#fff'
                    },
                },
                tooltip : {
                    trigger: 'item',
                    formatter: function (params) {
                        str = "位置：" + params.name + "<br/>震级：" + params.value[2] + "<br/>时间：" + params.data.label;
                        return str;
                    },
                },
                GLMap: {},

                series: {
                    name: '地震监测',
                    type: 'scatter',
                    coordinateSystem: 'GLMap',
                    data: convertData(data),
                    symbol: 'pin',
                    symbolSize: function (val) {
                        return val[2] * 10;
                    },
                    label: {
                        normal: {
                            show: false
                        },
                        emphasis: {
                            show: true
                        }
                    },
                    itemStyle: {
                        normal: {
                            color: '#fff'
                        }
                    }
                }
            };

            var echartslayer = new EchartsLayer(map);
            echartslayer.chart.setOption(option);

        })
    </script>
    <!-- //IMPORT jsp end -->
</div>
