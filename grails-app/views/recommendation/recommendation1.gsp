<head><meta name="layout" content="main"/></head>
<%@ page import="com.tothenew.linksharing.*" %>
Recommended Topics For You
<div class="panel panel-default" style="padding:8px;border:10px inset yellowgreen;">
    <div class="panel-heading" style="border-bottom:3px;border:5px double green;">

        <g:each in="${dataArray}" var="data" status="i">

            <div class="panel-body">

                <div class="col-xs-2">
                    <img src="${g.createLink(controller: 'user', action: 'image', params: [id: Topic.get(data).createdBy.id])}"
                         width="65px" height="65px"/>
                    <g:include controller="user" action="userImage" params='[username: "${Topic.get(data).createdBy}"]'/>
                </div>

                <div class="col-xs-10 pull-left">
                    <g:link value="topic" url="[controller: 'topic', action: 'index', params: [id: Topic.get(data).id]]"
                            class="col-xs-8"
                            style="text-decoration:underline">${Topic.get(data).name}</g:link>
                    &nbsp;&nbsp;


                    <span class="col-xs-12">Topic Related to "${Constants.PROFESSION_LIST[Topic.get(data).concernedArea]}"</span>


                    <span class="col-xs-4 text-muted">@${Topic.get(data).createdBy}</span>
                    <span class="col-xs-4" style="padding-left:1px">Subscriptions</span>
                    <span class="col-xs-4" style="padding-left:1px">Posts</span><br>
                    <span class="col-xs-4" style="color:blue;">

                        <g:if test="${session.user}">
                            <div data-id="tre">
                                <ls:showSubscribe topicId="${Topic.get(data).id}"/>
                            </div>
                        </g:if>
                    </span>
                    <span class="col-xs-4" style="color:blue;padding-left:1px"><ls:subscriptionCount
                            topicId="${Topic.get(data).id}" user="${Topic.get(data).createdBy}"/>
                    </span>
                    <span class="col-xs-2" style="color:blue;padding-left:1px"><ls:resourceCount
                            topicId="${Topic.get(data).id}"/>
                    </span>

                </div>
                <br><br><br><br>
                <hr style="border-width:3px;padding:0px;border-color:green">
                <hr style="border-width:3px;padding:0px;border-color:green">

            </div>

        </g:each>
    </div>
</div>