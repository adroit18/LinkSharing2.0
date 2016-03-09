<script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>

<script>

    $(function () {
        $("#linkform").validate({
            rules: {
                link: "required",
                description: "required",
            },
            messages: {
                link: "Please enter a proper link",
                description: "Please Describe the resource !!",
            },
            submitHandler: function (form) {
                form.submit();
            }
        });

    });


</script>
</head>


<!--  2 Modal -->
<div id="myModal2" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Share Link</h4>
            </div>

            <div class="modal-body">
                <g:form class="form-horizontal" name="linkform" id="linkform" controller="linkResource"
                        action="linkSave">
                    <div class="form-group">
                        <label class="control-label col-xs-4">Link:</label>

                        <div class="col-xs-8">
                            <input type="url" class="form-control" name="link" placeholder="Enter Link">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-xs-4">Description:</label>

                        <div class="col-xs-8">
                            <textarea placeholder="Description" name="description"></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-xs-2 "></div><label class="col-xs-2">Topic:</label>

                        <div class="col-xs-8">
                            <g:select class="btn dropdown-toggle" data-toggle="dropdown" name="topicName" id="doctopic"
                                      style="width:200px; " from="${subscribed}"/>

                        </div>
                    </div>


                    <div class="form-group">
                    <div class="col-xs-4"></div>

                    <div class="col-xs-4 pull-right">
                        <g:actionSubmit controller="linkResource" action="linkSave"
                                        class="form-control btn btn-default active" value="Submit"
                                        placeholder="Share"
                                        style="color:black;border:solid black;border-radius:7px"/>
                    </div>


                    %{--<div class="col-xs-4">--}%
                        %{--<g:actionSubmit class="form-control btn btn-default active" controller="login"--}%
                                        %{--action="index" value="Cancel" placeholder="Cancel"--}%
                                        %{--style="color:black;border:solid black;border-radius:7px"/>--}%
                    %{--</div>--}%
                </div>
                </g:form>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>








