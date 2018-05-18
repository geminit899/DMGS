<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="stylesheet" type="text/css" href="/css/front/aboutUs.css">
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
                            <h4 style="margin-top: 10px;">关于我们</h4>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4"></div>
                    </div>
                    <div class="content">
                        <nav class="navbar-default navbar-side" role="navigation">
                            <div class="sidebar-collapse">
                                <ul class="nav" id="main-menu">
                                    <li id="lawStatement">
                                        <a href="/aboutUs?prefix=lawStatement">法律声明</a>
                                    </li>
                                    <li id="privacyProtection">
                                        <a href="/aboutUs?prefix=privacyProtection">隐私保护</a>
                                    </li>
                                    <li id="websiteMap">
                                        <a href="/aboutUs?prefix=websiteMap">网站地图</a>
                                    </li>
                                    <li id="contactUs">
                                        <a href="/aboutUs?prefix=contactUs">联系我们</a>
                                    </li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                </div>
                <div class="block">
                    <div class="title row" style="margin: 0 0 0 0;">
                        <div class="col-lg-8 col-md-8 col-sm-8">
                            <h4 style="margin-top: 10px;">推荐新闻</h4>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <h4 style="margin-top: 10px;text-align: right;">
                                <a href="/page?prefix=news" style="color: white;">more...</a>
                            </h4>
                        </div>
                    </div>
                    <div class="content">
                        <c:forEach items="${leftSideMainNewsList}" var="mainNews" varStatus="status">
                            <h5>
                                <a href="/content?type=news&id=${mainNews.news_id}" style="color: darkgray;">${mainNews.title}</a>
                            </h5>
                            <c:if test="${!status.last}">
                                <hr style="margin-top: 10px;margin-bottom: 10px;" color="gray" />
                            </c:if>
                            <c:if test="${status.last}">
                                <hr style="margin-top: 10px;margin-bottom: 10px;" color="white" />
                            </c:if>
                        </c:forEach>
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
                    <div id="aboutUsDiv" class="content">
                        <h3 id="aboutUsH">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${content}</h3>
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
