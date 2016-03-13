<%--
  Created by IntelliJ IDEA.
  User: deepak
  Date: 27/2/16
  Time: 11:29 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main" />
    <title>Link Sharing</title>
</head>

<body>
<div class="col-xs-5">
%{--<g:each in="${userDetails}" var="details">--}%
    %{--sadfasdfadfadfadfafafass ${details[0]}</g:each>--}%
<g:render template="/user/details" />
<g:render template="/subscription/subscriptions" model="[subscriptionList:subscriptionList]" />
</div>

<div class="col-xs-7">
<ls:trendingTopics/>
%{--<g:render template="/topic/trendingTopics" model="[trendingTopicsList:trendingTopicsList]"/>--}%
<g:render template="/user/inbox" model="[inboxList:inboxList]"/>
</div>

<g:render template="/documentResource/create" model="[subscribed: subscribedTopics]"/>
<g:render template="/topic/create"/>
<g:render template="/topic/email"/>
<g:render template="/linkResource/create" model="[subscribed: subscribedTopics]"/>



</body>
</html>

