<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: geminit
  Date: 2018/5/9
  Time: 下午8:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="background.jsp"></jsp:include>

<script src="/js/manage.js"></script>

<link rel="stylesheet" type="text/css" href="/css/back/manage.css">

<div id="page-wrapper" class="content-wrapper">
    <div class="row" style="padding-top: 50px"></div>
    <div class="row" style="margin-top: 40px">
        <div class="col-md-1 col-sm-1 col-xs-1"></div>
        <div class="col-md-10 col-sm-10 col-xs-10">
            <table class="table table-bordered" border="1" id="table-user">
                <tr align="center">
                    <td class="success" width="20%"><label>名称</label></td>
                    <td class="success" width="60%"><label>内容</label></td>
                    <td class="success" width="20%"><label>操作</label></td>
                </tr>
                <tr class="table-bordered" align="center">
                    <td>法律声明</td>
                    <td>${lawStatement}</td>
                    <td>
                        <button class="btn btn-warning" onclick="edit('lawStatement')">编辑</button>
                    </td>
                </tr>
                <tr class="table-bordered" align="center">
                    <td>隐私保护</td>
                    <td>${privacyProtection}</td>
                    <td>
                        <button class="btn btn-warning" onclick="edit('privacyProtection')">编辑</button>
                    </td>
                </tr>
                <tr class="table-bordered" align="center">
                    <td>网站地图</td>
                    <td>${websiteMap}</td>
                    <td>
                        <button class="btn btn-warning" onclick="edit('websiteMap')">编辑</button>
                    </td>
                </tr>
                <tr class="table-bordered" align="center">
                    <td>联系我们</td>
                    <td>${contactUs}</td>
                    <td>
                        <button class="btn btn-warning" onclick="edit('contactUs')">编辑</button>
                    </td>
                </tr>
            </table>
        </div>
        <div class="col-md-1 col-sm-1 col-xs-1"></div>
    </div>

    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabelEdit"></h4>
                </div>
                <div class="modal-body">
                    <div class="form-inline">
                        <div class="row" style="margin-top: 30px;">
                            <div class="col-md-1 col-sm-1 col-xs-1">
                                <input id="editPrefix" style="display: none">
                            </div>
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
        function edit(type){
            switch (type){
                case "lawStatement":
                    $("#editPrefix").val("lawStatement");
                    $("#editContent").val(${lawStatement});
                    break;
                case "privacyProtection":
                    $("#editPrefix").val("privacyProtection");
                    $("#editContent").val(${privacyProtection});
                    break;
                case "websiteMap":
                    $("#editPrefix").val("websiteMap");
                    $("#editContent").val(${websiteMap});
                    break;
                case "contactUs":
                    $("#editPrefix").val("contactUs");
                    $("#editContent").val(${contactUs});
                    break;
            }

            $("#editModal").modal('show');
        }
    </script>

    <script type="text/javascript">
        $("#editButton").click(function(){
            if( $("#editContent").val() == "" ){
                alert("请填写完整！");
                return;
            }

            var str = {};
            str["prefix"] = $("#editPrefix").val();
            str["content"] = $("#editContent").val();

            $.ajax({                    //获得各个区域的值
                type:"post",
                async: false, //同步执行
                url:"/manageAboutUs/edit",
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
