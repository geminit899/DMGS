<%--
  Created by IntelliJ IDEA.
  User: geminit
  Date: 2018/5/8
  Time: 下午12:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta name="description" content="this is my page">

    <script src="/js/jquery-1.10.2.js"></script>
    <script src="/js/bootstrap.js"></script>

    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/css/front/util.css">
</head>
<body>
    <div class="container">

        <jsp:include page="util/header.jsp"></jsp:include>

        <!-- main body -->
        <div class="row">
            <!-- left side -->
            <div class="col-lg-3 col-md-3 col-sm-3">
                <div class="block input-group">
                    <input type="text" class="form-control" placeholder="搜索内容" aria-describedby="basic-addon2">
                    <span class="input-group-addon" id="basic-addon2">搜索</span>
                </div>
                <div class="block">
                    <div class="title row" style="margin: 0 0 0 0;">
                        <div class="col-lg-8 col-md-8 col-sm-8">
                            <h4 style="margin-top: 10px;">灾害监测</h4>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4"></div>
                    </div>
                    <div class="content">
                        <nav class="navbar-default navbar-side" role="navigation">
                            <div class="sidebar-collapse">
                                <ul class="nav" id="main-menu">
                                    <li id="temperature">
                                        <a href="/disaster?prefix=temperature">温度监测</a>
                                    </li>
                                    <li id="taifeng">
                                        <a href="/disaster?prefix=taifeng">台风监测</a>
                                    </li>
                                    <li id="pm2_5">
                                        <a href="/disaster?prefix=pm2_5">空气监测</a>
                                    </li>
                                    <li id="earthquake">
                                        <a href="/disaster?prefix=earthquake">地震监测</a>
                                    </li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                </div>
            </div>
            <!-- //left side -->
            <!-- right side -->
            <div class="col-lg-9 col-md-9 col-sm-9">
                <div class="block">
                    <div class="title row" style="margin: 0 0 0 0;">
                        <div class="col-lg-8 col-md-8 col-sm-8">
                            <h4 style="margin-top: 10px;">${type}</h4>
                        </div>
                    </div>
                    <div class="content" style="padding: 25px 25px 5px 20px;">
                        <jsp:include page="${prefix}.jsp"></jsp:include>
                    </div>
                </div>
            </div>
            <!-- //right side -->
        </div>
        <!-- //main body -->

        <jsp:include page="util/footer.jsp"></jsp:include>

    </div>

    <script>
        var id = "${prefix}";
        $("#" + id).attr("style", "background-color: lightslategray;");
    </script>

</body>
</html>
