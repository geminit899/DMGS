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
    <link rel="stylesheet" type="text/css" href="/css/front/content.css">
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
                            <h4 style="margin-top: 10px;">推荐新闻</h4>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <h4 style="margin-top: 10px;text-align: right;">
                                <a href="#" style="color: white;">more...</a>
                            </h4>
                        </div>
                    </div>
                    <div class="content">
                        <h5>
                            <a href="#" style="color: darkgray;">北京数字空间科技有限公司荣获2017年测绘科技进步一</a>
                        </h5>
                        <hr style="margin-top: 10px;margin-bottom: 10px;" color="gray" />
                        <h5>
                            <a href="#" style="color: darkgray;">中国风云四号A星正式投运为70个国家和地区提资料</a>
                        </h5>
                        <hr style="margin-top: 10px;margin-bottom: 10px;" color="white" />
                    </div>
                </div>
                <div class="block">
                    <div class="title row" style="margin: 0 0 0 0;">
                        <div class="col-lg-8 col-md-8 col-sm-8">
                            <h4 style="margin-top: 10px;">推荐新闻</h4>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <h4 style="margin-top: 10px;text-align: right;">
                                <a href="#" style="color: white;">more...</a>
                            </h4>
                        </div>
                    </div>
                    <div class="content">
                        <h5>
                            <a href="#" style="color: darkgray;">北京数字空间科技有限公司荣获2017年测绘科技进步一</a>
                        </h5>
                        <hr style="margin-top: 10px;margin-bottom: 10px;" color="gray" />
                        <h5>
                            <a href="#" style="color: darkgray;">中国风云四号A星正式投运为70个国家和地区提资料</a>
                        </h5>
                        <hr style="margin-top: 10px;margin-bottom: 10px;" color="white" />
                    </div>
                </div>
            </div>
            <!-- //left side -->
            <!-- right side -->
            <div class="col-lg-9 col-md-9 col-sm-9">
                <div class="block">
                    <div style="text-align: center;">
                        <h1 id="contentTitle">${obj.title}</h1>
                    </div>
                    <div style="text-align: right;">
                        <h5 id="contentTime">${obj.time}</h5>
                    </div>
                    <hr color="white" />
                    <div class="contentDiv">
                        <h3 id="contentH3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${obj.content}</h3>
                    </div>
                </div>
            </div>
            <!-- //right side -->
        </div>
        <!-- //main body -->

        <jsp:include page="util/footer.jsp"></jsp:include>

    </div>
</body>
</html>
