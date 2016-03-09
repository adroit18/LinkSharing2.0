
<div class="panel panel-default" style="border:3px solid blueviolet;border-radius:8px">
    <div class="panel-heading" style="border-bottom:3px solid blueviolet;">Recent Shares</div>

    <g:each in="${recentShares}" var="shares">
        <div class="panel-body">

            <div class="col-xs-2">
                <g:include controller="user" action="userImage" params='[username: "${shares[3].username}"]'/>
            </div>
            <div class="col-xs-10">${shares[3]}<span class="text-muted">
            @${shares[3 ]}
                <g:if test="${((new Date().time-shares[5].time)/(3600000))<1}">
                ${((new Date().time-shares[5].time)/360000).toInteger()} minutes
                </g:if>
                <g:else >
                    ${((new Date().time-shares[5].time)/3600000).toInteger()} hours
                </g:else>


            </span><span class="pull-right"><a href="#">${shares[0]}</a></span>
                <p>${shares[1]}</p>
                <div class="col-xs-2"><i class="fa fa-facebook-official"></i>
                    <i class="fa fa-tumblr"></i>
                    <i class="fa fa-google-plus"></i>  </div>
                %{--<g:link controller="fileManager" action="downloadFile">Download</g:link>--}%
                %{--<div class="col-xs-2"><g:link controller="DocumentResource" action="downloadDocument" params="[fid:shares[6]]" style="text-decoration:underline;font-size:10px">Download</g:link></div>--}%
                <div class="col-xs-3"><a href="#" style="text-decoration:underline;font-size:10px">View full site</a></div>
                %{--<div class="col-xs-3"><a href="#" style="text-decoration:underline;font-size:10px">Mark as Read</a></div>--}%
                <div class="col-xs-2"><a href="#" style="text-decoration:underline;font-size:10px">View Post</a></div>

            </div>

            <div class="col-xs-12"><hr style="border-width:3px;padding:0px;border-color:blue"></div>



        </div>

    </g:each>
</div>