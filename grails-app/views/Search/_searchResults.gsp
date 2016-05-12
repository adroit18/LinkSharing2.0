<script>
    <g:javascript library="jquery" />
</script>

<span style="font-size: medium;color:rebeccapurple;font-style: italic">Topics You may be interested in..........</span>
<%@ page import="com.tothenew.linksharing.*" %>

<g:each in="${resourceTopics}" var="id" status="i">
<div class="panel-heading panel-title">

    <g:link value="topic"
            url="[controller: 'topic', action: 'index', params: [id: Resource.get(id).topic?.id]]"
            style="text-decoration:none">
       ${i+1}. ${Resource.get(id).topic.name}</g:link>

</div>


<div class="panel-body" id="m">
%{--<g:paginate total="${searchResources}" next="Forward" prev="Back" maxsteps="0"></g:paginate>--}%

        <div class="col-xs-2">
            %{--<g:include controller="user" action="userImage"--}%
            %{--params='[username: "${resource?.createdBy?.username}"]'/>--}%
            <img src="${g.createLink(controller: 'user', action: 'image', params: [id: Resource.get(id)?.createdBy?.id])}"
                 width="65px" height="65px"/>

        </div>


        <div class="col-xs-10">
            <div class="row">
                <div class="col-xs-4">
                    <span class="h5">${Resource.get(id).createdBy.name}</span>
                    <small class="text-muted">@${Resource.get(id).createdBy.username}</small>
                </div>

                %{--<div class="col-xs-3">--}%
                %{--</div>--}%

                <div class="col-xs-8">

                </div>
            </div>

            <p>${Resource.get(id).description}</p>

            <div class="row">
                <div class="col-xs-2"><i class="fa fa-facebook-official"></i>
                    <i class="fa fa-tumblr"></i>
                    <i class="fa fa-google-plus"></i></div>

                <div class="col-xs-5">
                    <g:if test="${Resource.get(id).whichResource().equals("Document")}">
                        <g:link controller="DocumentResource" action="downloadDocument"
                                params="[fid: Resource.get(id).id]"
                                style="text-decoration:underline;font-size:10px">Download</g:link>
                    </g:if>

                    <g:elseif test="${Resource.get(id).whichResource().equals("Link")}">
                        <a href="${Resource.get(id).url}"
                           style="text-decoration:underline;font-size:10px">View full site</a>
                    </g:elseif>
                </div>
                %{--<% ReadingItem readingItem = ReadingItem.findByResourceAndUser(resource,session.user)--}%
                %{--//                                def ide = readingItem.id--}%
                %{--%>--}%
                %{--${readingItem.properties}--}%

                %{--<ls:markAsRead id="${ReadingItem.findByResource(resource).id}" query="${query}"/>--}%

                <div class="col-xs-2"><g:link controller="resource" action="show"
                                              params="[id: Resource.get(id).id]"
                                              style="text-decoration:underline;font-size:10px">View Post</g:link>
                </div>
            </div>
        </div>

        <div class="col-xs-12"><hr style="border-width:3px;padding:0px;border-color:darkgrey">
        </div>

</div>

</g:each>



%{--<...............................................................>--}%

<span style="font-size: medium;color:rebeccapurple;font-style: italic">Resources You May be Interested in ........</span>

<g:each in="${searchResources}" var="resource" status="i">

<div class="panel-heading panel-title">

    <g:link value="topic"
            url="[controller: 'topic', action: 'index', params: [id: resource?.topic?.id]]"
            style="text-decoration:none">
    ${i+1}.    ${resource.topic.name}</g:link>


</div>


<div class="panel-body" id="m">
%{--<g:paginate total="${searchResources}" next="Forward" prev="Back" maxsteps="0"></g:paginate>--}%

        <div>
            <div class="col-xs-2">
                %{--<g:include controller="user" action="userImage"--}%
                %{--params='[username: "${resource?.createdBy?.username}"]'/>--}%
                <img src="${g.createLink(controller: 'user', action: 'image', params: [id: resource?.createdBy?.id])}"
                     width="65px" height="65px"/>

            </div>
        </div>

        <div class="col-xs-10">
            <div class="row">
                <div class="col-xs-4">
                    <span class="h5">${resource.createdBy.name}</span>
                    <small class="text-muted">@${resource.createdBy.username}</small>
                </div>

                %{--<div class="col-xs-3">--}%
                %{--</div>--}%

                <div class="col-xs-8">


                </div>
            </div>

            <p>${resource.description}</p>

            <div class="row">
                <div class="col-xs-2"><i class="fa fa-facebook-official"></i>
                    <i class="fa fa-tumblr"></i>
                    <i class="fa fa-google-plus"></i></div>

                <div class="col-xs-5">
                    <g:if test="${resource?.whichResource().equals("Document")}">
                        <g:link controller="DocumentResource" action="downloadDocument"
                                params="[fid: resource?.id]"
                                style="text-decoration:underline;font-size:10px">Download</g:link>
                    </g:if>

                    <g:elseif test="${resource?.whichResource().equals("Link")}">
                        <a href="${resource.url}"
                           style="text-decoration:underline;font-size:10px">View full site</a>
                    </g:elseif>
                </div>
                %{--<% ReadingItem readingItem = ReadingItem.findByResourceAndUser(resource,session.user)--}%
                %{--//                                def ide = readingItem.id--}%
                %{--%>--}%
                %{--${readingItem.properties}--}%

                %{--<ls:markAsRead id="${ReadingItem.findByResource(resource).id}" query="${query}"/>--}%

                <div class="col-xs-2"><g:link controller="resource" action="show"
                                              params="[id: resource?.id]"
                                              style="text-decoration:underline;font-size:10px">View Post</g:link>
                </div>
            </div>
        </div>

        <div class="col-xs-12"><hr style="border-width:3px;padding:0px;border-color:darkgrey">
        </div>

</div>
</g:each>