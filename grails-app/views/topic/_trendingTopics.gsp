<head>
    <script>
        $(".subscribe").click(  function () {
            var link = $(this)
            var topicId = $(this).attr('id')
            $.ajax({
                url: "${createLink(controller: 'subscription',action: 'saveTopic')}",
                type: "post",
                dataType: 'json',
                data: {id: topicId},

                success: function (data) {
                    data.status == true ? alert('Subscription saved Successfully') : alert('Subscription could not be saved')
                    $(link).replaceWith(data.message)
                },

                error: function (xhr) {
                    alert(xhr.responseText);
                }

            });


        });

        $(".unsubscribe").click(  function () {
            var link = $(this)
            var topicId = $(this).attr('id')
            $.ajax({
                url: "${createLink(controller: 'subscription',action: 'delete')}",
                type: "post",
                dataType: 'json',
                data: {id: topicId},
                success: function (data) {
                    data.status == true ? alert('Subscription Deleted Successfully') : alert('Subscription Not Found')

                    if ((($(link).parent("#sub")).size()) != 0) {
                        $(link).parents(".panel-body").remove()
                    }
                    else
                        $(link).replaceWith(data.message)

                },
                error: function (xhr) {
                    alert(xhr.responseText);
                }

            });


        });
        $('#loadingDiv').hide()  // Hide it initially
                .ajaxStart(function() {
                    $(this).show();
                })
                .ajaxStop(function() {
                    $(this).hide();
                });

    </script>
</head>
<%@ page import="com.tothenew.linksharing.*" %>
%{--//trending topics--}%
<div class="panel panel-default" style="padding:8px;border:10px inset yellowgreen;">
    <div class="panel-heading" style="border-bottom:3px;border:5px double green;">Trending Topics
        <div class="pull-right">
            <g:link controller="topic" action="viewAllTrend" style="text-decoration:underline">View ALL</g:link></div>
    </div>


%{--<div class="pagination">--}%
%{--<g:paginate total="${trendingTopics}" />--}%
%{--</div>--}%
<div  ><img src="/images/img.gif"/> </div>
    <g:each in="${trendingTopics}" var="trending" status="i">
        <g:if test="${i < 4}">

            <div class="panel-body">

                <div class="col-xs-2">
                    <img src="${g.createLink(controller: 'user', action: 'image', params: [id: trending.createdBy.id])}"
                         width="65px" height="65px"/>
                    %{--<g:include controller="user" action="userImage" params='[username: "${trending.createdBy}"]'/>--}%
                </div>

                <div class="col-xs-10 pull-left">
                    <g:link value="topic" url="[controller: 'topic', action: 'index', params: [id: trending.id]]"
                            class="col-xs-8"
                            style="text-decoration:underline">${trending.name}</g:link><br>
                    %{--<a href="#" class="col-xs-8" style="text:decoration:underline">${trending.name}</a></br></br>--}%
                    <span class="col-xs-4 text-muted">@${trending.createdBy}</span>
                    <span class="col-xs-4" style="padding-left:1px">Subscriptions</span>
                    <span class="col-xs-4" style="padding-left:1px">Posts</span><br>
                    <span class="col-xs-4" style="color:blue;">

                        <g:if test="${session.user}">
                            <div data-id="tre">
                                <ls:showSubscribe topicId="${trending.id}"/>
                            </div>
                        </g:if>
                    %{--<a href="#" style="text-decoration:underline">Unsubscribe</a>--}%
                    </span>
                    %{--<span class="col-xs-4" style="color:blue;padding-left:1px">${trending.count}</span>--}%
                    %{--<span class="col-xs-4" style="color:blue;padding-left:1px"> 50</span>--}%
                    <span class="col-xs-4" style="color:blue;padding-left:1px"><ls:subscriptionCount
                            topicId="${trending.id}" user="${trending.createdBy}"/>
                    </span>
                    <span class="col-xs-2" style="color:blue;padding-left:1px"><ls:resourceCount
                            topicId="${trending.id}"/>
                    </span>

                </div>
                <br><br><br><br>
                <hr style="border-width:3px;padding:0px;border-color:green">
                <hr style="border-width:3px;padding:0px;border-color:green">

            </div>
        </g:if>
    </g:each>
</div>