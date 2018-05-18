<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: geminit
  Date: 2018/5/11
  Time: 下午3:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="row">
    <!-- IMPORT jsp begin -->
    <div id="map" style="width: 100%;"></div>
    <div style="text-align: center;">
        <h3 style="color: #234577;">城市温度排行</h3>
    </div>
    <table class="table table-bordered" border="1" id="table-user" style="margin-top: 20px">
        <tr align="center">
            <td class="success" width="25%"><label>城市</label></td>
            <td class="success" width="25%"><label>温度</label></td>
            <td class="success" width="25%"><label>城市</label></td>
            <td class="success" width="25%"><label>温度</label></td>
        </tr>
        <c:forEach begin="0" end="${list.size()-1}" var="i" step="2">
            <tr class="table-bordered" align="center">
                <td>${list[i].name}</td>
                <td>${list[i].value}</td>
                <c:if test="${(i+1)<list.size()}">
                    <td>${list[i+1].name}</td>
                    <td>${list[i+1].value}</td>
                </c:if>
            </tr>
        </c:forEach>
    </table>

    <script type="text/javascript">
        var width = $("#map").width();
        var height = parseInt(0.8 * width);
        $("#map").attr("style", "width: 100%;height:" + height + "px;");
    </script>

    <script src="/js/echarts.js"></script>
    <script src="/js/china.js"></script>

    <script type="text/javascript">
        var myChart = echarts.init(document.getElementById('map'));

        var temperatureData = [];
        var geoCoordMap = eval(${geoJsonObject});

        var minT = 0;
        var maxT = 0;

        for (var i = 0; i<eval(${jsonArray.size()}); i++) {
            temperatureData.push({'name':${jsonArray}[i].name, 'value': ${jsonArray}[i].value});
            presentValue = ${jsonArray}[i].value;
            if ( parseInt(presentValue) < minT )
                minT = parseInt(presentValue);
            if ( parseInt(presentValue) > maxT )
                maxT = parseInt(presentValue);
        }

        var convertData = function (data) {
            var res = [];
            for (var i = 0; i < data.length; i++) {
                var geoCoord = geoCoordMap[data[i].name];
                if (geoCoord) {
                    res.push({
                        name: data[i].name,
                        value: geoCoord.concat(data[i].value),
                    });
                }
            }
            return res;
        };

        option = {
            backgroundColor: '#404a59',
            visualMap: {
                min: minT,
                max: maxT,
                calculable: true,
                color: ['#d94e5d','#eac736','#50a3ba'],
                textStyle: {
                    color: '#fff'
                }
            },
            tooltip : {
                trigger: 'item',
                formatter: function (params) {
                    cityName = params.name;
                    temperature = params.value[2];
                    str = "城市：" + cityName + "<br/>温度：" + temperature;
                    return str;
                },
            },
            color:['#eac736'],
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
                        areaColor: '#323c48',
                        borderColor: '#111'
                    },
                    emphasis: {
                        areaColor: '#2a333d'
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
                }
            ]
        };
        myChart.setOption(option);
    </script>

    <!-- //IMPORT jsp end -->
</div>
