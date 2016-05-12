<!doctype HTML>
<html>
<head>
    <meta name="layout" content="index"/>
    <title>Profile</title>
</head>

<body>

<div class="row">

    <div class="col-xs-3"></div>
    <div class="col-xs-5">

        <g:render template="/user/topicsOfUser"
                  model="${[user: user, topicList: topicList]}"/>
    </div>

    <div class="col-xs-4">


        <g:render template="/user/edit" model="${[user: user]}"/>


        <div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
             aria-hidden="true">
            <div class="modal-dialog ">
                <div class="modal-content">

                    <div class="modal-header modal-head">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title modal-head-title" id="myModalLabel">Confirm Delete</h4>
                    </div>

                    <div class="modal-body modal-select">
                        <label class="text-primary ">Are you sure you want to delete?</label>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-danger btn-ok cnfrm-del">Delete</button>
                    </div>
                </div>
            </div>
        </div>


        <div id="alertSuccess" class="alert-success  ajax-msg" style="display: none;">
            <label class="msg-label">Sucessfully updated</label>
        </div>

        <div id="alertError" class="alert-danger  ajax-msg" style="display: none;">
            <label class="msg-label">Error in updation</label>
        </div>
    </div>
</div>

<g:render template="/documentResource/create" model="[subscribed: subscribedTopics]"/>
<g:render template="/topic/create"/>
<g:render template="/topic/email"/>
<g:render template="/linkResource/create" model="[subscribed: subscribedTopics]"/>

</body>



</html>