<!--  3 Modal -->
<div id="myModal3" class="modal fade" role="dialog" xmlns="http://www.w3.org/1999/html">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">

        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Share Document</h4>
        </div>

        <div class="modal-body">
        <g:form enctype="multipart/form-data" class="form-horizontal" >

            <div class="form-group">
                <label class="control-label col-xs-4">Document:</label>

                <div class="col-xs-8">
                    <input class="form-control" type="file" name="file" value="Browse"/>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-xs-4">Description:</label>

                <div class="col-xs-8">
                    <textarea placeholder="Description" name="description"></textarea>
                </div>
            </div>

            <br class="form-group">

            <div class="col-xs-2 "></div><label class="col-xs-2">Topic:</label>

            <div class="col-xs-8">
                <g:select class="btn dropdown-toggle form-control" data-toggle="dropdown" name="topic.id"
                          style="width:200px;border: 1px solid silver" optionKey="id" optionValue="name" from="${subscribed}"/>
            </div>
<br><br><br>
            <div class="form-group">

                <div class="col-xs-4"></div>

                <div class="col-xs-4">
                    <g:actionSubmit  controller="documentResource" action="documentSave" class="form-control btn btn-success active" value="Submit" placeholder="Share"
                                     style="color:white;border:solid black;border-radius:7px"/>
                </div>

                <div class="col-xs-4">
                    <g:actionSubmit class="form-control btn btn-primary active" controller="login"
                                    action="index" value="Cancel" placeholder="Cancel"
                                    style="color:white;border:solid black;border-radius:7px"/>
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
</div>