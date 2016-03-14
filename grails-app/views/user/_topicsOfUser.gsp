<script type="text/javascript">


    $(function () {


        $('.sajaxVisibleSelect').on('change', function () {
            var visibility = $("#" + this.id + " option:selected").val();
            $.ajax({
                url: "${g.createLink(controller:'topic',action:'changeVisibility')}",
                data: {
                    visibility: visibility, topicId: (this.id).substr(15)
                },
                type: 'POST',
                success: function (data) {
                    alert(data.message)
                },
                error: function (xhr) {
                    alert(xhr.responseText);
                }
            });
        });

        $('.sajaxSeriousSelect').on('change', function () {
            var seriousness = $("#" + this.id + " option:selected").val();
            $.ajax({
                url: "${g.createLink(controller:'subscription',action:'changeSeriousness')}",
                data: {
                    seriousness: seriousness, topicId: (this.id).substr(15)
                },
                type: 'POST',
                success: function (data) {
                    alert(data.message)

                },
                error: function (xhr) {
                    alert(xhr.responseText);
                }
            });
        });

        $('.seditTopicInline').on('click', function () {

            var editTopicDivId = (this.id).substr(6);

            if (!$("#sedit-" + editTopicDivId).hasClass('disable-edit')) {

                $("#sedit-" + editTopicDivId).addClass('disable-edit');
                $("#stopicNameLabel-" + editTopicDivId).hide();
                $("#stopicNameTxtBox-" + editTopicDivId).show();
                $("#sbtnCancelEditTopic-" + editTopicDivId).show();
                $("#sbtnSaveEditTopic-" + editTopicDivId).show();
            }
        });

        $(".ssaveTopicEdit").on('click', function () {

            var topicDivId = (this.id).substr(18);

            var topicName = $("#stopicNameTxtBox-" + topicDivId).val();

            $("#stopicNameLabel-" + topicDivId).html(topicName);

            $("#stopicNameLabel-" + topicDivId).show();
            $("#stopicNameTxtBox-" + topicDivId).hide();

            $.ajax({
                url: "${g.createLink(controller:'topic',action:'editTopic')}",
                data: {
                    topicId: topicDivId, topicName: topicName,
                },
                type: 'POST',
                success: function (data) {
                    alert(data.message)
                },
                error: function (xhr) {
                    alert(xhr.responseText);
                },
                complete: function () {

                    $("#sbtnCancelEditTopic-" + topicDivId).hide();
                    $("#sbtnSaveEditTopic-" + topicDivId).hide();
                    $("#sedit-" + topicDivId).removeClass('disable-edit');
                }
            });
        });

        $(".scnclTopicEdit").on('click', function () {

            var topicDivId = (this.id).substr(20);

            $("#sedit-" + topicDivId).removeClass('disable-edit');
            var topicName = $("#stopicNameLabel-" + topicDivId).html();
            $("#stopicNameLabel-" + topicDivId).show();
            $("#stopicNameTxtBox-" + topicDivId).val(topicName).hide();

            $("#sbtnCancelEditTopic-" + topicDivId).hide();
            $("#sbtnSaveEditTopic-" + topicDivId).hide();
        });


        $('.sdeleteTopic').on('click', function () {
            console.log("del clicked-" + this.id)
            $.ajax({
                url: "${g.createLink(controller:'topic',action:'deleteTopic')}",
                data: {
                    topicId: (this.id).substr(5)
                },
                type: 'POST',
                success: function () {
                    $(".stopicDiv-" + (this.id).substr(5)).hide(500)

                },
                success: function (data) {
                    alert(data.message)
                    window.location.reload();
                },
                error: function (xhr) {
                    alert(xhr.responseText);
                }
            });
        });

    });





</script>



<%@ page import="com.tothenew.linksharing.*" %>

<div class="panel panel-default" style="border:3px solid blueviolet;border-radius:8px">

    <div class="panel-heading" style="border-bottom:3px solid blueviolet;">Subscriptions

        <div class="pull-right">
            <a href="#" style="text-decoration:underline">View ALL</a>
        </div>

    </div>

    <g:each in="${topicList}" var="topic">

        <div id="topicDiv-${topic?.id}" class="panel-body">

            <div class="col-xs-2">
                %{--<g:include controller="user" action="userImage" params='[username: "${subscription[2].username}"]'/>--}%
                <img src="${g.createLink(controller: 'user', action: 'image', params: [id: topic?.createdBy.id])}"
                     width="65px" height="65px"/>
            </div>

            <div class="col-xs-10 pull-left">

                <g:link value="topic" url="[controller: 'topic', action: 'index', params: [id: topic?.createdBy?.id]]"
                        class="col-xs-8"
                        style="text-decoration:underline">
                    <label class="user-resource anchor-dec view-post"
                           id="stopicNameLabel-${topic?.id}">${topic?.name}</label>
                </g:link>

                <input type="text" style="display: none" id="stopicNameTxtBox-${topic?.id}"
                       value="${topic?.name}"/>
                <button type="button" id="sbtnCancelEditTopic-${topic?.id}"
                        class="scnclTopicEdit btn btn-default pull-right"
                        style="display: none">Cancel</button>
                <button type="button" id="sbtnSaveEditTopic-${topic?.id}"
                        class="ssaveTopicEdit btn btn-default pull-right"
                        style="display: none">Save</button>
            </br></br>
                <span class="col-xs-6 text-muted">@${topic?.createdBy?.username}</span>
                <span class="col-xs-4" style="padding-left:1px">Subscriptions</span>
                <span class="col-xs-2" style="padding-left:1px">Posts</span><br>
                <span class="col-xs-6" style="color:blue;"><ls:showSubscribe topicId="${topic?.id}"/>
                </span>

                <span class="col-xs-4" style="color:blue;padding-left:1px"><ls:subscriptionCount topicId="${topic?.id}"
                                                                                                 user="${topic?.createdBy}"/></span>
                <span class="col-xs-2" style="color:blue;padding-left:1px"><ls:resourceCount
                        topicId="${topic?.id}"/></span>
                <br>



                <g:if test="${Subscription?.findByTopicAndUser(Topic.get(topic?.id), session.user)}">
                    <ls:canUpdateTopic topicId="${topic?.id}"
                                       subId="${Subscription?.findByTopicAndUser(Topic.get(topic?.id), session.user).id}"/>
                </g:if>
                <g:else>
                    <ls:canUpdateTopic topicId="${topic?.id}" subId="${null}"/>
                </g:else>
                <br>
%{--.......................................................--}%


        <div> <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal6"
                      style="font-size:15px;border:none;background:none;color:blue"><div
                    class="glyphicon glyphicon-envelope"></div></button>

                <div id="myModal6" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal 6 content-->
                        <div class="modal-content" >
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Send Invitation</h4>
                            </div>
                            <div class="modal-body">
                                <g:form class="form-horizontal"  controller="topic" action="invite">

                                    <div class="form-group">
                                        <label class="control-label col-xs-4">Email/Username:</label>
                                        .
                                        <div class="col-xs-8">
                                            <input type="email" class="form-control" name="emailId" id="emailId" placeholder="Enter email">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-xs-4">Topics</label>

                                        <div class="col-xs-8">
                                            <g:select name="topicName" from="${[topic?.name]}"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-4"></div>
                                        <div class="col-xs-4">
                                            <g:actionSubmit controller="topic" action="invite" class="form-control btn btn-default active" id="submit" value="Invite"
                                                            style="color:black;border:solid black;border-radius:7px"/>
                                        </div><div class="col-xs-4">
                                        %{--<g:actionSubmit  controller="user" action="userIndex" class="form-control btn btn-default active" id="submit" value="Cancel"--}%
                                        %{--style="color:black;border:solid black;border-radius:7px"/>--}%
                                    </div>
                                    </div>

                                </g:form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>










            </div>













                %{--<div class="glyphicon glyphicon-envelope col-xs-4"></div>--}%

   %{--......................................................... --}%



                <br>

                <span class="col-xs-7">
                    <g:if test="${(topic?.createdBy.id==(session.user.id)) || (session.user.isAdmin) && (Subscription?.findByTopicAndUser(Topic.get(topic?.id), session.user))}">

                        <g:select name="seriousSelect-${topic?.id}"
                                  class=" form-control dashboard-select sajaxSeriousSelect"
                                  id="sseriousSelect-${topic?.id}" from="${['SERIOUS', 'VERY_SERIOUS', 'CASUAL']}"
                                  value="${Subscription.findByTopicAndUser(Topic.get(topic.id), session.user).seriousness}"/>

                    </g:if>

                    <g:else>
                        The Topic is Not Subscribed
                    </g:else>

                </span>


                <g:if test="${(topic?.createdBy.id==(session.user.id)) || (session.user.isAdmin)}">

                    <span class="col-xs-5">
                        <g:select name="visibleSelect-${topic?.id}"
                                  class="col-xs-6  form-control dashboard-select sajaxVisibleSelect"
                                  id="svisibleSelect-${topic?.id}" from="${['PUBLIC', 'PRIVATE']}"
                                  value="${topic?.visibility}"/>
                    </span>

                </g:if>

            </div>
            .
            <br>
            <hr style="border-width:3px;padding:0px;border-color:blue">

        </div>
    </g:each>
</div>
