<%@ page import="com.tothenew.linksharing.Topic" %>


<h1 style="text-align:center;text-decoration-style:wavy;
font-style: italic">Topic Name: "${topicName}"</h1>
<br>


<div class="col-xs-7">

    <h3 style="text-align:center;text-decoration-style:wavy;
    font-style: italic">Subscribed Users</h3>

    <g:each in="${users}" var="user">

        <div class="panel panel-default" >
            <div class="panel-heading"
                 style="border-bottom:3px;border:5px inset lightgrey;">${user?.firstName} ${user?.lastName}
            </div>

            <div class="panel-body">
                <div class="col-xs-4">
                    %{--<g:include controller="user" action="userImage" params='[username: "${user.username}"]'/>--}%
                    <img src="${g.createLink(controller: 'user', action: 'image', params: [id: user?.id])}" width="65px"
                         height="65px"/>
                </div>

                <div class="col-xs-8">${user?.firstName}<span class="text-muted"><br>@${user?.username}<br>
                    <span class="col-xs-6" style="padding-left:1px">Subscriptions</span><span class="col-xs-6"
                                                                                              style="padding-left:1px">Posts</span><br>
                </span>
                    <span class="col-xs-6" style="color:blue;padding-left:1px"><ls:subscriptionCount
                            topicId="${Topic.findByName(topicName).id}" user="${user?.id}"/></span><span
                        class="col-xs-6"
                        style="color:blue;padding-left:1px"><ls:resourceCount
                            topicId="${Topic.findByName(topicName).id}"/></span>

                </div>
            </div>

        </div>
    </g:each>
</div>

<div class="col-xs-5">

    <h3 style="text-align:center;text-decoration-style:wavy;
    font-style: italic">Resources Available</h3>

    %{--<div style="font-size: 24px;font-style: italic">Resources List Available</div>--}%
    <g:each in="${resourceList}" var="resource">

        <div class="panel panel-default" >
            <div class="panel-heading"
                 style="border-bottom:3px;border:5px double green;">By:- ${resource.createdBy}
            </div>

            <div class="panel-body">
                <div class="col-xs-4">
                    %{--<g:include controller="user" action="userImage" params='[username: "${user.username}"]'/>--}%
                    <img src="${g.createLink(controller: 'user', action: 'image', params: [id: resource?.createdBy?.id])}"
                         width="65px"
                         height="65px"/>
                </div>

                <div class="col-xs-8">${user?.firstName}<span class="text-muted"><br>@${resource?.createdBy}<br>
                    ${resource?.description}<br><br>


                    <g:if test="${resource?.whichResource().equals("Document")}">
                        <h6>Document Resource.</h6> Click on Link to Download Resource.<br>
                        <g:link controller="DocumentResource" action="downloadDocument"
                                params="[fid: resource?.id]"
                                style="text-decoration:underline;font-size:10px">Download</g:link>
                    </g:if>

                    <g:elseif test="${resource?.whichResource().equals("Link")}">
                        <h6>Link Resource.</h6> Click on Link to Resource url.<br>
                        <a href="${resource?.url}"
                           style="text-decoration:underline;font-size:10px">View full site</a>
                    </g:elseif>


                %{--<span class="col-xs-6" style="padding-left:1px">Subscriptions</span><span class="col-xs-6"
                                                                                          style="padding-left:1px">Posts</span><br>
            </span>
                <span class="col-xs-6" style="color:blue;padding-left:1px"><ls:subscriptionCount
                        topicId="${Topic.findByName(topicName).id}" user="${user?.id}"/></span><span
                    class="col-xs-6"
                    style="color:blue;padding-left:1px"><ls:resourceCount
                        topicId="${Topic.findByName(topicName).id}"/></span>
--}%
                </div>
            </div>

        </div>
    </g:each>
</div>