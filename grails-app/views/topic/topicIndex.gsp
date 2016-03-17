<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Topic</title>
</head>

<body>
<div class="col-xs-1"></div>

%{--<div class="col-xs-4">--}%
    <g:render template="/user/show" model= "[users:users,topicName:topicName,resourceList:resourceList]"/>
%{--</div>--}%

<div class="col-xs-6">

</div>

<div class="col-xs-1"></div>
</body>
</html>