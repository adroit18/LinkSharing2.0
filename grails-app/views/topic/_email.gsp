<script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>

<script>

    $(function () {
        $("#inviteForm").validate({
            rules: {
                emailIdInvite: {
                    unique: true,
                    required: true,
                    email: true
                }
            },
            messages: {
                emailId: "Enter appropriate Email address"

            },
            submitHandler: function (form) {
                form.submit();
            }
        });

    });
</script>





<%@ page import="com.tothenew.linksharing.*" %>

<!-- 1 Modal -->
<div id="myModal1" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Send Invitation</h4>
            </div>

            <div class="modal-body">
                <g:form class="form-horizontal" name="inviteForm">

                    <div class="form-group">
                        <label class="control-label col-xs-4">Email/Username:</label>

                        <div class="col-xs-8">
                            <input type="email" class="form-control" name="emailIdInvite" id="emailIdInvite"
                                   placeholder="Enter email">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="pull-left col-xs-4">Topics</label>

                        <div class="col-xs-8">
                            <g:select id="topicNameInvite" name="topicNameInvite" class="form-control"
                                      from="${Subscription.findAllByUser(session.user).topic.name}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-xs-4"></div>

                        <div class="col-xs-4">
                            <input type="button"
                                    class="form-control btn btn-success active submitInvitation" name="submitInvitation"
                                    id="submitInvitation" value="Invite"
                                    style="color:white;border:solid black;border-radius:7px"/>
                        </div>

                        <div class="col-xs-4">
                            %{--<g:actionSubmit  controller="user" action="userIndex" class="form-control btn btn-default active" id="submit" value="Cancel"--}%
                            %{--style="color:black;border:solid black;border-radius:7px"/>--}%
                        </div>
                    </div>

                </g:form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            </div>
        </div>

        <div id="dialog" title="Dialog Title">I'm in a dialog</div>
    </div>

</div>

<script type="application/javascript">

    $('.submitInvitation').on('click', function () {
        alert($('#topicNameInvite').val());
        $.ajax({
            url: "${g.createLink(controller:'topic',action: 'invite')}",
            type: 'post',
            dataType: 'json',
            data: {
                topicName: $('#topicNameInvite').val(),
                emailId: $('#emailIdInvite').val()
            },
            success: function (data) {
                alert()

            },
            error: function (xhr) {
                $("#dialog").dialog();
            }

        })

    });


</script>
