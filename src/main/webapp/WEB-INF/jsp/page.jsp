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
                    <div class="content">
                        <c:forEach items="${list}" var="obj" varStatus="status">
                            <c:if test="${!status.first}">
                                <hr style="margin-top: 10px;margin-bottom: 10px;" color="gray" />
                            </c:if>
                            <h5>
                                <a href="/content?type=${prefix}&id=${obj.id}" style="color: darkgray;">${obj.title}</a>
                            </h5>
                        </c:forEach>
                    </div>
                    <div class="divide-page" align="center">
                        <nav aria-label="...">
                            <ul id="page" class="pagination">
                                <%--前一页按钮--%>
                                <c:if test="${currentPage==1}">
                                    <li><a class="disabled">&lt;</a></li>
                                </c:if>
                                <c:if test="${currentPage!=1}">
                                    <li><a href="/page?prefix=${prefix}&page=${currentPage-1}">&lt;</a></li>
                                </c:if>
                                <%--页码按钮--%>
                                <c:if test="${pageNum<=7}">
                                    <c:forEach begin="1" end="${pageNum}" var="page">
                                        <c:if test="${currentPage==page}">
                                            <li class="active"><a>${page}</a></li>
                                        </c:if>
                                        <c:if test="${currentPage!=page}">
                                            <li><a href="/page?prefix=${prefix}&page=${page}">${page}</a></li>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${pageNum>7}">
                                    <c:if test="${currentPage<=4}">
                                        <c:forEach begin="1" end="5" var="page">
                                            <c:if test="${currentPage==page}">
                                                <li class="active"><a>${page}</a></li>
                                            </c:if>
                                            <c:if test="${currentPage!=page}">
                                                <li><a href="/page?prefix=${prefix}&page=${page}">${page}</a></li>
                                            </c:if>
                                        </c:forEach>
                                        <li class="disabled"><a>...</a></li>
                                        <li><a href="/page?prefix=${prefix}&page=${pageNum}">${pageNum}</a></li>
                                    </c:if>
                                    <c:if test="${currentPage>4 && currentPage<(pageNum-3)}">
                                        <li><a href="/page?prefix=${prefix}&page=1">1</a></li>
                                        <li class="disabled"><a>...</a></li>
                                        <li><a href="/page?prefix=${prefix}&page=${currentPage-1}">${currentPage-1}</a></li>
                                        <li class="active"><a>${currentPage}</a></li>
                                        <li><a href="/page?prefix=${prefix}&page=${currentPage+1}">${currentPage+1}</a></li>
                                        <li class="disabled"><a>...</a></li>
                                        <li><a href="/page?prefix=${prefix}&page=${pageNum}">${pageNum}</a></li>
                                    </c:if>
                                    <c:if test="${currentPage>=(pageNum-3)}">
                                        <li><a href="/page?prefix=${prefix}&page=1">1</a></li>
                                        <li class="disabled"><a>...</a></li>
                                        <c:forEach begin="${pageNum-4}" end="${pageNum}" var="page">
                                            <c:if test="${currentPage==page}">
                                                <li class="active"><a>${page}</a></li>
                                            </c:if>
                                            <c:if test="${currentPage!=page}">
                                                <li><a href="/page?prefix=${prefix}&page=${page}">${page}</a></li>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </c:if>
                                <%--页码按钮--%>
                                <c:if test="${currentPage==pageNum}">
                                    <li class="disabled"><a>&gt;</a></li>
                                </c:if>
                                <c:if test="${currentPage!=pageNum}">
                                    <li><a href="/page?prefix=${prefix}&page=${currentPage+1}">&gt;</a></li>
                                </c:if>
                            </ul>
                        </nav>
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
