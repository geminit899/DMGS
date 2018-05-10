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
            <table class="table table-bordered" border="1" id="table-user">
                <tr align="center">
                    <td class="success" width="10%"><label>编号</label></td>
                    <td class="success" width="50%"><label>标题</label></td>
                    <td class="success" width="20%"><label>时间</label></td>
                    <td class="success" width="20%"><label>操作</label></td>
                </tr>
                <c:forEach items="${list}" var="obj">
                    <tr class="table-bordered" align="center">
                        <td>${obj.id}</td>
                        <td>${obj.title}</td>
                        <td>${obj.time}</td>
                        <td>
                            <button class="btn btn-warning" onclick="edit(${obj.id})">编辑</button>
                            <button class="btn btn-danger" onclick="objDelete(${obj.id})">删除</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <div class="col-md-1 col-sm-1 col-xs-1"></div>
    </div>
    <div class="row">
        <div class="col-md-1 col-sm-1 col-xs-1"></div>
        <div class="col-md-7 col-sm-7 col-xs-7">
            <a>总${totalNum}条&nbsp;&nbsp;&nbsp;每页10条&nbsp;&nbsp;&nbsp;共${pageNum}页&nbsp;&nbsp;&nbsp;当前第${currentPage}页</a>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3" style="text-align: right;">
            <nav>
                <ul class="pager" id="page-controller">
                    <li <c:if test="${currentPage==1}"> class="disabled"</c:if>><a href="/manage?prefix=${prefix}&page=${currentPage-1}">上一页</a></li>
                    <li <c:if test="${currentPage==pageNum}"> class="disabled"</c:if>><a href="/manage?prefix=${prefix}&page=${currentPage+1}">下一页</a></li>
                </ul>
            </nav>
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
                            <div class="col-md-1 col-sm-1 col-xs-1"></div>
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <label>标题:  </label>
                            </div>
                            <div class="col-md-6 col-sm-6 col-xs-6">
                                <input type="text" id="newTitle" style="height: 40px;width: 100%;">
                            </div>
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <label>时间:  </label>
                            </div>
                            <div class="col-md-2 col-sm-2 col-xs-2">
                                <input type="text" id="newTime" style="height: 40px;width: 100%;">
                            </div>
                            <div class="col-md-1 col-sm-1 col-xs-1"></div>
                        </div>
                        <div class="row" style="margin-top: 30px;">
                            <div class="col-md-1 col-sm-1 col-xs-1"></div>
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <label>内容:  </label>
                            </div>
                            <div class="col-md-9 col-sm-9 col-xs-9">
                                <textarea id="newContent" class="form-control" rows="10" style="width: 100%;"></textarea>
                            </div>
                            <div class="col-md-1 col-sm-1 col-xs-1"></div>
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
                                <input type="text" id="editTitle" style="height: 40px;width: 100%;">
                            </div>
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <label>时间:  </label>
                            </div>
                            <div class="col-md-2 col-sm-2 col-xs-2">
                                <input type="text" id="editTime" style="height: 40px;width: 100%;">
                            </div>
                            <div class="col-md-1 col-sm-1 col-xs-1"></div>
                        </div>
                        <div class="row" style="margin-top: 30px;">
                            <div class="col-md-1 col-sm-1 col-xs-1"></div>
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <label>内容:  </label>
                            </div>
                            <div class="col-md-9 col-sm-9 col-xs-9">
                                <textarea id="editContent" class="form-control" rows="10" style="width: 100%;"></textarea>
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
        var id = "${prefix}";
        $("#" + id).attr("class", "active-menu");
    </script>

    <script type="text/javascript">
        //获取当前时间，格式YYYY-MM-DD
        function getNowFormatDate() {
            var date = new Date();
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            var strDate = date.getDate();
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
            }
            return year + "-" + month + "-" + strDate;
        }

        $("#newTime").val(getNowFormatDate());
    </script>

    <script type="text/javascript">
        $("#newButton").click(function(){
            if( $("#newTitle").val() == "" || $("#newContent").val() == "" ){
                alert("请填写完整！");
                return;
            }

            var str = {};
            str["prefix"] = "${prefix}";
            str["title"] = $("#newTitle").val();
            str["content"] = $("#newContent").val();
            str["time"] = $("#newTime").val();

            $.ajax({                    //获得各个区域的值
                type:"post",
                async: false, //同步执行
                url:"/manage/add",
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
            str["prefix"] = "${prefix}";
            str["id"] = id;

            $.ajax({                    //获得各个区域的值
                type:"post",
                async: false, //同步执行
                url:"/manage/delete",
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
        function edit(id){

            var str = {};
            str["prefix"] = "${prefix}";
            str["id"] = id;

            $.ajax({                    //获得各个区域的值
                type:"post",
                async: false, //同步执行
                url:"/manage/getObj",
                data:str,
                success:function(result){
                    obj = eval(result);
                    code = obj.id;
                    title = obj.title;
                    content = obj.content;
                    time = obj.time;

                    $("#editId").val(code);
                    $("#editTitle").val(title);
                    $("#editContent").val(content);
                    $("#editTime").val(time);

                    $("#editModal").modal('show');
                }
            });
        }
    </script>

    <script type="text/javascript">
        $("#editButton").click(function(){
            if( $("#editTitle").val() == "" || $("#editContent").val() == "" ){
                alert("请填写完整！");
                return;
            }

            var str = {};
            str["prefix"] = "${prefix}";
            str["id"] = $("#editId").val();
            str["title"] = $("#editTitle").val();
            str["content"] = $("#editContent").val();
            str["time"] = $("#editTime").val();

            $.ajax({                    //获得各个区域的值
                type:"post",
                async: false, //同步执行
                url:"/manage/edit",
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
