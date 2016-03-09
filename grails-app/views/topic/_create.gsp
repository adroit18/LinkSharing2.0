<!--  3 Modal -->
<div id="myModal4" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Create Topic</h4>
            </div>

            <div class="modal-body ">

                <g:form class="form-horizontal" controller="topic" action="save">
                    <div class="form-group">
                        <label class="control-label col-xs-4">Name:</label>

                        <div class="col-xs-8">
                            <input type="text" class="form-control " name="name" id="name" placeholder="Name">

                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-xs-2 "></div><label class="col-xs-2">Visiblity:</label>

                        <div class="col-xs-8">
                            <select class="pull-right form-control" name="visibility" id="visibility">
                                <option>Public</option>
                                <option>Private</option>
                                <option>Global</option>
                                <option>Mid</option>
                            </select></div>
                    </div>

                    <div class="form-group">
                        <div class="col-xs-4"></div>

                        <div class="col-xs-4">
                            <g:actionSubmit
                                    class="form-control btn btn-default active" name="save" id="save"
                                    value="Save" style="color:black;border:solid black;border-radius:7px"/>
                        </div>

                        <div class="col-xs-4">
                            <button class="form-control btn btn-default active" id="cancel" id="cancel" value="Cancel"
                                    style="color:black;border:solid black;border-radius:7px">
                                Cancel</button>
                        </div>
                    </div>

                </g:form>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>


            %{--<g:hasErrors bean="${topic}" field="name">--}%
            %{--<g:eachError>--}%
            %{--<g:message error="${it?.name}">--}%
            %{--hello--}%
            %{--</g:message>--}%

            %{--</g:eachError>--}%

            %{--</g:hasErrors>--}%


            %{--<g:renderErrors bean="${topic}"/>--}%

            </div>

        </div>

    </div>
</div>


