<div class="panel panel-default" style="border:3px solid darkviolet;border-radius:8px">
    %{--<g:set value="${userDetails}" var="details">--}%
    <div class="panel-body">
        <div class="col-xs-2">
            <g:include controller="user" action="userImage" params='[username: "${session.user.username}"]'/>
        </div>

        <div class="col-xs-10"><%="Welcome " + session.user.username%><span
                class="text-muted"><br><%=session.user.emailId%><br>
            <span class="col-xs-6" style="padding-left:1px">Subscriptions</span><span class="col-xs-6"
                                                                                      style="padding-left:1px">Topics</span><br>
        </span>

            <span class="col-xs-6" style="color:blue;padding-left:1px">${userDetails[0]}</span><span class="col-xs-6"
                                                                                                     style="color:blue;padding-left:1px">${userDetails[1]}</span>
        </div>
    </div>
</div>