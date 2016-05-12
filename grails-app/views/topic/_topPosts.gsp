

<%@ page import="com.tothenew.linksharing.*" %>
<head>
    <meta name="layout" content="index"/>

</head>
<div class="col-xs-4"></div>
<div class="panel col-xs-7 ">
    <div class="panel-heading "><h3 style="text-align:center;text-decoration-style:wavy;
    font-style: italic">Top Posts</h3></div>

<g:each in="${resourceList}" var="resource" status="index">


    <div class="panel ">
    <div class="panel-heading dark-overlay" id="topPosts" >
    ${index+1}. &nbsp; ${resource[2]}



    </div>

    <div class="panel-body bdy">
        <div class="row">
                <div class="col-xs-2 pull-${index%2!=0?'right':'left'}">
                %{--<g:include controller="user" action="userImage" params='[username: "${resource[4]}"]'/>--}%
                <img src="${g.createLink(controller: 'user', action: 'image', params:[id:resource[4].id])}" width="65px" height="65px"/>
            </div>

            <div class="col-xs-10">
                <div>${resource[4]}<span class="text-muted">@${resource[4]} ${resource[5]}</span>

                    <div class="pull-right"><a href="${resource[1]}">${resource[1]}</a></div>

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
</div>
</g:each>
    </div>
</div>

<g:render template="/documentResource/create" model="[subscribed: subscribedTopics]"/>
<g:render template="/topic/create"/>
<g:render template="/topic/email"/>
<g:render template="/linkResource/create" model="[subscribed: subscribedTopics]"/>


