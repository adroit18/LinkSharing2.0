<%@ page import="com.tothenew.linksharing.User; com.tothenew.linksharing.Topic" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="index"/>
    <title>Resource Show</title>
</head>

<body>
<div class="col-xs-3"></div>
<div class="container">
    <div class="row">
        <div class="col-xs-8">
            <!-- Name Panel -->
            <!-- ************************************************** -->
            <div class="panel panel-default">
                <div class="panel-body">
                    <div>
                        <div class="col-xs-2">
                            %{--<g:include controller="user" action="userImage"--}%
                            %{--params='[username: "${resource.createdBy.username}"]'/>--}%
                            <img src="${g.createLink(controller: 'user', action: 'image', params: [id: resource.createdBy.id])}"
                                 width="65px" height="65px"/>
                        </div>

                        <div class="col-xs-10">
                            <div class="row" style="padding-bottom:5px">
                                <div class="col-xs-3">
                                    <span class="h5">${resource?.createdBy.name}</span>
                                </div>

                                <div class="col-xs-9">
                                    <g:link value="topic"
                                            url="[controller: 'topic', action: 'index', params: [id: resource?.topic?.id]]"
                                            class="col-xs-8"
                                            style="text-decoration:underline">${resource?.topic.name}</g:link>
                                </div>
                            </div>

                            <div class="row" style="padding-bottom:10px">
                                <div class="col-xs-6">
                                    <small class="text-muted">@${resource?.createdBy.username}</small>
                                </div>

                                <div class="col-xs-0"></div>

                                <div class="col-xs-6 text-muted">${resource?.dateCreated}</div>

                            </div>

                            <p style="padding-bottom:5px">${resource?.description}</p>

                            <div class="row" style="padding-bottom:15px">
                                <div class="col-xs-4"></div>
                                <g:if test="${session.user}">

                                    <g:form name="ratingForm" controller="resourceRating" action="saveRating"
                                            class="form-horizontal">
                                        <div class="col-xs-4">
                                            %{--${resource?.id}--}%
                                            <g:select name="rating" value="${User.getScore(resource, session.user)}"
                                                      from="${1..5}" class="form-control"/>
                                        </div>
                                        <g:hiddenField name="id" value="${resource.id}"/>
                                        <div class="col-xs-4">
                                            <g:submitButton name="vote" type="submit" value="Vote"
                                                            class="btn btn-success"/>
                                        </div>
                                    </g:form>
                                </g:if>

                            </div>

                        </div>


                        <div class="row">
                            <div class="col-xs-2"><i class="fa fa-facebook-official"></i>
                                <i class="fa fa-tumblr"></i>
                                <i class="fa fa-google-plus"></i></div>

                            <div class="col-xs-2"></div>

                            <div class="col-xs-2"><ls:canDeleteResouce resource="${resource}"/></div>

                            <div class="col-xs-2">

                                <g:if test="${session.user}">
                                    <g:link data-toggle="modal" data-target="#myModal7"
                                            style="border:none;background:none;color:blue">Edit</g:link>
                                </g:if>

                                <!--  3 Modal -->
                                <div id="myModal7" class="modal fade" role="dialog" xmlns="http://www.w3.org/1999/html">
                                    <div class="modal-dialog">
                                        <!-- Modal content-->
                                        <div class="modal-content">

                                            <div class="modal-header">
                                                <button type="button" class="close"
                                                        data-dismiss="modal">&times;</button>
                                                <h4 class="modal-title">Share Document</h4>
                                            </div>

                                            <div class="modal-body">
                                                <g:form   class="form-horizontal"
                                                        controller="resource" action="edit">

                                                    <div class="form-group">
                                                        <label class="control-label col-xs-4">Enter new Description:</label>

                                                        <div class="col-xs-8">
                                                            <input class="form-control" type="text" name="newName"
                                                                   value="${resource?.description}"/>
                                                            <input type="hidden" name="id" value="${resource?.id}"/>
                                                        </div>
                                                    </div>

                                                    <br class="form-group">

                                                    <div class="col-xs-2 "></div><label class="col-xs-2"></label>


                                                    <div class="form-group">

                                                        <div class="col-xs-4"></div>

                                                        <div class="col-xs-4">
                                                            <g:actionSubmit controller="resource"
                                                                            action="edit"
                                                                            class="form-control btn btn-success active"
                                                                            value="Submit" placeholder="Submit"
                                                                            style="color:white;border:solid black;border-radius:7px"/>
                                                        </div>

                                                        <div class="col-xs-4">
                                                            %{--<g:actionSubmit class="form-control btn btn-primary active" controller="login"--}%
                                                            %{--action="index" value="Cancel" placeholder="Cancel"--}%
                                                            %{--style="color:white;border:solid black;border-radius:7px"/>--}%
                                                        </div>
                                                    </div>

                                                </g:form>

                                            </div>

                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-danger"
                                                        data-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                        </div>

                        <g:if test="${resource.whichResource().equals("Document")}">
                            <g:link controller="DocumentResource" action="downloadDocument"
                                    params="[fid: resource?.id]"
                                    style="text-decoration:underline;font-size:10px">Download</g:link>
                        </g:if>

                        <g:elseif test="${resource.whichResource().equals("Link")}">

                            <div class="col-xs-3"><a href="${resource?.url}" target="_blank">View Full Site</a>
                            </div>

                        </g:elseif>
                    </div>
                </div>

            </div>
        </div>
    </div>

    %{--<div class="col-xs-7">--}%
        %{--<!-- Trending Topics Panel -->--}%
        %{--<!-- ************************************************ -->--}%
        %{--<ls:trendingTopics/>--}%
    %{--</div>--}%
</div>
</div>
</body>
</html>