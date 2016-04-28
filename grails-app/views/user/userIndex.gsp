<%--
  Created by IntelliJ IDEA.
  User: deepak
  Date: 27/2/16
  Time: 11:29 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Link Sharing</title>

</head>

<body>
<div class="col-xs-5">
    <g:if test="${session.user.profession == 0}">

        <button type="button" class="btn btn-info btn-lg"
                data-toggle="modal" data-target="#myModalCompleteProfile"
                style="border:none;background:none;color:red">
            <div class="glyphicon glyphicon-bullhorn">
            </div>
            <a href="#" class="badge1" data-badge="&nbsp;?"
               style="text-decoration: none;font-size:15px">Click to complete your profile for better topic recommendations</a>

        </button>
        <g:render template="/user/completeProfile"/>
    </g:if>
    <g:else>
        <g:link controller="topic" action="recommendationList" class="badge1" data-badge="&nbsp;!!"
           style="text-decoration: none;font-size:15px">Click to see recommended topics for You</g:link>
    </g:else>
    <g:render template="/user/details"/>
    <g:render template="/subscription/subscriptions" model="[subscriptionList: subscriptionList]"/>

</div>

<div class="col-xs-7">
    %{--<g:render template="/topic/trendingTopics" model="[trendingTopicsList:trendingTopicsList]"/>--}%
    <g:render template="/user/inbox" model="[inboxList: inboxList]"/>
    <ls:trendingTopics/>
</div>

<g:render template="/documentResource/create" model="[subscribed: subscribedTopics]"/>
<g:render template="/topic/create"/>
<g:render template="/topic/email"/>
<g:render template="/linkResource/create" model="[subscribed: subscribedTopics]"/>

</body>
</html>

