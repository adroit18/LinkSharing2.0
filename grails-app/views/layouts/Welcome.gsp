%{--
<!DOCTYPE html>
<html>
<head>
    <title><g:layoutTitle default="Grails"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/bootstrap', file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}" type="text/css">
    <asset:stylesheet src="jquery.raty.css"/>
    <script src="${resource(dir: 'js/jQuery', file: 'jquery.min.js')}"></script>
    <script src="${resource(dir: 'js/bootstrap', file: 'bootstrap.min.js')}"></script>
    <script src="${resource(dir: 'js/jQuery', file: 'jquery.validate.js')}"></script>
    <script src="${resource(dir: 'js/linksharing', file: 'linksharing.js')}"></script>

    <asset:javascript src="jquery.raty.js"/>

    <g:layoutHead/>

    <g:javascript>

        $(function(){

            $( "#saveTopic" ).click(function() {

            var isValid = $("#createTopicForm").valid()
            if(isValid){
                var visibility = $("#topicSelect option:selected").val();
                var topicName = $("#topicName").val();
                console.log(topicName);
                        $.ajax({
                            url:"${g.createLink(controller: 'topic', action: 'save')}",
                            data: {
                                visibility : visibility , topicName : topicName
                            },
                            type: 'POST',
                            success: function(data) {
                            $("#alertSuccess").show();
                            $(".ajax-msg").delay(1000).fadeOut("slow", function () { $(this).hide(); });
                             window.location.reload();
                            },
                            error: function() {
                            $("#alertError").show();
                            $(".ajax-msg").delay(1000).fadeOut("slow", function () { $(this).hide(); });
                             window.location.reload();
                            }
                });
                }
             });


             $(document).on('click', ".markReadInbox", function () {
                var id = $(this).attr('data-resource-id');
                $.ajax({
                    url: $(this).attr('data-ajax-url'),
                    data: "readResourceId=" + $(this).attr('data-resource-id'),
                    success: function (data) {
                        if (data) {
                            $(".readResourceHide-" + id).hide(500)
                        }
                    }
                });
            });


            $("#btnSaveLink").click(function(){
		       $.ajax({
			    url: "${g.createLink(controller: 'linkResource', action: 'linksave')}",
			    data: $('#linkResourceForm').serialize(),
			    type: 'POST',
                success: function(data){
                     $("#alertSuccess").show();
                    $(".ajax-div").delay(1000).fadeOut("slow", function () { $(this).hide(); });
                   },
                error: function(){
                    $("#alertError").show();
                    $(".ajax-div").delay(1000).fadeOut("slow", function () { $(this).hide(); });
                    }
                });
	        });

        $.clearInput = function () {
           $('form').find('input[type=text], input[type=password], input[type=number], input[type=email], textarea').val('');
       };

       $('.modal').on('hidden.bs.modal', function () {
              $.clearInput();
       });

  });
    </g:javascript>

</head>

<body>
--}%
%{--<g:render template="/templates/create_topic"/>--}%%{--

<g:render template="/user/show"/>
<div class="msg-alert">
    <g:if test="${flash.message}">
        <div class="alert alert-success fade in">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            ${flash.message}
        </div>
    </g:if>
    <g:if test="${flash.error}">
        <div class="alert alert-danger  fade in">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            ${flash.error}
        </div>
    </g:if>
</div>

<div id="alertSuccess" class="alert-success  ajax-div ajax-msg" style="display: none;">
    <label class="msg-label">Sucess</label>
</div>

<div id="alertError" class="alert-danger  ajax-div ajax-msg ajax-msg-error" style="display: none;">
    <label class="msg-label">Error</label>
</div>


<g:layoutBody/>
</body>
</html>--}%
