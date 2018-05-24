<%--
  Created by IntelliJ IDEA.
  User: geminit
  Date: 2018/5/9
  Time: 上午11:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>DMGS后台管理</title>
    <meta name="description" content="this is my page">

    <script src="/js/jquery-1.10.2.js"></script>
    <script src="/js/bootstrap.js"></script>
    <script src="/js/background.js"></script>

    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/css/back/background.css">
</head>

<body>
<div id="wrapper">
    <nav class="navbar navbar-default top-navbar" role="navigation">
        <div class="navbar-header">
            <a class="navbar-brand" href="index.html"><strong>DMGS</strong></a>

            <div id="sideNav" href=""><i class="fa fa-caret-right"></i></div>
        </div>

        <ul class="nav navbar-top-links navbar-right">
            <!-- /.dropdown -->
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
                    <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-user">
                        <li><a href="#"><i class="fa fa-user fa-fw"></i> 亲爱的 ${user} 用户</a>
                    </li>
                    <li class="divider"></li>
                    <li><a href="/logout"><i class="fa fa-sign-out fa-fw"></i> 退出登录</a>
                    </li>
                </ul>
                <!-- /.dropdown-user -->
            </li>
            <!-- /.dropdown -->
        </ul>
    </nav>
    <!--/. NAV TOP  -->
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">
                <li>
                    <a id="disaster" href="#"><i class="fa fa-sitemap"></i> 灾害管理<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <li>
                            <a href="/manageDisaster?prefix=temperature">温度</a>
                        </li>
                        <li>
                            <a href="/manageDisaster?prefix=taifeng">台风</a>
                        </li>
                        <li>
                            <a href="/manageDisaster?prefix=pm2_5">PM2.5</a>
                        </li>
                        <li>
                            <a href="/manageDisaster?prefix=earthquake">地震</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a id="news" href="#"><i class="fa fa-sitemap"></i> 新闻管理<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <li>
                            <a href="/manage?prefix=news">所有新闻</a>
                        </li>
                        <li>
                            <a href="/manageMainNews">重点新闻</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a id="law" href="/manage?prefix=law"><i class="fa fa-desktop"></i> 政策管理</a>
                </li>
                <li>
                    <a id="share" href="/manageShare"><i class="fa fa-bar-chart-o"></i> 共享管理</a>
                </li>
                <li>
                    <a id="knowledge" href="/manage?prefix=knowledge"><i class="fa fa-qrcode"></i> 科普管理</a>
                </li>

                <li>
                    <a id="aboutUs" href="/manageAboutUs"><i class="fa fa-table"></i> 网站信息管理</a>
                </li>
            </ul>

        </div>

    </nav>
    <!-- /. NAV SIDE  -->


</div>
</body>

</html>