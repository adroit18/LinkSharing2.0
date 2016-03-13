<%@ page import="com.tothenew.linksharing.Resource" %>
<head>
    <script>
        $(document).on("click", ".read", function () {
            var link = $(this)
            var id = $(this).attr('data-id')
            $.ajax({
                url: "${createLink(controller: 'readingItem',action: 'changeIsRead')}",
                type: "post",
                dataType: 'json',
                data: {id: id, isRead: true},

                success: function (data) {
//                    data.status==true?alert(''):alert('Subscription could not be saved')
                    $(link).html(data.message);
                    window.location.reload();
                },

                error: function (xhr) {
                    alert(xhr.responseText);
                }

            });


        });

        $(document).on("click", ".unread", function () {

            var link = $(this)
            var id = $(this).attr('data-id')
            $.ajax({
                url: "${createLink(controller: 'readingItem',action: 'changeIsRead')}",
                type: "post",
                dataType: 'json',

                data: {id: id, isRead: false},

                success: function (data) {

//                    data.status==true?alert('Subscription Deleted Successfully'):alert('Subscription Not Found')

                    $(link).html(data.message);
                    window.location.reload();
                },
                error: function (xhr) {
                    alert(xhr.responseText);
                }

            });


        });

    </script>
</head>


<div class="panel panel-default" style="border:3px solid blueviolet;border-radius:8px">
    <div class="panel-heading" style="border-bottom:3px solid blueviolet;">Inbox</div>

    <g:each in="${inboxList}" var="inbox">
        <div class="panel-body">

            <div class="col-xs-2">

                %{--<g:include controller="user" action="userImage" params='[username: "${inbox[3]}"]'/>--}%
                <img src="${g.createLink(controller: 'user', action: 'image', params: [id: inbox[3].id])}" width="65px"
                     height="65px"/>
            </div>

            <div class="col-xs-10">${inbox[3]}<span class="text-muted">
                @${inbox[3]}

            </span>
                <span class="pull-right"><a href="${inbox[2]}">${inbox[2]}</a></span>

                <p>${inbox[1]}</p>

                <div class="col-xs-2"><i class="fa fa-facebook-official"></i>
                    <i class="fa fa-tumblr"></i>
                    <i class="fa fa-google-plus"></i></div>


                <div class="col-xs-5">
                    <g:if test="${Resource.get(inbox[4]).whichResource().equals("Document")}">
                        <g:link controller="DocumentResource" action="downloadDocument"
                                params="[fid: inbox[4]]"
                                style="text-decoration:underline;font-size:10px">Download</g:link>
                    </g:if>

                    <g:elseif test="${Resource.get(inbox[4]).whichResource().equals("Link")}">
                        <a href="${Resource.get(inbox[4]).url}"
                           style="text-decoration:underline;font-size:10px">View full site</a>
                    </g:elseif>
                </div>

                <div class="col-xs-3" data-id="${inbox[0]}"><ls:markAsRead id="${inbox[0]}"/></div>

                <div class="col-xs-2"><g:link controller="resource" action="show" params="[id: inbox[4]]"
                                              style="text-decoration:underline;font-size:10px">View Post</g:link>
                </div>
            </div>

            <div class="col-xs-12"><hr style="border-width:3px;padding:0px;border-color:blue"></div>

        </div>

    </g:each>
</div>