<%@ page import="com.tothenew.linksharing.ReadingItem; com.tothenew.linksharing.ResourceRating; com.tothenew.linksharing.Resource; com.tothenew.linksharing.Topic" %>
<html>
<head>

    <meta name="layout" content="index"/>
    <title>Search</title>

</head>

<body>
<div class="col-xs-4"></div>

<div class="container">
    <div class="row">
        <div class="col-xs-7">
            <!-- Topic Panel -->
            <!-- ************************************************** -->
            %{--   <ls:trendingTopics/>
               <ls:topPosts/>--}%
            %{--<g:render template="/topic/trendingTopics" model="${[trendingTopics:Topic.trendingTopics]}"/>--}%
            %{--</div>--}%

            <div id="pagination1">
                <!-- Topic Posts Panel -->
                <!-- ************************************************ -->
                <div class="panel ">
                    <div class="panel-heading">

                        <h3 style="text-align:center;text-decoration-style:wavy;
                        font-style: italic">Search Results
                        </h3>

                    </div>
                    %{--.....................................................................--}%


                    <div id="pag">
                        <g:render template="/Search/searchResults" model="${resourceTopics}"/>

                        %{--<g:render template="/Search/resourceSearch" model="${searchResources}"/>--}%
                    </div>


                    <div style="font-size: 20px;font-style: italic;
                    text-align: center;display: block">

                        <util:remotePaginate update="pag" total="${size / 2}" controller="resource"
                                             action="search"
                                             next="Forward"
                                             prev="Back"
                                             max="5" params="[q: queryString, flag: 1]"/>

                    </div>
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