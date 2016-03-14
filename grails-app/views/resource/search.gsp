<%@ page import="com.tothenew.linksharing.ReadingItem; com.tothenew.linksharing.ResourceRating; com.tothenew.linksharing.Resource; com.tothenew.linksharing.Topic" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Search</title>
    <head>
        <script>
            $(document).on("click", ".read", function () {
                var link = $(this)
                var id = $(this).attr('data-id')
                $.ajax({
                    url: "${createLink(controller: 'readingItem',action: 'changeIsRead')}",
                    type: "post",
                    dataType: 'json',
                    data: {id: id, isRead: true},

                    success: function (data) {
//                    data.status==true?alert(''):alert('Subscription could not be saved')
                        $(link).html(data.message);
                        window.location.reload();
                    },

                    error: function (xhr) {
                        alert(xhr.responseText);
                    }

                });


            });

            $(document).on("click", ".unread", function () {

                var link = $(this)
                var id = $(this).attr('data-id')
                $.ajax({
                    url: "${createLink(controller: 'readingItem',action: 'changeIsRead')}",
                    type: "post",
                    dataType: 'json',

                    data: {id: id, isRead: false},

                    success: function (data) {

//                    data.status==true?alert('Subscription Deleted Successfully'):alert('Subscription Not Found')

                        $(link).html(data.message);
                        window.location.reload();
                    },
                    error: function (xhr) {
                        alert(xhr.responseText);
                    }

                });


            });

        </script>

    </head>

<body>
<div class="container">
    <div class="row">
        <div class="col-xs-7">
            <!-- Topic Panel -->
            <!-- ************************************************** -->
            <ls:trendingTopics/>
            <ls:topPosts/>
            %{--<g:render template="/topic/trendingTopics" model="${[trendingTopics:Topic.trendingTopics]}"/>--}%
        </div>

        <div class="col-xs-5">
            <!-- Topic Posts Panel -->
            <!-- ************************************************ -->
            <div class="panel panel-default" style="padding:8px;border:10px outset yellowgreen;">
                <div class="panel-heading" style="border-bottom:3px;border:5px double green;">
                    <div class="row">
                        <div class="col-xs-4">
                            <strong>Search Results</strong></div>
                    </div>
                </div>
                %{--.....................................................................--}%

                <div class="panel-body">
                %{--<g:paginate total="${searchResources}" next="Forward" prev="Back" maxsteps="0"></g:paginate>--}%
                    <g:each in="${searchTopics}" var="topics">
                        <g:each in="${Resource.findAllByTopic(topics)}" var="resource">
                            <div>
                                <div class="col-xs-2">
                                    %{--<g:include controller="user" action="userImage"--}%
                                    %{--params='[username: "${resource?.createdBy?.username}"]'/>--}%
                                    <img src="${g.createLink(controller: 'user', action: 'image', params: [id: resource?.createdBy?.id])}"
                                         width="65px" height="65px"/>

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

                                        <g:link value="topic"
                                                url="[controller: 'topic', action: 'index', params: [id: resource?.topic?.id]]"
                                                style="text-decoration:underline">
                                            ${resource.topic.name}</g:link>

                                    </div>
                                </div>

                                <p>${resource.description}</p>

                                <div class="row">
                                    <div class="col-xs-2"><i class="fa fa-facebook-official"></i>
                                        <i class="fa fa-tumblr"></i>
                                        <i class="fa fa-google-plus"></i></div>

                                    <div class="col-xs-5">
                                        <g:if test="${resource?.whichResource().equals("Document")}">
                                            <g:link controller="DocumentResource" action="downloadDocument"
                                                    params="[fid: resource?.id]"
                                                    style="text-decoration:underline;font-size:10px">Download</g:link>
                                        </g:if>

                                        <g:elseif test="${resource?.whichResource().equals("Link")}">
                                            <a href="${resource.url}"
                                               style="text-decoration:underline;font-size:10px">View full site</a>
                                        </g:elseif>
                                    </div>
                                    %{--<% ReadingItem readingItem = ReadingItem.findByResourceAndUser(resource,session.user)--}%
                                    %{--//                                def ide = readingItem.id--}%
                                    %{--%>--}%
                                    %{--${readingItem.properties}--}%

                                    %{--<ls:markAsRead id="${ReadingItem.findByResource(resource).id}" query="${query}"/>--}%

                                    <div class="col-xs-2"><g:link controller="resource" action="show"
                                                                  params="[id: resource?.id]"
                                                                  style="text-decoration:underline;font-size:10px">View Post</g:link>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xs-12"><hr style="border-width:3px;padding:0px;border-color:green">
                                <hr style="border-width:3px;padding:0px;border-color:green"></div>
                        </g:each>
                    </g:each>
                </div>



































                %{--<....................................>--}%

                <div class="panel-body">
                %{--<g:paginate total="${searchResources}" next="Forward" prev="Back" maxsteps="0"></g:paginate>--}%
                    <g:each in="${searchResources}" var="resource">
                        <div>
                            <div class="col-xs-2">
                                %{--<g:include controller="user" action="userImage"--}%
                                %{--params='[username: "${resource?.createdBy?.username}"]'/>--}%
                                <img src="${g.createLink(controller: 'user', action: 'image', params: [id: resource?.createdBy?.id])}"
                                     width="65px" height="65px"/>

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

                                    <g:link value="topic"
                                            url="[controller: 'topic', action: 'index', params: [id: resource?.topic?.id]]"
                                            style="text-decoration:underline">
                                        ${resource.topic.name}</g:link>

                                </div>
                            </div>

                            <p>${resource.description}</p>

                            <div class="row">
                                <div class="col-xs-2"><i class="fa fa-facebook-official"></i>
                                    <i class="fa fa-tumblr"></i>
                                    <i class="fa fa-google-plus"></i></div>

                                <div class="col-xs-5">
                                    <g:if test="${resource?.whichResource().equals("Document")}">
                                        <g:link controller="DocumentResource" action="downloadDocument"
                                                params="[fid: resource?.id]"
                                                style="text-decoration:underline;font-size:10px">Download</g:link>
                                    </g:if>

                                    <g:elseif test="${resource?.whichResource().equals("Link")}">
                                        <a href="${resource.url}"
                                           style="text-decoration:underline;font-size:10px">View full site</a>
                                    </g:elseif>
                                </div>
                                %{--<% ReadingItem readingItem = ReadingItem.findByResourceAndUser(resource,session.user)--}%
                                %{--//                                def ide = readingItem.id--}%
                                %{--%>--}%
                                %{--${readingItem.properties}--}%

                                %{--<ls:markAsRead id="${ReadingItem.findByResource(resource).id}" query="${query}"/>--}%

                                <div class="col-xs-2"><g:link controller="resource" action="show"
                                                              params="[id: resource?.id]"
                                                              style="text-decoration:underline;font-size:10px">View Post</g:link>
                                </div>
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