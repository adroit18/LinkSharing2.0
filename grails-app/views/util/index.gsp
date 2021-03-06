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
    <title>Link Sharing</title>

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






    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Lumino - Panels</title>

    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/datepicker3.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet">

    <!--Icons-->
    <script src="/js/lumino.glyphs.js"></script>

    <!--[if lt IE 9]>
<script src="/js/html5shiv.js"></script>
<script src="/js/respond.min.js"></script>
<![endif]-->





    <webcam:head/>

</head>

<body>

<div class="row">
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">

                <g:link controller="login" action="index"
                        style="font-style:italic;font-family: 'Lucida Grande, Verdana, sans-serif';font-size:50px;text-decoration: blink">
                    <span style="color: #0e0e0e">link sharing</span>
                </g:link>
                <span>
                    Contribute to Community of knowledge</span>



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
                        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal4"
                                style="border:none;background:none;color:black">
                            <div class="glyphicon glyphicon-comment"></div></button>
                        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal1"
                                style="border:none;background:none;color:black"><div
                                class="glyphicon glyphicon-envelope"></div></button>
                        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal2"
                                style="border:none;background:none;color:black"><div
                                class="glyphicon glyphicon-paperclip"></div></button>
                        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal3"
                                style="border:none;background:none;color:black"><div
                                class="glyphicon glyphicon-edit"></div></button>

                        <div class=" pull-right"><div class="dropdown">
                            <button class="btn btn-primary dropdown-toggle " type="button" id="dropdownMenu1"
                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"
                                    style="font-size: 18px;border:none"><div class="glyphicon glyphicon-user"></div>
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                    <g:if test="${session.user.isAdmin}">
                        <li><g:link controller="user" action="userTable">User List</g:link></li>
                    </g:if>
                    <li><g:link controller="user" action="editProfile"
                                params="[userId: session.user.id]">Profile</g:link></li>
                    <li>
                        <a href="/j_spring_security_logout">
                            %{--<g:link controller="login" action="logout">--}%
                            LogOut
                            %{--</g:link>--}%
                        </a>
                    </li>
                    <li role="separator" class="divider"></li>
                    </ul>
                </div>
                </div></g:if>
            </div>

            </div>
        </div>

    </nav>
</div>

<br><br>

<div class="row">
    <div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar">
        <div>
            <g:if test="${session.user}">

                <g:if test="${session.user.username.startsWith('facebook_')}">
                    <%=" Welcome, " + session.user.firstName + " " + session.user.lastName%>
                </g:if>
                <g:elseif test="${session.user.username.startsWith('google_')}">
                    <%=" Welcome, " + session.user.firstName + " " + session.user.lastName%>
                </g:elseif>
                <g:else>
                    <%=" Welcome, " + session.user.firstName + " " + session.user.lastName%>
                </g:else>
            </g:if>
            <g:else>

            </g:else>

        </div>

        <ul class="nav menu">
            <li><a href="index.html"><svg class="glyph stroked dashboard-dial"><use
                    xlink:href="#stroked-dashboard-dial"></use></svg> Dashboard</a></li>
            <li><a href="widgets.html"><svg class="glyph stroked calendar"><use xlink:href="#stroked-calendar"></use>
            </svg> Widgets</a></li>
            <li><a href="charts.html"><svg class="glyph stroked line-graph"><use xlink:href="#stroked-line-graph"></use>
            </svg> Charts</a></li>
            <li><a href="tables.html"><svg class="glyph stroked table"><use xlink:href="#stroked-table"></use>
            </svg> Tables
            </a></li>
            <li><a href="forms.html"><svg class="glyph stroked pencil"><use xlink:href="#stroked-pencil"></use>
            </svg> Forms
            </a></li>
            <li class="active"><a href="panels.html"><svg class="glyph stroked app-window"><use
                    xlink:href="#stroked-app-window"></use></svg> Alerts &amp; Panels</a></li>
            <li><a href="icons.html"><svg class="glyph stroked star"><use xlink:href="#stroked-star"></use></svg> Icons
            </a>
            </li>
            <li class="parent ">
                <a href="#">
                    <span data-toggle="collapse" href="#sub-item-1"><svg class="glyph stroked chevron-down"><use
                            xlink:href="#stroked-chevron-down"></use></svg></span> Dropdown
                </a>
                <ul class="children collapse" id="sub-item-1">
                    <li>
                        <a class="" href="#">
                            <svg class="glyph stroked chevron-right"><use xlink:href="#stroked-chevron-right"></use>
                            </svg> Sub Item 1
                        </a>
                    </li>
                    <li>
                        <a class="" href="#">
                            <svg class="glyph stroked chevron-right"><use xlink:href="#stroked-chevron-right"></use>
                            </svg> Sub Item 2
                        </a>
                    </li>
                    <li>
                        <a class="" href="#">
                            <svg class="glyph stroked chevron-right"><use xlink:href="#stroked-chevron-right"></use>
                            </svg> Sub Item 3
                        </a>
                    </li>
                </ul>
            </li>
            <li role="presentation" class="divider"></li>
            <li><g:link url="/util/uiftest"><svg class="glyph stroked male-user"><use xlink:href="#stroked-male-user"></use>
            </svg> Login Page</g:link></li>
        </ul>

    </div><!--/.sidebar-->
</div>
</body>
</html>
