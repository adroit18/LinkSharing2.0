<%@ page import="com.tothenew.linksharing.Topic" %>
<div style="font-size:28px;font-style: italic;padding:8px;border:10px inset yellowgreen;"> Topic Name:"${topicName}" </div>
<br>

<div style="font-size: 28px;font-style: italic">Subscribed Users</div>
<g:each in="${users}" var="user">
    <div class="panel panel-default" style="padding:8px;border:2px dashed yellowgreen;">
        <div class="panel-heading" style="border-bottom:3px;border:5px double green;">${user?.firstName} ${user?.lastName}
        </div>

        <div class="panel-body">

            <div class="col-xs-4">
                %{--<g:include controller="user" action="userImage" params='[username: "${user.username}"]'/>--}%
                <img src="${g.createLink(controller: 'user', action: 'image', params: [id: user?.id])}" width="65px"
                     height="65px"/>
            </div>

            <div class="col-xs-8">${user?.firstName}<span class="text-muted"><br>@${user?.username}<br>
                <span class="col-xs-6" style="padding-left:1px">Subscriptions</span><span class="col-xs-6"
                                                                                          style="padding-left:1px">Posts</span><br>
            </span>
                <span class="col-xs-6" style="color:blue;padding-left:1px"><ls:subscriptionCount
                        topicId="${Topic.findByName(topicName).id}" user="${user?.id}"/></span><span class="col-xs-6"
                                                                                                     style="color:blue;padding-left:1px"><ls:resourceCount
                        topicId="${Topic.findByName(topicName).id}"/></span>

            </div>
        </div>
    </div>
</g:each>