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
                <input type="text" class="form-control" id="name">
            </div>
            <button class="btn btn-primary" id="search-btn">搜索</button>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2" align="center">
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newModal">新增</button>
        </div>
        <div class="col-md-1 col-sm-1 col-xs-1"></div>
    </div>
    <div class="row" style="margin-top: 40px">
        <div class="col-md-1 col-sm-1 col-xs-1"></div>
        <div class="col-md-10 col-sm-10 col-xs-10">
            <table class="table table-bordered" border="1" id="table-user" style="TBBLE-LBYOUT: fixed" >
                <tr align="center">
                    <td class="success" width="5%"><label>编号</label></td>
                    <td class="success" width="35%"><label>标题</label></td>
                    <td class="success" width="35%"><label>图像链接</label></td>
                    <td class="success" width="10%"><label>时间</label></td>
                    <td class="success" width="15%"><label>操作</label></td>
                </tr>
                <c:forEach items="${list}" var="obj">
                    <tr class="table-bordered" align="center">
                        <td>${obj.id}</td>
                        <td>${obj.title}</td>
                        <td><div style="word-break:break-all;">${obj.img}</div></td>
                        <td>${obj.time}</td>
                        <td>
                            <button class="btn btn-warning edit" value="${obj.id}">编辑</button>
                            <button class="btn btn-danger" onclick="objDelete(${obj.id})">删除</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <div class="col-md-1 col-sm-1 col-xs-1"></div>
    </div>

    <div class="modal fade" id="newModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">新增</h4>
                </div>
                <div class="modal-body">
                    <div class="form-inline">
                        <div class="row">
                            <div class="col-md-2 col-sm-2 col-xs-2"></div>
                            <div class="col-md-2 col-sm-2 col-xs-2">
                                <label>请选择一个标题:  </label>
                            </div>
                            <div class="col-md-6 col-sm-6 col-xs-6">
                                <select id="newSelect" class="form-control">
                                    <option>所有新闻标题</option>
                                    <c:forEach items="${todayNews}" var="news">
                                        <option>${news}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2 col-sm-2 col-xs-2"></div>
                        </div>
                        <div class="row">
                            <div class="col-md-2 col-sm-2 col-xs-2"></div>
                            <div class="col-md-2 col-sm-2 col-xs-2">
                                <label>请输入图片地址:  </label>
                            </div>
                            <div class="col-md-6 col-sm-6 col-xs-6">
                                <input type="text" id="newImg" style="height: 40px;width: 100%;">
                            </div>
                            <div class="col-md-2 col-sm-2 col-xs-2"></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="newButton">新建</button>
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
                                <input id="editId" style="display: none">
                            </div>
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <label>标题:  </label>
                            </div>
                            <div class="col-md-6 col-sm-6 col-xs-6">
                                <input type="text" id="editTitle" disabled="disabled" style="height: 40px;width: 100%;">
                            </div>
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <label>时间:  </label>
                            </div>
                            <div class="col-md-2 col-sm-2 col-xs-2">
                                <input type="text" id="editTime" disabled="disabled" style="height: 40px;width: 100%;">
                            </div>
                            <div class="col-md-1 col-sm-1 col-xs-1"></div>
                        </div>
                        <div class="row" style="margin-top: 30px;">
                            <div class="col-md-1 col-sm-1 col-xs-1"></div>
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <label>图片链接:  </label>
                            </div>
                            <div class="col-md-9 col-sm-9 col-xs-9">
                                <input type="text" id="editImg" style="height: 40px;width: 100%;">
                            </div>
                            <div class="col-md-1 col-sm-1 col-xs-1"></div>
                        </div>
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
        $("#news").attr("class", "active-menu");
    </script>

    <script type="text/javascript">
        $("#newButton").click(function(){
            if( $("#newSelect").val() == "" || $("#newImg").val() == "" ){
                alert("请填写完整！");
                return;
            }

            var str = {};
            str["name"] = $("#newSelect").val();
            str["img"] = $("#newImg").val();

            $.ajax({                    //获得各个区域的值
                type:"post",
                async: false, //同步执行
                url:"/manageMainNews/add",
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
        function objDelete(id) {

            var str = {};
            str["id"] = id;

            $.ajax({                    //获得各个区域的值
                type:"post",
                async: false, //同步执行
                url:"/manageMainNews/delete",
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

            $("#editId").val($(this).attr("value"));

            var tr = $(this).parent().parent().children();

            $("#editTitle").val(tr.get(1).innerHTML);
            $("#editTime").val(tr.get(3).innerHTML);
            $("#editImg").val(tr.get(2).innerHTML);

            $("#editModal").modal('show');
        });
    </script>

    <script type="text/javascript">
        $("#editButton").click(function(){
            if( $("#editImg").val() == ""){
                alert("请填写完整！");
                return;
            }

            var str = {};
            str["id"] = $("#editId").val();
            str["href"] = $("#editImg").val();

            $.ajax({                    //获得各个区域的值
                type:"post",
                async: false, //同步执行
                url:"/manageMainNews/edit",
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
