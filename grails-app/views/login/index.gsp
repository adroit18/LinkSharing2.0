<%@ page import="java.awt.List; com.tothenew.linksharing.*" %>

<html>
<head>
    <meta name="layout" content="main"/>
    %{--<meta name="layout" content="Welcome"/>--}%
    <title>
Link Sharing
    </title>
    <style>
    .top {
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

    .head {
        border: solid blueviolet;
        border-bottom: none;
        border-top-left-radius: 8px;
        border-top-right-radius: 8px;
    }

    .bdy {
        border: solid blueviolet;
        border-bottom-left-radius: 8px;
        border-bottom-right-radius: 8px
    }

    .glyphicon-user {
        font-size: 60px;
        border: solid black;
    }
    </style>

</head>

<body>
<div class="container">
    <div class="col-xs-7">
        <g:render template="/resource/recentShares" model="[recentShares:recentShares]"/>
        %{--<g:render template="/topic/topPosts" model="[resourceList:resourceList]"/>--}%
        <ls:topPosts/>

    </div>

    <div class="col-xs-5">
        <g:render template="/user/login"/>
        <g:render template="/user/register"/>
    </div>
</div>
</body>
</html>