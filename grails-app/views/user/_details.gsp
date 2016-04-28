<div class="panel panel-default" style="padding:8px;border:10px inset yellowgreen;">
%{--<g:set value="${userDetails}" var="details">--}%
<div class="panel-body">
    <div class="col-xs-2">
%{--<g:include controller="user" action="userImage" params='[username: "${session.user.username}"]'/>--}%
<img src="${g.createLink(controller: 'user', action: 'image', params: [id: session.user.id])}" width="65px"
     height="65px"/>
</div>

<div class="col-xs-10" style="font-style: italic">

    <g:if test="${session.user.username.startsWith('facebook_')}">
        <%=" Welcome, " + session.user.firstName+" "+ session.user.lastName%>
    </g:if>
    <g:elseif test="${session.user.username.startsWith('google_')}">
        <%=" Welcome, " + session.user.firstName+" "+ session.user.lastName%>
    </g:elseif>
    <g:else>
    <%=" Welcome, " + session.user.firstName+" "+ session.user.lastName%>
    </g:else>

    <span class="text-muted"><br><%=session.user.emailId%><br>
        <span class="col-xs-6" style="padding-left:1px">Subscriptions</span><span class="col-xs-6"
                                                                                  style="padding-left:1px">Topics</span><br>
    </span>

    <span class="col-xs-6" style="color:blue;padding-left:1px"><ls:subscriptionCount
            user="${session.user.username}"/></span>
    <span class="col-xs-6" style="color:blue;padding-left:1px"><ls:topicCount user="${session.user}"/></span>
    </div>
</div>
</div>