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
                <label>关键字: </label>
                <input type="text" class="form-control" id="name">
            </div>
            <button class="btn btn-primary" id="search-btn">搜索</button>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2" align="center">
            <button type="button" id="newResource" class="btn btn-primary">新增</button>
        </div>
        <div class="col-md-1 col-sm-1 col-xs-1"></div>
    </div>
    <div class="row" style="margin-top: 40px">
        <div class="col-md-1 col-sm-1 col-xs-1"></div>
        <div class="col-md-10 col-sm-10 col-xs-10">
            <table class="table table-bordered" border="1" id="table-user">
                <tr align="center">
                    <td class="success" width="80%"><label>名称</label></td>
                    <td class="success" width="20%"><label>操作</label></td>
                </tr>
                <c:forEach items="${list}" var="obj">
                    <tr class="table-bordered" align="center">
                        <td>${obj}</td>
                        <td>
                            <button class="btn btn-danger" onclick="objDelete('${obj}')">删除</button>
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

    <div id="uploadDiv" class="row" style="padding-top: 100px;display: none" align="center">
        <div class="col-md-1 col-sm-1 col-xs-1"></div>
        <div class="col-md-10 col-sm-10 col-xs-10">
            <input type="file" id="myFile" style="opacity: 0" multiple>
            <table class="table table-bordered" border="1">
                <tr align="center">
                    <td class="success" width="20%"><label>文件名</label></td>
                    <td class="success" width="10%"><label>文件类型</label></td>
                    <td class="success" width="10%"><label>文件大小</label></td>
                    <td class="success" width="10%"><label>上传速度</label></td>
                    <td class="success" width="30%"><label>上传进度</label></td>
                    <td class="success" width="20%"><label>操作</label></td>
                </tr>
                <tr class="table-bordered" align="center">
                    <td id="fileName">未选择文件</td>
                    <td id="fileType"></td>
                    <td id="fileSize"></td>
                    <td id="fileSpeed"></td>
                    <td>
                        <div class="progress">
                            <div id="filePercent" class="progress-bar" role="progressbar" aria-valuemax="100">
                                0%
                            </div>
                        </div>
                    </td>
                    <td>
                        <input type="button" id="fileUpload">
                        <input type="button" id="fileDelete" value='删除'>
                    </td>
                </tr>
            </table>
        </div>
        <div class="col-md-1 col-sm-1 col-xs-1"></div>
    </div>

    <script type="text/javascript">
        var id = "${prefix}";
        $("#" + id).attr("class", "active-menu");
    </script>

    <script type="text/javascript">
        $("#newResource").click(function () {
            $("#myFile").click();
        });
    </script>

    <script type="text/javascript">
        const BYTES_PER_CHUNK = 50 * 1024; // 每个文件切片大小定为50KB
        var file;
        var lastChunk, chunk;
        var state;
        var start, end;

        $("#myFile").on("change", function () {
            var files = document.getElementById("myFile").files;

            if ( files.length > 1 ){
                alert("请选择单个文件！");
                return;
            }

            file = files[0];

            $.ajax({                    //获得各个区域的值
                type:"post",
                async: false, //同步执行
                url:"/manageShare/check",
                data:{"name":file.name},
                success:function(result){
                    if (result.toString() == "success"){
                        // 计算文件大小
                        var fileSize = file.size > 1024
                            ? file.size / 1024  > 1024
                                ? file.size / (1024 * 1024) > 1024
                                    ? (file.size / (1024 * 1024 * 1024)).toFixed(2) + 'GB'
                                    : (file.size / (1024 * 1024)).toFixed(2) + 'MB'
                                : (file.size / 1024).toFixed(2) + 'KB'
                            : (file.size).toFixed(2) + 'B';


                        lastChunk = 1;
                        chunk = 1;
                        state = "pause";

                        $("#uploadDiv").attr("style", "padding-top: 100px;");
                        $("#fileName").html(file.name);
                        $("#fileType").html(file.type);
                        $("#fileSize").html(fileSize);
                        $("#fileSpeed").html("0.00B/s");
                        $("#fileUpload").attr("value", "立即上传");
                    }else if (result.toString() == "error"){
                        alert("已有同名文件，不能上传！");
                    }
                }
            });
        });

        $("#fileUpload").click(function(){
            if ( state == "pause" ) {
                state = "loading";
                $("#fileUpload").attr("value", "暂停上传");
                start = (chunk-1) * BYTES_PER_CHUNK;
                end = start + BYTES_PER_CHUNK;
                if(start < file.size) {
                    if(end > file.size) {
                        end = file.size;
                    }
                    uploadFile();
                }
            } else if ( state == "loading" ) {
                state = "pause";
                $("#fileUpload").attr("value", "继续上传");
            }
        });

        function uploadFile() {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function(){
                if(xhr.readyState == 4 && state != "pause") {
                    response = xhr.responseText;
                    if( response == "error" ) {
                        alert("文件上传有误，已暂停上传！");
                        state = "pause";
                        $("#fileUpload").attr("value", "继续上传");
                        return;
                    }
                    chunks = Math.ceil(file.size / BYTES_PER_CHUNK);
                    percent = 100*chunk/chunks;
                    if(percent > 100){
                        percent = 100;
                    }
                    $("#filePercent").html( parseInt(percent) + "%" );
                    $("#filePercent").attr("style", "width: " + parseInt(percent) +"%;");
                    // 如果所有文件切片都成功发送，发送文件合并请求。
                    if(percent == 100) {
                        state = "done";
                        $("#fileUpload").attr("value", "完成上传");
                        $("#fileUpload").attr("disabled", "disabled");
                        mergeFile();
                    }else{
                        start = end;
                        end = start + BYTES_PER_CHUNK;
                        chunk++;
                        if(start < file.size) {
                            if(end > file.size) {
                                end = file.size;
                            }
                            uploadFile();
                        }
                    }
                }
            };

            var slice = file.slice(start, end);

            var formData = new FormData();
            formData.append("slice", slice);
            formData.append("name", file.name);

            xhr.open("POST", "/manageShare/upload", true);
            xhr.send(formData);
        }

        function mergeFile() {
            var xhr = new XMLHttpRequest();

            xhr.onreadystatechange = function(){
                if( xhr.readyState == 4 ){
                    response = xhr.responseText;
                    if( response == "error" ) {
                        mergeFile();
                    }else{
                        window.location.reload();
                    }
                }
            }

            var formData = new FormData();
            formData.append("name", file.name);

            xhr.open("POST", "/manageShare/merge", true);
            xhr.send(formData);
        }

        var int=self.setInterval("clock()",1000);
        function clock()
        {
            num = (chunk - lastChunk) * BYTES_PER_CHUNK;
            num = num > 1024 ? num / 1024  > 1024 ? num / (1024 * 1024) > 1024 ?
                (num / (1024 * 1024 * 1024)).toFixed(2) + 'GB' : (num / (1024 * 1024)).toFixed(2) + 'MB' :
                (num / 1024).toFixed(2) + 'KB' : (num).toFixed(2) + 'B';
            $("#fileSpeed").html( num + "/s" );
            lastChunk = chunk;
        }
    </script>

    <script type="text/javascript">
        function objDelete(obj){
            deleteFileByName(obj);
        }

        $("#fileDelete").click(function () {
            deleteFileByName(file.name);
        });

        function deleteFileByName(name) {
            $.ajax({                    //获得各个区域的值
                type:"post",
                async: false, //同步执行
                url:"/manageShare/delete",
                data:{"name": name},
                success:function(result){
                    if (result.toString() == "success"){
                        window.location.reload();
                    }
                }
            });
        }
    </script>
</div>
