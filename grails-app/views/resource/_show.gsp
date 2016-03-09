<%@ page import="com.tothenew.linksharing.Topic" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta content="main" name="layout">
    <title>Resource Show</title>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="col-xs-5">
            <!-- Name Panel -->
            <!-- ************************************************** -->
            <div class="panel panel-default">
                <div class="panel-body">
                    <div>
                        <div class="col-xs-2">
                            <div class="glyphicon glyphicon-user" style="font-size:80px"></div>
                        </div>

                        <div class="col-xs-10">
                            <div class="row" style="padding-bottom:5px">
                                <div class="col-xs-4">
                                    <span class="h5">${resource?.createdBy.name}</span>
                                </div>

                                <div class="col-xs-8">
                                    <a href="#" class="text-left">${resource?.topic.name}</a>
                                </div>
                            </div>

                            <div class="row" style="padding-bottom:10px">
                                <div class="col-xs-4">
                                    <small class="text-muted">@${resource?.createdBy.username}</small>
                                </div>

                                <div class="col-xs-2"></div>

                                <div class="col-xs-6 text-muted">${resource?.dateCreated}</div>

                            </div>
                            <p style="padding-bottom:5px">${resource?.description}</p>

                            <div class="row" style="padding-bottom:15px">
                                <div class="col-xs-4"></div>
                                <g:form name="ratingForm" controller="resourceRating" action="saveRating"
                                        class="form-horizontal">
                                    <div class="col-xs-4">
                                        <g:select name="rating" from="${0..5}" class="form-control"/>
                                    </div>
                                    <g:hiddenField name="id" value="${resource.id}"/>
                                    <div class="col-xs-4">
                                        <g:submitButton name="vote" type="submit" value="Vote" class="btn btn-success"/>
                                    </div>
                                </g:form>
                            </div>

                        </div>


                        <div class="row">
                            <div class="col-xs-1 fa fa-facebook-official" style="font-size:20px"></div>

                            <div class="col-xs-1 fa fa-twitter" style="font-size:20px"></div>

                            <div class="col-xs-1 fa fa-google-plus" style="font-size:20px"></div>

                            <div class="col-xs-2"></div>

                            <div class="col-xs-1"><ls:canDeleteResouce resource="${resource}"/></div>

                            <div class="col-xs-1"><a href="#">Edit</a></div>
                            <g:if test="${resource.whichResource().equals("Document")}">
                                <div class="col-xs-2"><a href="#">Download</a></div>
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

        <div class="col-xs-7">
            <!-- Trending Topics Panel -->
            <!-- ************************************************ -->
            <ls:trendingTopics/>
        </div>
    </div>
</div>
</body>
</html>