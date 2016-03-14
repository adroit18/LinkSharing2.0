<%@ page import="com.tothenew.linksharing.*" %>

<!-- 1 Modal -->
<div id="myModal1" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content" >
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Send Invitation</h4>
            </div>
            <div class="modal-body">
<g:form class="form-horizontal"  controller="topic" action="invite">

    <div class="form-group">
        <label class="control-label col-xs-4">Email/Username:</label>

        <div class="col-xs-8">
            <input type="email" class="form-control" name="emailId" id="emailId" placeholder="Enter email">
        </div>
    </div>

    <div class="form-group">
        <label class="pull-left col-xs-4">Topics</label>

        <div class="col-xs-8">
            <g:select name="topicName" class="form-control" from="${Subscription.findAllByUser(session.user).topic.name}"/>
        </div>
    </div>
    <div class="form-group">
        <div class="col-xs-4"></div>
        <div class="col-xs-4">
    <g:actionSubmit controller="topic" action="invite" class="form-control btn btn-success active" id="submit" value="Invite"
                    style="color:white;border:solid black;border-radius:7px"/>
        </div><div class="col-xs-4">
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
</div>
</div>

