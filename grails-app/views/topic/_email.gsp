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
                <g:form class="form-horizontal">

                    <div class="form-group">
                        <label class="control-label col-xs-4" for="email">Email/Username:</label>
                        <div class="col-xs-8">
                            <input type="email" class="form-control" id="email" placeholder="Enter email">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="pull-left col-xs-4" for="pwd">Password:</label>
                        <div class="col-xs-8">
                            <input type="password" class="form-control" id="pwd" placeholder="Enter password">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-4"></div>
                        <div class="col-xs-4">
                            <input type="Login" class="form-control btn btn-default active" id="submit" placeholder="Invite" style="color:black;border:solid black;border-radius:7px">
                        </div><div class="col-xs-4">
                        <input type="Login" class="form-control btn btn-default active" id="submit" placeholder="Cancel" style="color:black;border:solid black;border-radius:7px">
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

