<%@ page import="com.tothenew.linksharing.ResourceRating; com.tothenew.linksharing.Resource; com.tothenew.linksharing.Topic" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Search</title>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="col-xs-6">
            <!-- Topic Panel -->
            <!-- ************************************************** -->
            <ls:trendingTopics/>
            <ls:topPosts/>
            %{--<g:render template="/topic/trendingTopics" model="${[trendingTopics:Topic.trendingTopics]}"/>--}%
        </div>

        <div class="col-xs-6">
            <!-- Topic Posts Panel -->
            <!-- ************************************************ -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-4">
                            <strong>Search for "test"</strong></div>
                    </div>
                </div>

            <div class="panel-body">
                <g:each in="${searchResources}" var="resource">
                    <div>
                        <div class="col-xs-2">
                            <g:include controller="user" action="userImage"
                                       params='[username: "${resource?.createdBy?.username}"]'/>
                        </div>
                    </div>

                    <div class="col-xs-10">
                        <div class="row">
                            <div class="col-xs-4">
                                <span class="h5">${resource.createdBy.name}</span>
                                <small class="text-muted">@${resource.createdBy.username}</small>
                            </div>

                            %{--<div class="col-xs-3">--}%
                            %{--</div>--}%

                            <div class="col-xs-8">
                                <a href="#" class="text-left">${resource.topic.name}</a>
                            </div>
                        </div>

                        <p>${resource.description}</p>

                        <div class="row">
                            <div class="col-xs-2"><i class="fa fa-facebook-official"></i>
                                <i class="fa fa-tumblr"></i>
                                <i class="fa fa-google-plus"></i></div>

                            <div class="col-xs-2"><small><a href="#">Download</a></small></div>

                            <div class="col-xs-3"><small><a href="#">View Full Site</a></small></div>

                            <ls:markAsRead id="${resource.id}" query="${query}"/>
                            %{--<g:set var="1" value="session.user.username">--}%
                            %{--<g:set var="2" value="${resource.createdBy.username}">--}%
                            %{----}%
                            %{--</g:set>--}%
                            %{--</g:set>--}%
                            %{--<div class="col-xs-2"><small><a href="#">Mark as Read</a></small></div>--}%

                            <div class="col-xs-2"><small><a href="#">View Post</a></small></div>
                        </div>
                    </div>

                    <div class="col-xs-12"><hr style="border-width:3px;padding:0px;border-color:blue"></div>
                </g:each>
            </div>
        </div>
    </div>
</div>
<!-- Row 2 -->
%{--<div class="row">--}%
<div class="col-xs-6">
    <!-- Subscription Panel-->

    <!-- ************************************************************ -->
    %{--<g:render template="/topic/topPosts" model="${[topPosts:ResourceRating.getTopPosts()]}"/>--}%
</div>
%{--</div>--}%
</div>



<g:render template="/documentResource/create" model="[subscribed: subscribedTopics]"/>
<g:render template="/topic/create"/>
<g:render template="/topic/email"/>
<g:render template="/linkResource/create" model="[subscribed: subscribedTopics]"/>



</body>
</html>