<div class="panel panel-default" style="border:3px solid blueviolet;border-radius:8px">
    <div class="panel-heading" style="border-bottom:3px solid blueviolet;">Inbox</div>

    <g:each in="${inboxList}" var="inbox">
        <div class="panel-body">


            <div class="col-xs-2">
                <g:include controller="user" action="userImage" params='[username: "${inbox[3]}"]'/>
            </div>
            <div class="col-xs-10">${inbox[3]}<span class="text-muted">
                @${inbox[3]}
               %{-- <g:if test="${((new Date().time-shares[5].time)/(3600000))<1}">
                    ${((new Date().time-shares[5].time)/360000).toInteger()} minutes
                </g:if>
                <g:else >
                    ${((new Date().time-shares[5].time)/3600000).toInteger()} hours
                </g:else>

--}%
            </span><span class="pull-right"><a href="#">${inbox[2]}</a></span>
                <p>${inbox[1]}</p>
                <div class="col-xs-2"><i class="fa fa-facebook-official"></i>
                    <i class="fa fa-tumblr"></i>
                    <i class="fa fa-google-plus"></i>  </div>
                <div class="col-xs-2"><g:link controller="DocumentResource" action="downloadDocument" params="[fid:inbox[4]]" style="text-decoration:underline;font-size:10px">Download</g:link></div>
                <div class="col-xs-3"><a href="#" style="text-decoration:underline;font-size:10px">View full site</a></div>
               <div class="col-xs-3"><ls:markAsRead  id="${inbox[0]}"></ls:markAsRead></div>
               <div class="col-xs-2"><g:link controller="resource" action="show" params="[id:inbox[0]]" style="text-decoration:underline;font-size:10px">View Post</g:link></div>
            </div>

            <div class="col-xs-12"><hr style="border-width:3px;padding:0px;border-color:blue"></div>



        </div>

    </g:each>
</div>