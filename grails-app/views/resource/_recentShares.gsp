<%@ page import="com.tothenew.linksharing.*" %>
<head>
    <meta name="layout" content="index"/>

</head>
<div class="col-xs-4"></div>
<div class="panel col-xs-7 ">
    <div class="panel-heading "><h3 style="text-align:center;text-decoration-style:wavy;
    font-style: italic">Recent Shares</h3></div>


    <g:each in="${recentShares}" var="shares" status="index">



        <div class="panel ">

            <div class="panel-heading dark-overlay ">${shares[4].name}</div>

            <div class="panel-body">

                <div class="col-xs-2 pull-${index%2==0?'right':'left'}">
                    %{--<g:include controller="user" action="userImage" params='[username: "${shares[3].username}"]'/>--}%
                    <img src="${g.createLink(controller: 'user', action: 'image', params: [id: shares[3].id])}"
                         width="65px"
                         height="65px"/>
                </div>

                <div class="col-xs-10">${shares[3]}<span class="text-muted">
                    @${shares[3]}
                    <g:if test="${((new Date().time - shares[5].time) / (3600000)) < 1}">
                        ${((new Date().time - shares[5].time) / 360000).toInteger()} minutes
                    </g:if>
                    <g:else>
                        ${((new Date().time - shares[5].time) / 3600000).toInteger()} hours
                    </g:else>

                </span><span class="pull-right"><a href="${shares[0]}">${shares[0]}</a></span>

                    <p>${shares[1]}</p>


                    <g:if test="${Resource.get(shares[6]).canViewedBy(session.user)}">
                        <div class="col-xs-2">
                            <g:link controller="resource" action="show" params="[id: shares[6]]"
                                    style="text-decoration:underline;font-size:10px">View Post</g:link>
                        </div>
                    </g:if>

                </div>

            </div>

        </div>

    </g:each>
</div>




<g:render template="/documentResource/create" model="[subscribed: subscribedTopics]"/>
<g:render template="/topic/create"/>
<g:render template="/topic/email"/>
<g:render template="/linkResource/create" model="[subscribed: subscribedTopics]"/>

