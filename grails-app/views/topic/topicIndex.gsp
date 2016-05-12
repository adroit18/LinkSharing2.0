<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="index"/>
    <title>Topic</title>
</head>

<body>
<div class="col-xs-3"></div>



<div class="col-xs-9">
    <g:render template="/user/show" model= "[users:users,topicName:topicName,resourceList:resourceList]"/>

</div>


</body>
</html>