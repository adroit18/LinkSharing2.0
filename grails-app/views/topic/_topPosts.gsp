<%@ page import="com.tothenew.linksharing.*" %>

<div class="panel panel-default" style="padding:8px;border:10px outset yellowgreen;">
    <div class="panel-heading head" id="topPosts" style="border-bottom:3px;border:5px double green;">
        Top Posts


    </div>

<g:each in="${resourceList}" var="resource">
    <div class="panel-body bdy">
        <div class="row">
            <div class="col-xs-2">
                %{--<g:include controller="user" action="userImage" params='[username: "${resource[4]}"]'/>--}%
                <img src="${g.createLink(controller: 'user', action: 'image', params:[id:resource[4].id])}" width="65px" height="65px"/>
            </div>

            <div class="col-xs-10">
                <div>${resource[4]}<span class="text-muted">@${resource[4]} ${resource[5]}</span>

                    <div class="pull-right"><a href="https://${resource[1]}">${resource[1]}</a></div>

                    <p>
                        ${resource[2]}
                    </p>


                    <g:if test="${Resource.get(resource[0]).canViewedBy(session.user)}">
                    <span><g:link controller="resource" action="show" params="[id:resource[0]]" style="text-decoration:underline;font-size:10px">View Post</g:link>
                    </span>
                    </g:if>

                </div>

            </div>

        </div>
    </div></br><hr style="border-width:3px;padding:0px;border-color:green">
    <hr style="border-width:3px;padding:0px;border-color:green">
</g:each>
</div>

