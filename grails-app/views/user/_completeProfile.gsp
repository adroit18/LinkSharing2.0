<div id="myModalCompleteProfile" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Send Invitation</h4>
            </div>

            <div class="modal-body">
                <g:form class="form-horizontal" name="complete" controller="user" action="completeProfile">
                    <g:select id="completedProfession" name="completedProfession" class="form-control"
                              from='${Constants.PROFESSION_LIST}'/>

                    <div class="modal-footer">

                    <g:actionSubmit class="btn btn-success" value="Submit" action="completeProfile"/>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </g:form>
            </div>


            </div>

        </div>

        <div id="dialog" title="Dialog Title">I'm in a dialog</div>
    </div>

</div>
