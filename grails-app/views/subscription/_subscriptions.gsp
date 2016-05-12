<head>
    <meta name="layout" content="index"/>

</head>

<script type="text/javascript">


    $(function () {


        $('.sajaxVisibleSelect').change(function () {
            var link = this.id
            var visibility = $("#" + this.id + " option:selected").val();
            $.ajax({
                url: "${g.createLink(controller:'topic',action:'changeVisibility')}",
                data: {
                    visibility: visibility, topicId: (this.id).substr(15)
                },
                type: 'POST',
                success: function (data) {

                    data.status == true ? $("#SuccessMsg").show().delay(2000).fadeOut().text(data.message)
                            : $("#ErrorMsg").show().delay(2000).fadeOut().text(data.message);
                },
                error: function (xhr) {
                    alert(xhr.responseText);
                }
            });
        });

        $('.sajaxSeriousSelect').change(function () {
            var link = this.id

            var seriousness = $("#" + this.id + " option:selected").val();
            $.ajax({
                url: "${g.createLink(controller:'subscription',action:'changeSeriousness')}",
                data: {
                    seriousness: seriousness, topicId: (this.id).substr(15)
                },
                type: 'POST',
                success: function (data) {
                    data.status == true ? $("#SuccessMsg").show().delay(2000).fadeOut().text(data.message)
                            : $("#ErrorMsg").show().delay(2000).fadeOut().text(data.message);

                },
                error: function (xhr) {
                    alert(xhr.responseText);
                }
            });
        });

        $('.seditTopicInline').click(function () {

            var editTopicDivId = (this.id).substr(6);

            if (!$("#sedit-" + editTopicDivId).hasClass('disable-edit')) {

                $("#sedit-" + editTopicDivId).addClass('disable-edit');
                $("#stopicNameLabel-" + editTopicDivId).hide();
                $("#stopicNameTxtBox-" + editTopicDivId).show();
                $("#sbtnCancelEditTopic-" + editTopicDivId).show();
                $("#sbtnSaveEditTopic-" + editTopicDivId).show();
            }
        });

        $(".ssaveTopicEdit").click(function () {

            var link = this.id
            alert(link)
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

                    $("#" + link + "Success").show().delay(1000).fadeOut().text(data.message);
                },
                error: function (xhr) {
                    $("#" + link + "Error").show().delay(1000).fadeOut().text(data.message);
                },
                complete: function () {

                    $("#sbtnCancelEditTopic-" + topicDivId).hide();
                    $("#sbtnSaveEditTopic-" + topicDivId).hide();
                    $("#sedit-" + topicDivId).removeClass('disable-edit');
                }
            });
        });

        $(".scnclTopicEdit").click(function () {

            var topicDivId = (this.id).substr(20);

            $("#sedit-" + topicDivId).removeClass('disable-edit');
            var topicName = $("#stopicNameLabel-" + topicDivId).html();
            $("#stopicNameLabel-" + topicDivId).show();
            $("#stopicNameTxtBox-" + topicDivId).val(topicName).hide();

            $("#sbtnCancelEditTopic-" + topicDivId).hide();
            $("#sbtnSaveEditTopic-" + topicDivId).hide();
        });


        $('.sdeleteTopic').click(function () {
            var link = this.id
            console.log("del clicked-" + this.id)
            $.ajax({
                url: "${g.createLink(controller:'topic',action:'deleteTopic')}",
                data: {
                    topicId: (this.id).substr(5)
                },
                type: 'POST',

                success: function (data) {


                    data.status == true ? $("#SuccessMsg").show().delay(2000).fadeOut().text(data.message)
                            : $("#ErrorMsg").show().delay(2000).fadeOut().text(data.message);

                    if (data.message == "Topic Deleted Successfully")
                        $("#" + link).parents(".rem").remove();


                },
                error: function (xhr) {
                    alert(xhr.responseText);
                }
            });
        });

    });





</script>


<script>
    $(document).delegate(".subscribe", "click", function () {
        var link = $(this)
        var topicId = $(this).attr('id')
        $.ajax({
            url: "${createLink(controller: 'subscription',action: 'saveTopic')}",
            type: "post",
            dataType: 'json',
            data: {id: topicId},

            success: function (data) {
                data.status == true ? $("#SuccessMsg").show().delay(2000).fadeOut().text('Subscription saved Successfully')
                        : $("#ErrorMsg").show().delay(2000).fadeOut().text('Subscription could not be saved');
                $(link).replaceWith(data.message)
            },

            error: function (xhr) {
                alert(xhr.responseText);
            }

        });


    });

    $(document).delegate(".unsubscribe", "click", function () {
        var link = $(this)
        var topicId = $(this).attr('id')
        $.ajax({
            url: "${createLink(controller: 'subscription',action: 'delete')}",
            type: "post",
            dataType: 'json',
            data: {id: topicId},
            success: function (data) {
                data.status == true ? $("#SuccessMsg").show().delay(2000).fadeOut().text('Subscription Deleted Successfully')
                        : $("#ErrorMsg").show().delay(2000).fadeOut().text('Subscription Not Found');
                if ((($(link).parent("#sub")).size()) != 0) {
                    $(link).parents(".rem").remove()
                }
                else
                    $(link).replaceWith(data.message)

            },
            error: function (xhr) {
                alert(xhr.responseText);
            }

        });


    });
</script>










<%@ page import="com.tothenew.linksharing.*" %>

<div class="col-xs-4"></div>

<div class="col-xs-7 panel panel-default">
    <div class="panel-heading "><h3 style="text-align:center;text-decoration-style:wavy;
    font-style: italic">Subscriptions</h3></div>

    <div class="panel-body">
        <g:each in="${subscriptionList}" var="subscription" status="i">

            <div class="panel rem">
                <div class="panel-heading panel-title ">

                    <div class="col-xs-12 col-md-6 col-lg-3 no-padding">
                        <div class="panel panel-teal panel-widget">
                            <div class="row no-padding">
                                <div class="col-sm-3 col-lg-5 widget-left">
                                    <svg class="glyph stroked app-window">
                                        <use xlink:href="#stroked-app-window"><use
                                                xlink:href="#stroked-male-user"></use></svg>
                                </div>

                                <div class="col-sm-9 col-lg-7 widget-right">
                                    <div class="large">${i + 1}.</div>

                                    <div class="text-muted"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <g:link value="topic"
                            url="[controller: 'topic', action: 'index', params: [id: subscription[0]]]"
                            class="col-xs-8"
                            style="text-decoration:underline">
                        <label class="user-resource anchor-dec view-post"
                               id="stopicNameLabel-${subscription[0]}">${subscription[1]}</label>
                    </g:link>

                </div>

                <div class="panel-body ">
                    <div id="sdel-${subscription[0]}Success" title="Dialog Title"
                         style="display:none;color: #00aa00;font-size: 15px"></div>

                    <div id="sdel-${subscription[0]}Error" title="Dialog Title"
                         style="display:none;color: red;font-size: 15px"></div>

                    <div class="panel-body">

                        <div class="col-xs-2 pull-${i % 2 == 0 ? 'right' : 'left'}">
                            %{--<g:include controller="user" action="userImage" params='[username: "${subscription[2].username}"]'/>--}%
                            <img src="${g.createLink(controller: 'user', action: 'image', params: [id: subscription[2].id])}"
                                 width="65px" height="65px"/>
                        </div>

                        <div class="col-xs-10 pull-left">

                            <input type="text" style="display: none" id="stopicNameTxtBox-${subscription[0]}"
                                   value="${subscription[1]}"/>
                            <button type="button" id="sbtnCancelEditTopic-${subscription[0]}"
                                    class="scnclTopicEdit btn btn-primary pull-right"
                                    style="display: none;padding: 1px;">Cancel</button>
                            <button type="button" id="sbtnSaveEditTopic-${subscription[0]}"
                                    class="ssaveTopicEdit btn btn-success pull-right"
                                    style="display: none;padding: 1px;">Save</button>

                            <div id="sbtnSaveEditTopic-${subscription[0]}Success" title="Dialog Title"
                                 style="display:none;color: #00aa00;font-size: 15px"></div>

                            <div id="sbtnSaveEditTopic-${subscription[0]}Error" title="Dialog Title"
                                 style="display:none;color: red;font-size: 15px"></div>



                        </br></br>
                            <span class="col-xs-6 text-muted">@${subscription[2]}</span>
                            <span class="col-xs-4" style="padding-left:1px">Subscriptions</span>
                            <span class="col-xs-2" style="padding-left:1px">Posts</span><br>

                            <span class="col-xs-6" style="color:blue;" id="sub"><ls:showSubscribe
                                    topicId="${subscription[0]}"/>
                            </span>

                            <span class="col-xs-4" style="color:blue;padding-left:1px"><ls:subscriptionCount
                                    topicId="${subscription[0]}"
                                    user="${subscription[2]}"/></span>
                            <span class="col-xs-2" style="color:blue;padding-left:1px"><ls:resourceCount
                                    topicId="${subscription[0]}"/></span>
                            <br>



                            <ls:canUpdateTopic topicId="${subscription[0]}" subId="${subscription[3]}"/>


                            <br>

                            <div><button type="button" class="btn btn-info btn-lg" data-toggle="modal"
                                         data-target="#myModal5"
                                         style="font-size:15px;border:none;background:none;color:blue"><div
                                        class="glyphicon glyphicon-envelope"></div></button>
                                %{--.....................................................--}%

                                <!-- 5 Modal -->
                                <div id="myModal5" class="modal fade" role="dialog">
                                    <div class="modal-dialog">
                                        <!-- Modal content-->
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close"
                                                        data-dismiss="modal">&times;</button>
                                                <h4 class="modal-title">Send Invitation</h4>
                                            </div>

                                            <div class="modal-body">
                                                <g:form class="form-horizontal" controller="topic" action="invite">

                                                    <div class="form-group">
                                                        <label class="control-label col-xs-4">Email/Username:</label>
                                                        .
                                                        <div class="col-xs-8">
                                                            <input type="email" class="form-control" name="emailId"
                                                                   id="emailId" placeholder="Enter email">
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-xs-4">Topics</label>

                                                        <div class="col-xs-8">
                                                            <g:select name="topicName" from="${[subscription[1]]}"/>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <div class="col-xs-4"></div>

                                                        <div class="col-xs-4">
                                                            <g:actionSubmit controller="topic" action="invite"
                                                                            class="form-control btn btn-default active"
                                                                            id="submit" value="Invite"
                                                                            style="color:black;border:solid black;border-radius:7px"/>
                                                        </div>

                                                        <div class="col-xs-4">
                                                            %{--<g:actionSubmit  controller="user" action="userIndex" class="form-control btn btn-default active" id="submit" value="Cancel"--}%
                                                            %{--style="color:black;border:solid black;border-radius:7px"/>--}%
                                                        </div>
                                                    </div>

                                                </g:form>
                                            </div>

                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default"
                                                        data-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>





                                %{--.........................................................--}%

                            </div>
                            <br>

                            <g:if test="${(subscription[2].username == (session.user.username)) || (session.user.isAdmin)}">

                                <span class="col-xs-7"><g:select name="seriousSelect-${subscription[0]}"
                                                                 class=" form-control dashboard-select sajaxSeriousSelect"
                                                                 id="sseriousSelect-${subscription[0]}"
                                                                 from="${['SERIOUS', 'VERY_SERIOUS', 'CASUAL']}"
                                                                 value="${Subscription.get(subscription[3]).seriousness}"/>

                                    <div id="sseriousSelect-${subscription[0]}Success" title="Dialog Title"
                                         style="display:none;color: #00aa00;font-size: 15px"></div>

                                    <div id="sseriousSelect-${subscription[0]}Error" title="Dialog Title"
                                         style="display:none;color: red;font-size: 15px"></div>

                                </span>

                                <span class="col-xs-5">
                                    <g:select name="visibleSelect-${subscription[0]}"
                                              class="col-xs-6  form-control dashboard-select sajaxVisibleSelect"
                                              id="svisibleSelect-${subscription[0]}" from="${['PUBLIC', 'PRIVATE']}"
                                              value="${Topic.get(subscription[0]).visibility}"/>

                                    <div id="svisibleSelect-${subscription[0]}Success" title="Dialog Title"
                                         style="display:none;color: #00aa00;font-size: 15px"></div>

                                    <div id="svisibleSelect-${subscription[0]}Error" title="Dialog Title"
                                         style="display:none;color: red;font-size: 15px"></div>

                                </span>

                            </g:if>

                        </div>

                    </div>

                    <div class="col-xs-12"><hr style="border-width:3px;padding:0px;border-color:darkgrey">
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

