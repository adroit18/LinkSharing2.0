<head>
    <meta name="layout" content="index"/>
</head>

<%@ page import="com.tothenew.linksharing.Resource" %>
<style type="text/css">
#customBtn {
    display: inline-block;
    background: white;
    color: #444;
    width: 80px;
    border-radius: 5px;
    border: thin solid #888;
    box-shadow: 1px 1px 1px grey;
    white-space: nowrap;
}

#customBtn:hover {
    border: medium outset cyan;
    cursor: pointer;
}
</style>





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
        $(document).delegate(".read", "click", function () {

            var link = $(this)
            var id = $(this).attr('data-id')


            $.ajax({
                url: "${createLink(controller: 'readingItem',action: 'changeIsRead')}",
                type: "post",
                dataType: 'json',
                data: {id: id, isRead: true},

                success: function (data) {
                    data.status == true ? $("#SuccessMsg").show().delay(2000).fadeOut().text('Marked as Unread')
                            : $("#ErrorMsg").show().delay(2000).fadeOut().text('Marked as Read');

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

        $(document).delegate(".unread", "click", function () {

            var link = $(this)
            var id = $(this).attr('data-id')
            $.ajax({
                url: "${createLink(controller: 'readingItem',action: 'changeIsRead')}",
                type: "post",
                dataType: 'json',

                data: {id: id, isRead: false},

                success: function (data) {
                    data.status == true ? $("#SuccessMsg").show().delay(2000).fadeOut().text('Marked as Read')
                            : $("#ErrorMsg").show().delay(2000).fadeOut().text('Marked as Unread');


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

<div class="col-xs-4"></div>

<div class="panel col-xs-7 ">

    <h3 style="text-align:center;text-decoration-style:wavy;
    font-style: italic">INBOX</h3>

    <g:each in="${inboxList}" var="inbox" status="i">
        <div class="scroll">

            <div class="panel-heading ">
                <div class="col-xs-12 col-md-6 col-lg-3 no-padding">
                    <div class="panel panel-teal panel-widget">
                        <div class="row no-padding">
                            <div class="col-sm-3 col-lg-5 widget-left">
                                <svg class="glyph stroked app-window"><use xlink:href="#stroked-app-window"><use
                                        xlink:href="#stroked-male-user"></use></svg>
                            </div>

                            <div class="col-sm-9 col-lg-7 widget-right">
                                <div class="large">${i + 1}.</div>

                                <div class="text-muted"></div>
                            </div>
                        </div>
                    </div>
                </div>



                ${inbox[1]}

            </div>

            <br><br>

            <div class="panel-body">

                <div class="col-xs-2 pull-${i % 2 != 0 ? 'right' : 'left'}">

<g:include controller="user" action="userImage" params='[username: "${inbox[3]}"]'/>

                    <img src="${g.createLink(controller: 'user', action: 'image', params: [id: inbox[3].id])}"
                         width="65px"
                         height="65px"/>
                </div>

                <div class="col-xs-10">${inbox[3]}<span class="text-muted">
                    @${inbox[3]}

                </span>
                    <span class="pull-right"><a href="${inbox[2]}">${inbox[2]}</a></span>

                    <br>
                    <br>


                    <span class="col-xs-3">

                        <p class="fb-share-button" data-href="${request.getRequestURL().toString()}"
                           data-layout="button_count"></p>
                        <br>


                        <input type="button"
                               id="customBtn"
                               class="g-interactivepost"
                               data-contenturl="${inbox[2]}"
                               data-contentdeeplinkid="/pages"
                               data-clientid="447898827649-nsncn6vq1fa3uguv8jhgsggl9lru73rv.apps.googleusercontent.com"
                               data-cookiepolicy="single_host_origin"
                               data-prefilltext="Want to Say Something..."
                               data-calltoactionlabel="CREATE"
                               data-calltoactionurl="${inbox[2]}"
                               data-calltoactiondeeplinkid="/pages/create"
                               value="Google+">

                    </input>

                    </span>


                    <div class="col-xs-4">
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

                <div class="col-xs-12"><hr style="border-width:3px;padding:0px;border-color:darkgrey">
                </div>

            </div>

        </div>
    </g:each>

</div>



<g:render template="/documentResource/create" model="[subscribed: subscribedTopics]"/>
<g:render template="/topic/create"/>
<g:render template="/topic/email"/>
<g:render template="/linkResource/create" model="[subscribed: subscribedTopics]"/>

<script>
    $(document).ready(function(){
        $('.scroll').jscroll({
            autoTrigger: false
        });
    });

</script>