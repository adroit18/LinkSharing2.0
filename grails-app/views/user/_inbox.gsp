<%@ page import="com.tothenew.linksharing.Resource" %>


%{--........................gmail...............................--}%
<script>
    window.___gcfg = {
        lang: 'en-US',
        parsetags: 'onload'
    };
</script>
<script src="https://apis.google.com/js/platform.js" async defer></script>







%{--................................gmail ends..................................--}%






%{--..........................................fb...............................--}%
<head>

    <div id="fb-root"></div>

    <script>
        window.fbAsyncInit = function () {
            FB.init({
                appId: '454549484736344', status: true, cookie: true,
                xfbml: true
            });
        };
        (function () {
            var e = document.createElement('script');
            e.async = true;
            e.src = document.location.protocol +
                    '//connect.facebook.net/en_US/all.js';
            document.getElementById('fb-root').appendChild(e);
        }());
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#share_button').click(function (e) {
                e.preventDefault();
                FB.ui(
                        {
                            method: 'feed',
                            name: 'This is the content of the "name" field.',
                            link: 'http://localhost:8080/',
                            picture: 'http://localhost:8080/img.png',
                            caption: 'This is the content of the "caption" field.',
                            description: 'This is the content of the "description" field, below the caption.',
                            message: ''
                        });
            });
        });
    </script>

    %{--...................................................fb ends.......................--}%





















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
                    data.status == true ? alert('Marked as Unread') : alert('Marked as Read')

                    $(link).replaceWith(data.message)
//                    $(link).hide()
//                    $(link).html(data.message).show()
                    // window.location.reload();
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

                    data.status == true ? alert('Marked as Read') : alert('Marked as Unread')
                    $(link).replaceWith(data.message)
//                      window.location.reload();
                },
                error: function (xhr) {
                    alert(xhr.responseText);
                }

            });


        });

    </script>
</head>


<div class="panel panel-default" style="padding:8px;border:10px outset yellowgreen;">
    <div class="panel-heading" style="border-bottom:3px;border:5px double green;">Inbox</div>

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

                <div class="col-xs-2">
                    <input type="button" id="share_button" value="share"/>

                    %{--<div class="fb-share-button" id="share_button"--}%
                    %{--data-href="http://localhost:8080/"--}%
                    %{--data-layout="button_count">--}%
                    %{--</div>--}%

                    <i class="fa fa-tumblr"></i>

                    <div class="fb-share-button" data-href="${request.getRequestURL().toString()}"
                         data-layout="button_count"></div>



                    <input type="button"
                           class="g-interactivepost"
                           data-contenturl="${inbox[2]}"
                           data-contentdeeplinkid="/pages"
                           data-clientid="447898827649-nsncn6vq1fa3uguv8jhgsggl9lru73rv.apps.googleusercontent.com"
                           data-cookiepolicy="single_host_origin"
                           data-prefilltext="Want to Say Something..."
                           data-calltoactionlabel="CREATE"
                           data-calltoactionurl="${inbox[2]}"
                           data-calltoactiondeeplinkid="/pages/create"

                           value="Share on Google +">

                </input>

                </div>


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

            <div class="col-xs-12"><hr style="border-width:3px;padding:0px;border-color:green">
                <hr style="border-width:3px;padding:0px;border-color:green"></div>

        </div>

    </g:each>
</div>