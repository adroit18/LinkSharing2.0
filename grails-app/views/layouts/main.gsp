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
    <title><g:layoutTitle/>Link Sharing</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <asset:javascript src="application.js"/>
    <asset:stylesheet src="bootstrap.min.css"/>
    <asset:stylesheet src="bootstrap-theme.min.css"/>
    <asset:stylesheet src="glyphicons-halflings-regular.woff2"/>
    <asset:stylesheet src="glyphicons-halflings-regular.ttf"/>
    <asset:stylesheet src="glyphicons-halflings-regular.woff"/>


    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

    <style>

    body {
        background: url("/images/bw.jpg");
    }

    a {
        text-decoration: underline;
    }

    #search-panel {
        border: solid blueviolet;
        border-radius: 8px;
    }

    a {
        text-decoration: underline;
    }

    #search-panel {
        border: solid blueviolet;
        border-radius: 8px;
    }

    .btn:focus {
        outline: none;
    }

    .badge1 {
        position: relative;
    }

    .badge1[data-badge]:after {
        content: attr(data-badge);
        position: absolute;
        top: -10px;
        right: -10px;
        font-size: .7em;
        background: green;
        color: white;
        width: 18px;
        height: 18px;
        text-align: center;
        line-height: 18px;
        border-radius: 50%;
        box-shadow: 0 0 1px #333;
    }
    </style>

    <script>
        $(document).ready(function () {
            $("#srch-term").keypress(function () {
                $("#pag").load("/resource/search", {"q": $("#srch-term").val(), "flag": 1});
            });
        });

    </script>







    <g:layoutHead/>
    <webcam:head/>

</head>

<body>

<div class="container">
    <div class="row">
        <div class="col-xs-12">
            <div class="panel panel-default">
                <div class="panel-body" style="background-color:#fffdf8 ;border:3px dotted #000000;border-radius:8px">
                    <div class="col-xs-4">
                        <g:link controller="login" action="index"
                                style="font-family: 'Lucida Grande, Verdana, sans-serif';font-size:40px;text-decoration: blink">Link Sharing</g:link>
                    </div>


                    <g:if test="${session.user}">
                        <div class="col-xs-3">
                        %{--<div class="panel" id="search-panel">--}%
                            <g:form controller="resource" action="search" class="navbar-form">
                                <div class="input-group">
                                    <g:textField type="text" class="form-control" placeholder="Search" name="q"
                                                 id="srch-term"/>
                                    <div class="input-group-btn">
                                        <g:submitButton name="searchsubmit" class="btn btn-info" type="submit"
                                                        value="Search"/>
                                    </div>
                                </div>
                            </g:form>
                        %{--<div class="glyphicon glyphicon-search"></div>--}%

                        %{--<div class="badge pull-right">--}%
                        %{--<div class="glyphicon glyphicon-remove"></div>--}%
                        %{--</div>--}%
                        %{----}%
                        %{--<input type="text" placeholder="search" style="border:none">--}%
                        %{--</div>--}%
                        </div>
                    </g:if>

                    <g:else>
                        <div class="col-xs-6 pull-right">
                        %{--<div class="panel" id="search-panel">--}%
                        %{--<div class="glyphicon glyphicon-search"></div>--}%

                        %{--<div class="badge pull-right">--}%
                        %{--<div class="glyphicon glyphicon-remove"></div>--}%
                        %{--</div>--}%
                        %{--<input type="text" size="50px" placeholder="search" style="border:none">--}%
                        %{--</div>--}%
                            <g:form controller="resource" action="search" class="navbar-form">
                                <div class="input-group">
                                    <g:textField type="text" class="form-control" placeholder="Search" name="q"
                                                 id="srch-term"/>
                                    <div class="input-group-btn">
                                        <g:submitButton name="searchsubmit" class="btn btn-info" type="submit"
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

        </div>
    </div>
    <g:layoutBody/>
</body>
</html>
