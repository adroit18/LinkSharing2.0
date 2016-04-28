<head>
    <script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>

    <script>

        $(function () {
            $("#createTopic").validate({
                rules: {
                    nameCreateTopic: "required",

                },
                messages: {
                    nameCreateTopic: "Please enter a proper Topic Name",

                },
                submitHandler: function (form) {
                    form.submit();
                }
            });

        });


    </script>
</head>

<div id="myModal4" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>

                <div id="dialogSuccessCreateTopic" title="Dialog Title"
                     style="display:none;color: #00aa00;font-size: 25px">Success</div>

                <div id="dialogErrorCreateTopic" title="Dialog Title"
                     style="display:none;color: red;font-size: 25px">Some Error Occured</div>
                <h4 class="modal-title">Create Topic</h4>

            </div>

            <div class="modal-body ">

                <g:form class="form-horizontal" controller="topic" action="save" name="createTopic" id="createTopic">
                    <div class="form-group">
                        <label class="control-label col-xs-4">Name:</label>

                        <div class="col-xs-8">
                            <input type="text" class="form-control " name="nameCreateTopic" id="nameCreateTopic"
                                   placeholder="Name">

                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-xs-2 "></div><label class="col-xs-2">Visiblity:</label>

                        <div class="col-xs-8">
                            <select class="pull-right form-control" name="visibilityCreateTopic"
                                    id="visibilityCreateTopic">
                                <option>Public</option>
                                <option>Private</option>

                            </select></div>
                    </div>

                    <div class="form-group">
                        <div class="col-xs-4"></div>

                        <div class="col-xs-4">
                            <input type="button"
                                   class="form-control btn btn-success active" name="submitCreateTopic"
                                   id="submitCreateTopic"
                                   value="Save" style="color:white;border:solid black;border-radius:7px"/>
                        </div>

                        <div class="col-xs-4">

                        </div>
                    </div>

                </g:form>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Done Adding Topics</button>

            </div>

        </div>

    </div>
</div>


<script type="application/javascript">

    $('#submitCreateTopic').click(function () {
        if ($("#createTopic").valid()) {
            event.preventDefault()
            $.ajax({
                url: "${createLink(controller:'topic',action: 'save')}",
                type: 'post',
                dataType: 'json',
                data: {
                    name: $('#nameCreateTopic').val(),
                    visibility: $('#visibilityCreateTopic').val()
                },
                success: function (data) {
                    $("#dialogSuccessCreateTopic").show().delay(1000).fadeOut();
                },
                error: function (xhr) {
                    $("#dialogErrorCreateTopic").show().delay(1500).fadeOut();
                }

            })
        }
    });


</script>
