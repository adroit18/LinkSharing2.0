<head>
    <meta name="layout" content="index"/>
</head>



<script>
    $(document).delegate(".subscribe","click",function () {
        var link = $(this)
        var topicId = $(this).attr('id')
        $.ajax({
            url: "${createLink(controller: 'subscription',action: 'saveTopic')}",
            type: "post",
            dataType: 'json',
            data: {id: topicId},

            success: function (data) {
                data.status == true ? $("#SuccessMsg").show().delay(2000).fadeOut().text('Subscription saved Successfully')
                        : $("#ErrorMsg").show().delay(2000).fadeOut().text('Subscription could not be saved');

                $(link).replaceWith(data.message)
            },

            error: function (xhr) {
                alert(xhr.responseText);
            }

        });


    });

    $(document).delegate(".unsubscribe","click",function () {
        var link = $(this)
        var topicId = $(this).attr('id')
        $.ajax({
            url: "${createLink(controller: 'subscription',action: 'delete')}",
            type: "post",
            dataType: 'json',
            data: {id: topicId},
            success: function (data) {
                data.status == true ? $("#SuccessMsg").show().delay(2000).fadeOut().text('Subscription Deleted Successfully')
                        : $("#ErrorMsg").show().delay(2000).fadeOut().text('Subscription Not Found');
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
</script>

<%@ page import="com.tothenew.linksharing.*" %>


<div class="col-xs-4"></div>

<div class="panel col-xs-7 ">
    <div class="panel-heading"><h3 style="text-align:center;text-decoration-style:wavy;
    font-style: italic">Trending Topics</h3>

%{--<div class="pagination">--}%
%{--<g:paginate total="${trendingTopics}"/>--}%
%{--</div>--}%

    <g:each in="${trendingTopics}" var="trending" status="i">


            <div class="panel">
                <div class="panel-heading panel-title">

                    <g:link value="topic" url="[controller: 'topic', action: 'index', params: [id: trending.id]]"
                            class="col-xs-8"
                            style="text-decoration:none">${i+1}. ${trending.name}</g:link>

                </div>
<br>
                <div class="panel-body">

                    <div class="col-xs-2 pull-${i % 2 == 0 ? 'right' : 'left'}" >
                        <img src="${g.createLink(controller: 'user', action: 'image', params: [id: trending.createdBy.id])}"
                             width="65px" height="65px"/>

                        <g:include controller="user" action="userImage" params='[username: "${trending.createdBy}"]'/>

                    </div>

                    <div class="col-xs-10 pull-left">
                        <br>
                        <span class="col-xs-4 text-muted">@${trending.createdBy}</span>
                        <span class="col-xs-4" style="padding-left:1px">Subscriptions</span>
                        <span class="col-xs-4" style="padding-left:1px">Posts</span><br>
                        <span class="col-xs-4" style="color:blue;">

                            <g:if test="${session.user}">
                                <div data-id="tre">
                                    <ls:showSubscribe topicId="${trending.id}"/>
                                </div>
                            </g:if>
                        </span>
                        %{--<span class="col-xs-4" style="color:blue;padding-left:1px">${trending.count}</span>--}%

                        <span class="col-xs-4" style="color:blue;padding-left:1px"><ls:subscriptionCount
                                topicId="${trending.id}" user="${trending.createdBy}"/>
                        </span>
                        <span class="col-xs-2" style="color:blue;padding-left:1px"><ls:resourceCount
                                topicId="${trending.id}"/>
                        </span>

                    </div>
                    <br><br><br><br>

                </div>

            </div>

            <div class="col-xs-12"><hr style="border-width:3px;padding:0px;border-color:darkgrey">
            </div>

        </>
    </g:each>
</div>



<g:render template="/documentResource/create" model="[subscribed: subscribedTopics]"/>
<g:render template="/topic/create"/>
<g:render template="/topic/email"/>
<g:render template="/linkResource/create" model="[subscribed: subscribedTopics]"/>




