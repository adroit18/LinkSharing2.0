<%@ page import="com.tothenew.linksharing.*" %>
<div class="panel panel-default" style="border:3px solid blueviolet;border-radius:8px">
    <div class="panel-heading" style="border-bottom:3px solid blueviolet;">Subscriptions
        <div class="pull-right">
            <a href="#" style="text-decoration:underline">View ALL</a></div></div>


    <g:each in="${subscriptionList}" var="subscription">

        <div class="panel-body">

             <div class="col-xs-2">
        <g:include controller="user" action="userImage" params='[username: "${subscription[2]}"]'/>
        </div>

        <div class="col-xs-10 pull-left">

        <g:link value="topic" url="[controller: 'topic', action: 'index', params: [id: subscription[0]]]"
                class="col-xs-8"
                style="text-decoration:underline">${subscription[1]}</g:link>
    %{--<a href="#" class="col-xs-10"--}%
    %{--style="text:decoration:underline">${subscription[1]}</a>--}%
    %{----}%
        </br></br>
        <span class="col-xs-6 text-muted">@${subscription[2]}</span>
        <span class="col-xs-4" style="padding-left:1px">Subscriptions</span>
        <span class="col-xs-2" style="padding-left:1px">Topics</span><br>

        <span class="col-xs-6" style="color:blue;"><a href="#" style="text-decoration:underline">Unsubscribe</a>
        </span>
        <span class="col-xs-4" style="color:blue;padding-left:1px">${subscription[3]}</span>
        <span class="col-xs-2" style="color:blue;padding-left:1px">50</span>
        </div>

        <g:set var="1" value="${session.user.username}">
            <g:set var="2" value="${subscription[2]}">
                <g:if test="${1 == 2}">
                    <div class="col-xs-4"><select class="pull-right form-control">
                        <option>Public</option>
                        <option>Private</option>
                    </select></div>
                </g:if>
            </g:set></g:set>


        <g:if test="${session.user.isAdmin}">
            <div class="col-xs-4"><select class="pull-right form-control">
                <option>Public</option>
                <option>Private</option>
            </select></div>
        </g:if>




        <div class="col-xs-4"><select class="pull-right form-control" id="sel1">
            <option>Public</option>
            <option>Private</option>
            <option>Global</option>
            <option>Mid</option>
        </select></div>

        <div class="col-xs-4">

            <div class="glyphicon glyphicon-envelope"></div>

                %{--<g:if test="${1==2}">--}%
            <div class="glyphicon glyphicon-edit"></div>

            <div class="glyphicon glyphicon-trash"></div>
                    %{--</g:if>--}%

        </div>



        </br></br></br></br></br></br>

        <hr style="border-width:3px;padding:0px;border-color:blue">
        </div>

    </g:each>
</div>
