<%--
  Created by IntelliJ IDEA.
  User: geminit
  Date: 2018/5/8
  Time: 下午12:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Header</title>
    <script src="/js/md5.js"></script>

    <link rel="stylesheet" type="text/css" href="/css/front/header.css">
</head>
<body>
    <!-- header begin -->
    <div class="header">
        <div class="row">
            <div class="col-lg-1 col-md-1 col-sm-1"></div>
            <div class="col-lg-7 col-md-7 col-sm-7 logo">
                <img class="logo-pic" src="/img/logo.png" />
                <div class="logo-content">
                    <h3>灾害监测GIS平台</h3>
                    <h5>Disaster Monitoring GIS System</h5>
                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-3 login-div">
                <input type="button" class="login-btn" data-toggle="modal" data-target="#loginModal" value="登录"/>
            </div>
            <div class="col-lg-1 col-md-1 col-sm-1"></div>
        </div>

        <!-- navigation begin -->
        <div class="collapse navbar-collapse" style="padding-bottom: 5px;">
            <ul class="nav navbar-nav">
                <li class="cl-effect-7"><a href="/index">主页</a></li>
                <li class="cl-effect-7 scroll"><a href="/disaster?prefix=temperature">灾害监测</a></li>
                <li class="cl-effect-7 scroll"><a href="/page?prefix=news">新闻快讯</a></li>
                <li class="cl-effect-7 scroll"><a href="/page?prefix=law">政策法规</a></li>
                <li class="cl-effect-7 scroll"><a href="/share">数据分享</a></li>
                <li class="cl-effect-7 scroll"><a href="/page?prefix=knowledge">科普宣传</a></li>
                <li class="cl-effect-7 scroll"><a href="/aboutUs?prefix=lawStatement">关于我们</a></li>
            </ul>
        </div>
        <!-- //navigation end -->

        <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel">登录</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-inline">
                            <div class="row">
                                <div class="col-md-1 col-sm-1 col-xs-1"></div>
                                <div class="col-md-2 col-sm-2 col-xs-2">
                                    <label>用户名:  </label>
                                </div>
                                <div class="col-md-8 col-sm-8 col-xs-8">
                                    <input type="text" id="userName" style="height: 40px;width: 100%;">
                                </div>
                                <div class="col-md-1 col-sm-1 col-xs-1"></div>
                            </div>
                            <div class="row" style="margin-top: 30px;">
                                <div class="col-md-1 col-sm-1 col-xs-1"></div>
                                <div class="col-md-2 col-sm-2 col-xs-2">
                                    <label>密码:  </label>
                                </div>
                                <div class="col-md-8 col-sm-8 col-xs-8">
                                    <input type="password" id="password" style="height: 40px;width: 100%;">
                                </div>
                                <div class="col-md-1 col-sm-1 col-xs-1"></div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="loginBtn">登录</button>
                    </div>
                </div>
            </div>
        </div>

        <%--失败模态框--%>
        <div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title" id="myModalLabelError">失败</h4>
                    </div>
                    <div class="modal-body">用户名或密码错误!</div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">好的</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div>
    </div>
    <!-- //header end -->

    <script type="text/javascript">
        $("#loginBtn").click(function(){
            if( $("#userName").val() == "" || $("#password").val() == "" ){
                alert("用户名或密码为空！");
                return;
            }

            var userName = $("#userName").val();



            var formData = new FormData();
            formData.append("userName", userName);

            var xhr = new XMLHttpRequest();

            xhr.onload = function() {
                if (this.status == 200) {
                    var result = this.response;

                    if ( result != "error" ){
                        var salt = result;
                        var password = $("#password").val();
                        password = hex_md5(password + salt);

                        var str = {};
                        str["userName"] = userName;
                        str["password"] = password;

                        $.ajax({                    //获得各个区域的值
                            type:"post",
                            async: false, //同步执行
                            url:"/index/login",
                            data:str,
                            success:function(result){
                                if (result.toString() == "success"){
                                    window.location.href="/manageDisaster?prefix=temperature";
                                }else if (result.toString() == "error"){
                                    $('#errorModal').modal('show');
                                }
                            }
                        });
                    }else {
                        $('#errorModal').modal('show');
                    }
                }
            };

            xhr.open("POST", "/index/login/getSalt", true);
            xhr.send(formData);
        })
    </script>
</body>
</html>
