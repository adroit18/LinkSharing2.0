<%@ page import="com.tothenew.linksharing.*" %>
<div class="panel panel-default" style="padding:8px;border:10px inset yellowgreen;">
    <div class="panel-heading" style="border-bottom:3px;border:5px double green;">Recent Shares</div>

    <g:each in="${recentShares}" var="shares">
        <div class="panel-body">

            <div class="col-xs-2">
                %{--<g:include controller="user" action="userImage" params='[username: "${shares[3].username}"]'/>--}%
                <img src="${g.createLink(controller: 'user', action: 'image', params: [id: shares[3].id])}" width="65px"
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


            %{--<g:link controller="fileManager" action="downloadFile">Download</g:link>--}%
            %{--<div class="col-xs-2"><g:link controller="DocumentResource" action="downloadDocument" params="[fid:shares[6]]" style="text-decoration:underline;font-size:10px">Download</g:link></div>--}%
            %{--<div class="col-xs-3"><a href="#" style="text-decoration:underline;font-size:10px">View full site</a></div>--}%
            %{--<div class="col-xs-3"><a href="#" style="text-decoration:underline;font-size:10px">Mark as Read</a></div>--}%
                <g:if test="${Resource.get(shares[6]).canViewedBy(session.user)}">
                    <div class="col-xs-2">
                        <g:link controller="resource" action="show" params="[id: shares[6]]"
                                style="text-decoration:underline;font-size:10px">View Post</g:link>
                    </div>
                </g:if>

            </div>

            <div class="col-xs-12"><hr style="border-width:3px;padding:0px;border-color:green">
                <hr style="border-width:3px;padding:0px;border-color:green"></div>

        </div>

    </g:each>
</div>