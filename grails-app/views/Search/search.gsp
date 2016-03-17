<%@ page import="com.tothenew.linksharing.ReadingItem; com.tothenew.linksharing.ResourceRating; com.tothenew.linksharing.Resource; com.tothenew.linksharing.Topic" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Search</title>
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

<body>
<div class="container">
    <div class="row">
        <div class="col-xs-7">
            <!-- Topic Panel -->
            <!-- ************************************************** -->
            <ls:trendingTopics/>
            <ls:topPosts/>
            %{--<g:render template="/topic/trendingTopics" model="${[trendingTopics:Topic.trendingTopics]}"/>--}%
        </div>

        <div class="col-xs-5" id="pagination1">
            <!-- Topic Posts Panel -->
            <!-- ************************************************ -->
            <div class="panel panel-default" style="padding:8px;border:10px outset yellowgreen;">
                <div class="panel-heading" style="border-bottom:3px;border:5px double green;">
                    <div class="row">
                        <div class="col-xs-4">
                            <strong>Search Results</strong></div>
                    </div>
                </div>
                %{--.....................................................................--}%


                <div id="pagination">
                    <g:render template="/Search/topicSearch" model="${resourceTopics}"/>

                    <g:render template="/Search/resourceSearch" model="${searchResources}"/>
                </div>
                ${size}
                %{--<g:paginate total="${size}" controller="resource" action="search" next="Forward" prev="Back"--}%
                %{--max="10" params="[q: queryString]"></g:paginate>--}%
                %{--${size}--}%
                <div class="pagination center-block">
                    <util:remotePaginate update="m" total="${size/2}" controller="resource" action="search" next="Forward"
                                         prev="Back"
                                         max="5" params="[q: queryString]"/>
                </div>

                %{--<....................................>--}%




                %{--......................--}%
            </div>
        </div>
    </div>
    <!-- Row 2 -->
    %{--<div class="row">--}%
    <div class="col-xs-6">
        <!-- Subscription Panel-->

        <!-- ************************************************************ -->
        %{--<g:render template="/topic/topPosts" model="${[topPosts:ResourceRating.getTopPosts()]}"/>--}%
    </div>
    %{--</div>--}%
</div>



<g:render template="/documentResource/create" model="[subscribed: subscribedTopics]"/>
<g:render template="/topic/create"/>
<g:render template="/topic/email"/>
<g:render template="/linkResource/create" model="[subscribed: subscribedTopics]"/>

</body>
</html>