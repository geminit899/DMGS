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
                <input type="button" class="login-btn" value="登录"/>
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
    </div>
    <!-- //header end -->
</body>
</html>
