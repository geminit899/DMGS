<%--
  Created by IntelliJ IDEA.
  User: geminit
  Date: 2018/5/18
  Time: 上午11:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>404 Not Found</title>

    <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
    <link rel="shortcut icon" href="favicon.ico">

    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,300' rel='stylesheet' type='text/css'>

    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/animate.css">
    <link rel="stylesheet" href="/css/404.css">


    <!-- Modernizr JS -->
    <script src="/js/modernizr-2.6.2.min.js"></script>
    <!-- FOR IE9 below -->
    <!--[if lt IE 9]>
    <script src="/js/respond.min.js"></script>
    <![endif]-->
    <script src="/js/jquery-1.10.2.js"></script>
    <script src="/js/bootstrap.js"></script>
    <!-- Vide -->
    <script src="/js/jquery.vide.min.js"></script>
    <!-- Waypoints -->
    <script src="/js/jquery.waypoints.min.js"></script>
    <!-- Main JS -->
    <script src="/js/main.js"></script>
</head>
<body>
    <div class="container fh5co-container">
        <div class="row">
            <div class="col-md-12 animate-box" data-animate-effect="fadeIn">
                <div class="fh5co-404-wrap" id="video" data-vide-bg="/video/Crocodile" data-vide-options="position: 0 50%">
                    <div class="overlay"></div>
                </div>
            </div>
            <div class="col-md-12 text-center fh5co-404-text animate-box"  data-animate-effect="fadeIn">
                <h2>Looks like you got lost.</h2>
                <p><a href="#" onClick="javascript :history.back(-1);" class="btn btn-primary">Go Back</a></p>
            </div>
            <div class="col-md-12 text-center fh5co-copyright animate-box" data-animate-effect="fadeInUp">
                <p><small>&copy; All Rights Reserved.</small></p>
            </div>
        </div>
    </div>
</body>
</html>
