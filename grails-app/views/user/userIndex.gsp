<%--
  Created by IntelliJ IDEA.
  User: deepak
  Date: 27/2/16
  Time: 11:29 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="index"/>
    <title>Link Sharing</title>

</head>

<body>

<div class="col-xs-4"></div>

<div class="panel col-xs-7 ">
    <g:if test="${session.user.profession == 0}">

        <button type="button" class="alert bg-danger"
                data-toggle="modal" data-target="#myModalCompleteProfile">
            <svg class="glyph stroked cancel"><use xlink:href="#stroked-cancel"></use></svg>
            <a href="#" class="pull-right"><span class="glyphicon glyphicon-remove"></span>
                Click to complete your profile for better topic recommendations</a>

        </button>
        <g:render template="/user/completeProfile"/>
    </g:if>
    <g:else>
        <div style="text-decoration: none
        ;font-size: 10px">
            <g:link controller="topic" action="recommendationList" class="alert bg-success">
                <svg class="glyph stroked checkmark"><use xlink:href="#stroked-checkmark"></use></svg>
                Click to see recommended topics for You
            </g:link>
        </div>
    </g:else>


    <g:render template="/user/details"/>

</div>

<g:render template="/user/editProfile" model="[user: user, topicList: topicList, subsCount: subsCount]"/>


<g:render template="/documentResource/create" model="[subscribed: subscribedTopics]"/>
<g:render template="/topic/create"/>
<g:render template="/topic/email"/>
<g:render template="/linkResource/create" model="[subscribed: subscribedTopics]"/>

</body>
</html>

