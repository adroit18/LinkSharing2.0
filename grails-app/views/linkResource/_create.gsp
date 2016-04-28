<head>
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

                <div id="dialogSuccessLink" title="Dialog Title"
                     style="display:none;color: #00aa00;font-size: 25px">Success</div>

                <div id="dialogErrorLink" title="Dialog Title"
                     style="display:none;color: red;font-size: 25px">Error</div>
                <h4 class="modal-title">Share Link</h4>
            </div>

            <div class="modal-body">
                <g:form class="form-horizontal" name="linkform" id="linkform" controller="linkResource"
                        action="linkSave">
                    <div class="form-group">
                        <label class="control-label col-xs-4">Link:</label>

                        <div class="col-xs-8">
                            <input type="url" class="form-control" id="link" name="link" placeholder="Enter Link">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-xs-4">Description:</label>

                        <div class="col-xs-8">
                            <textarea placeholder="Description" name="description" id="descriptionLink"></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-xs-2 "></div><label class="col-xs-2">Topic:</label>

                        <div class="col-xs-8">
                            <g:select class="btn dropdown-toggle form-control" data-toggle="dropdown" name="topicName"
                                      id="linkTopic"
                                      style="width:200px;border: 1px solid silver" from="${subscribed}"/>

                        </div>
                    </div>


                    <div class="form-group">
                        <div class="col-xs-4"></div>

                        <div class="col-xs-4 pull-right">
                            <input type="button" id="linkSaveButton"
                                   class="form-control btn btn-success active" value="Submit"
                                   placeholder="Share"
                                   style="color:white;border:solid black;border-radius:7px"/>
                        </div>

                    </div>
                </g:form>

                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="application/javascript">

    $('#linkSaveButton').click(function () {
                if ($("#linkform").valid()) {
                    event.preventDefault()
                    $.ajax({
                        url: "${createLink(controller:'linkResource',action: 'linkSave')}",
                        type: 'post',
                        dataType: 'json',
                        data: {
                            link: $('#link').val(),
                            description: $('#descriptionLink').val(),
                            topicName: $('#linkTopic').val()
                        },
                        success: function (data) {
                            $("#dialogSuccessLink").show().delay(1000).fadeOut();
                        },
                        error: function (xhr) {
                            $("#dialogErrorLink").show().delay(1500).fadeOut();
                        }

                    })
                }
            }
    );


</script>






