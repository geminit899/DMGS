 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: geminit
  Date: 2018/5/9
  Time: 下午2:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="background.jsp"></jsp:include>

<script src="/js/manage.js"></script>

<link rel="stylesheet" type="text/css" href="/css/back/manage.css">

<div id="page-wrapper" class="content-wrapper">
    <div class="row" style="padding-top: 50px">
        <div class="col-md-1 col-sm-1 col-xs-1"></div>
        <div class="col-md-8 col-sm-8 col-xs-8 form-inline">
            <div class="form-group">
                <label>区域: </label>
                <input type="text" class="form-control" id="search">
            </div>
            <button class="btn btn-primary" id="search-btn">搜索</button>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2" align="center">
            <c:if test="${prefix=='temperature' || prefix=='pm2_5' }">
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newModal">修改</button>
            </c:if>
        </div>
        <div class="col-md-1 col-sm-1 col-xs-1"></div>
    </div>
    <div class="row" style="margin-top: 40px">
        <div class="col-md-1 col-sm-1 col-xs-1"></div>
        <div class="col-md-10 col-sm-10 col-xs-10">
            <table class="table table-bordered" border="1" id="table-user">
                <c:if test="${prefix=='temperature' || prefix=='pm2_5'}">
                    <tr align="center">
                        <td class="success" width="10%"><label>城市</label></td>
                        <td class="success" width="10%"><label>值</label></td>
                        <td class="success" width="10%"><label>城市</label></td>
                        <td class="success" width="10%"><label>值</label></td>
                        <td class="success" width="10%"><label>城市</label></td>
                        <td class="success" width="10%"><label>值</label></td>
                        <td class="success" width="10%"><label>城市</label></td>
                        <td class="success" width="10%"><label>值</label></td>
                        <td class="success" width="10%"><label>城市</label></td>
                        <td class="success" width="10%"><label>值</label></td>
                    </tr>
                    <c:forEach begin="0" end="${name.size()}" step="5" var="i">
                        <tr class="table-bordered" align="center">
                            <td>${name.get(i)}</td>
                            <td>${value.get(i)}</td>
                            <c:if test="${(i+1)<name.size()}">
                                <td>${name.get(i+1)}</td>
                                <td>${value.get(i+1)}</td>
                            </c:if>
                            <c:if test="${(i+2)<name.size()}">
                                <td>${name.get(i+2)}</td>
                                <td>${value.get(i+2)}</td>
                            </c:if>
                            <c:if test="${(i+3)<name.size()}">
                                <td>${name.get(i+3)}</td>
                                <td>${value.get(i+3)}</td>
                            </c:if>
                            <c:if test="${(i+4)<name.size()}">
                                <td>${name.get(i+4)}</td>
                                <td>${value.get(i+4)}</td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${prefix=='taifeng' || prefix=='earthquake'}">
                    <tr align="center">
                        <td class="success" width="10%"><label>名字</label></td>
                        <td class="success" width="5%"><label>级数</label></td>
                        <td class="success" width="20%"><label>经度</label></td>
                        <td class="success" width="20%"><label>纬度</label></td>
                        <td class="success" width="25%"><label>时间</label></td>
                        <td class="success" width="20%"><label>操作</label></td>
                    </tr>
                    <c:forEach items="${objList}" var="obj">
                        <tr class="table-bordered" align="center">
                            <td>${obj.name}</td>
                            <td>${obj.degree}</td>
                            <td>${obj.lng}</td>
                            <td>${obj.lat}</td>
                            <td>${obj.time}</td>
                            <td>
                                <button class="btn btn-warning edit" value="${obj.id}">编辑</button>
                                <button class="btn btn-danger" onclick="objDelete(${obj.id})">删除</button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
            </table>
        </div>
        <div class="col-md-1 col-sm-1 col-xs-1"></div>
    </div>
    <c:if test="${prefix=='taifeng' || prefix=='earthquake'}">
        <div class="row">
            <div class="col-md-1 col-sm-1 col-xs-1"></div>
            <div class="col-md-7 col-sm-7 col-xs-7"></div>
            <div class="col-md-3 col-sm-3 col-xs-3" style="text-align: right;">
                <nav>
                    <ul class="pager" id="page-controller">
                        <li <c:if test="${currentPage==1}"> class="disabled"</c:if>><a href="/manageDisaster?prefix=${prefix}&page=${currentPage-1}">上一页</a></li>
                        <li <c:if test="${currentPage==pageNum}"> class="disabled"</c:if>><a href="/manageDisaster?prefix=${prefix}&page=${currentPage+1}">下一页</a></li>
                    </ul>
                </nav>
            </div>
            <div class="col-md-1 col-sm-1 col-xs-1"></div>
        </div>
    </c:if>

    <div class="modal fade" id="newModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">修改</h4>
                </div>
                <div class="modal-body">
                    <div class="form-inline">
                        <div class="row">
                            <div class="col-md-1 col-sm-1 col-xs-1"></div>
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <label>城市:  </label>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-4">
                                <input type="text" id="cityName" style="height: 40px;width: 100%;">
                            </div>
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <label>值:  </label>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-4">
                                <input type="text" id="value" style="height: 40px;width: 100%;">
                            </div>
                            <div class="col-md-1 col-sm-1 col-xs-1"></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="newButton">修改</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabelEdit">编辑</h4>
                </div>
                <div class="modal-body">
                    <div class="form-inline">
                        <div class="row">
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <input id="idEdit" style="display: none">
                            </div>
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <label>名称:  </label>
                            </div>
                            <div class="col-md-5 col-sm-5 col-xs-5">
                                <input type="text" id="nameEdit" style="height: 40px;width: 100%;">
                            </div>
                            <div class="col-md-5 col-sm-5 col-xs-5"></div>
                        </div>
                        <div class="row">
                            <div class="col-md-1 col-sm-1 col-xs-1"></div>
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <label>级数:  </label>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-4">
                                <input type="text" id="degreeEdit" style="height: 40px;width: 100%;">
                            </div>
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <label>时间:  </label>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-4">
                                <input type="text" id="timeEdit" style="height: 40px;width: 100%;">
                            </div>
                            <div class="col-md-1 col-sm-1 col-xs-1"></div>
                        </div>
                        <div class="row">
                            <div class="col-md-1 col-sm-1 col-xs-1"></div>
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <label>经度:  </label>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-4">
                                <input type="text" id="lngEdit" style="height: 40px;width: 100%;">
                            </div>
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <label>纬度:  </label>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-4">
                                <input type="text" id="latEdit" style="height: 40px;width: 100%;">
                            </div>
                            <div class="col-md-1 col-sm-1 col-xs-1"></div>
                        </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="editButton">更新</button>
                </div>
            </div>
        </div>
    </div>

    <%--成功模态框--%>
    <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="myModalLabelSuccess">成功</h4>
                </div>
                <div class="modal-body">操作成功!</div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="success()">好的</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>

    <%--失败模态框--%>
    <div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="myModalLabelError">失败</h4>
                </div>
                <div class="modal-body">操作失败!</div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">好的</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>

    <script type="text/javascript">
        var id = "disaster";
        $("#" + id).attr("class", "active-menu");
    </script>

    <script type="text/javascript">
        //获取当前时间，格式“yyyy-MM-dd HH:MM:SS”
        function getNowFormatDate() {
            var date = new Date();
            var seperator1 = "-";
            var seperator2 = ":";
            var month = date.getMonth() + 1;
            var strDate = date.getDate();
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
            }
            var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
                + " " + date.getHours() + seperator2 + date.getMinutes()
                + seperator2 + date.getSeconds();
            return currentdate;
        }

        $("#newTime").val(getNowFormatDate());
    </script>

    <script type="text/javascript">
        $("#newButton").click(function(){

            if( $("#cityName").val() == "" || $("#value").val() == "" ) {
                alert("请填写完整！");
                return;
            }

            var str = {};
            str["prefix"] = "${prefix}";
            str["name"] = $("#cityName").val();
            str["value"] = $("#value").val();

            $.ajax({                    //获得各个区域的值
                type:"post",
                async: false, //同步执行
                url:"/manageDisaster/edit",
                data:str,
                success:function(result){
                    if (result.toString() == "success"){
                        window.location.reload();
                    }
                }
            });
        })
    </script>

    <script type="text/javascript">
        function objDelete(id) {

            var str = {};
            str["prefix"] = "${prefix}";
            str["id"] = id;

            $.ajax({                    //获得各个区域的值
                type:"post",
                async: false, //同步执行
                url:"/manageDisaster/delete",
                data:str,
                success:function(result){
                    if (result.toString() == "success"){
                        $('#successModal').modal('show');
                    }else if (result.toString() == "error"){
                        $('#errorModal').modal('show');
                    }
                }
            });
        }
    </script>

    <script type="text/javascript">
        $(".edit").click(function(){

            $("#idEdit").val($(this).attr("value"));

            var tr = $(this).parent().parent().children();

            $("#nameEdit").val(tr.get(0).innerHTML);
            $("#degreeEdit").val(tr.get(1).innerHTML);
            $("#timeEdit").val(tr.get(4).innerHTML);
            $("#lngEdit").val(tr.get(2).innerHTML);
            $("#latEdit").val(tr.get(3).innerHTML);

            $("#editModal").modal('show');
        });
    </script>

    <script type="text/javascript">
        $("#editButton").click(function(){
            if( $("#nameEdit").val() == "" || $("#degreeEdit").val() == "" || $("#timeEdit").val() == "" ||
                $("#lngEdit").val() == "" || $("#latEdit").val() == "" ){
                alert("请填写完整！");
                return;
            }

            var str = {};
            str["prefix"] = "${prefix}";
            str["id"] = $("#idEdit").val();
            str["name"] = $("#nameEdit").val();
            str["value"] = $("#degreeEdit").val();
            str["time"] = $("#timeEdit").val();
            str["lng"] = $("#lngEdit").val();
            str["lat"] = $("#latEdit").val();

            $.ajax({                    //获得各个区域的值
                type:"post",
                async: false, //同步执行
                url:"/manageDisaster/edit",
                data:str,
                success:function(result){
                    if (result.toString() == "success"){
                        $('#successModal').modal('show');
                    }else if (result.toString() == "error"){
                        $('#errorModal').modal('show');
                    }
                }
            });
        })
    </script>

    <script type="text/javascript">
        function success(){
            $('#successModal').modal('hide');
            $('#newModal').modal('hide');
            $('#editModal').modal('hide');
            window.location.reload();
        }
    </script>
</div>
