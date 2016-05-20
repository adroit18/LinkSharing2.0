<!DOCTYPE html>
<!--[if lt IE 7 ]> <!--<html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]> <!--   <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]> <!--   <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]> <!--   <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-- <html lang="en" class="no-js"><!--<![endif]-->
<head>

    <!--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
-->
    <title>Link Sharing <g:layoutTitle/></title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <asset:javascript src="application.js"/>
    <asset:stylesheet src="bootstrap.min.css"/>
    <asset:stylesheet src="bootstrap-theme.min.css"/>
    <asset:stylesheet src="glyphicons-halflings-regular.woff2"/>
    <asset:stylesheet src="glyphicons-halflings-regular.ttf"/>
    <asset:stylesheet src="glyphicons-halflings-regular.woff"/>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

    <style>

    a {
        text-decoration: underline;
    }

    .btn:focus {
        outline: none;
        background-color: orange;
    }



    </style>

    <script>
        $(document).ready(function () {
            $("#srch-term").keypress(function () {
                $("#pag").load("/resource/search", {"q": $("#srch-term").val(), "flag": 1});
            });
        });

    </script>








    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/datepicker3.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet">
    <script src="/js/jquery-1.11.1.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/chart.min.js"></script>
    <script src="/js/chart-data.js"></script>
    <script src="/js/easypiechart.js"></script>
    <script src="/js/easypiechart-data.js"></script>
    <script src="/js/bootstrap-datepicker.js"></script>










    <!--Icons-->
    <script src="/js/lumino.glyphs.js"></script>

    <!--[if lt IE 9]>
<script src="/js/html5shiv.js"></script>
<script src="/js/respond.min.js"></script>
<![endif]-->





    <webcam:head/>
 <g:layoutHead/>
</head>

<body>

<div class="row">
    <nav class="col-xs-12 navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">

                <div class=" col-xs-4">
                <g:link controller="login" action="index"
                        style="font-style:italic;font-family: 'Lucida Grande, Verdana, sans-serif';font-size:350%;text-decoration: blink">
                    <span style="color: #0e0e0e">link sharing</span>
                </g:link>
                <span style="font-size: 7px">
                    Contribute to Community of knowledge</span>
                </div>



                <g:if test="${session.user}">
                    <div class="col-xs-3">

                        <g:form controller="resource" action="search" class="navbar-form">
                            <div class="input-group" style="background: white">
                                <g:textField type="text" class="form-control" placeholder="Search" name="q"
                                             id="srch-term"/>
                                <div class="input-group-btn" style="background: green">
                                    <g:submitButton name="searchsubmit" class="btn " type="submit"
                                                    value="Search"/>
                                </div>
                            </div>
                        </g:form>
                    </div>
                </g:if>

                <g:else>
                    <div class="col-xs-6 pull-right">

                        <g:form controller="resource" action="search" class="navbar-form">
                            <div class="input-group" style="background: white">
                                <g:textField type="text" class="form-control" placeholder="Search" name="q"
                                             id="srch-term"/>
                                <div class="input-group-btn" style="background: green">
                                    <g:submitButton name="searchsubmit" class="btn " type="submit"
                                                    value="Search"/>
                                </div>
                            </div>
                        </g:form>
                    </div>
                </g:else>

                <g:if test="${session.user}">
                    <div class="col-xs-5">
                        <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#myModal4"
                                style="border:none;background:whitesmoke;color:black">
                            <div class="glyphicon glyphicon-comment"></div></button>
                        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal1"
                                style="border:none;background:whitesmoke;color:black"><div
                                class="glyphicon glyphicon-envelope"></div></button>
                        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal2"
                                style="border:none;background:whitesmoke;color:black"><div
                                class="glyphicon glyphicon-paperclip"></div></button>
                        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal3"
                                style="border:none;background:whitesmoke;color:black"><div
                                class="glyphicon glyphicon-edit"></div></button>

                                        </div></g:if>
            </div>

            </div>
        </div>

    </nav>
</div>

<br><br>

<div class="row">
    <div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar">

        <g:form role="search" controller="User" action="searchFrnds">
            <div class="form-group">
                <input type="text" class="form-control" placeholder="search friends....." name="name" id="name">
            </div>
        </g:form>


        <ul class="nav menu">
            <li><a href="/login/index"><svg class="glyph stroked dashboard-dial"><use
                    xlink:href="#stroked-dashboard-dial"></use></svg> Dashboard</a></li>
            <li><a href="/login/recentShares"><svg class="glyph stroked calendar"><use xlink:href="#stroked-calendar"></use>
            </svg> Recent Shares</a></li>
            <li><a href="/login/topPosts"><svg class="glyph stroked line-graph"><use xlink:href="#stroked-line-graph"></use>
            </svg> Top Posts</a></li>
            <li><g:link controller="login" action="inboxData"><svg class="glyph stroked table"><use xlink:href="#stroked-table"></use>
            </svg> Inbox
            </g:link></li>
            <li><a href="/login/subscriptions"><svg class="glyph stroked pencil"><use xlink:href="#stroked-pencil"></use>
            </svg> Subscriptions
            </a></li>
            <li class="active"><a href="/login/trendingTopics"><svg class="glyph stroked app-window"><use
                    xlink:href="#stroked-app-window"></use></svg> Trending Topics </a></li>


            <li role="presentation" class="divider"></li>


            <g:if test="${session.user?.isAdmin}">

                <li class="active"><a href="/user/userTable"><svg class="glyph stroked star"><use
                    xlink:href="#stroked-star"></use></svg> Users List </a></li>

            </g:if>


            <li><g:link url="/util/uiftest"><svg class="glyph stroked male-user"><use xlink:href="#stroked-male-user"></use>
            </svg> Login Page</g:link></li>

            <li><g:link url="/j_spring_security_logout"><svg class="glyph stroked male-user"><use xlink:href="#stroked-male-user"></use>
            </svg> Logout</g:link></li>

            <div id="SuccessMsg" title="Dialog Title"
                 style="display:none;color: black;font-size: 15px;background:lightcoral"></div>

            <div id="ErrorMsg" title="Dialog Title"
                 style="display:none;color: black;font-size: 15px;background: palegreen"></div>
            %{--<g:render template="/user/updateMessage"/>--}%
        </ul>


    </div><!--/.sidebar-->
</div>
<g:layoutBody/>
</body>
</html>
