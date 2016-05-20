<g:each in="${trendingTopics}" var="trending" status="i">

    <div class="panel">
        <div class="panel-heading panel-title">

            <g:link value="topic" url="[controller: 'topic', action: 'index', params: [id: trending.id]]"
                    class="col-xs-8"
                    style="text-decoration:none"><svg class="glyph stroked arrow right"><use
                    xlink:href="#stroked-arrow-right"/>
            </svg>${trending.name}</g:link>

        </div>
        <br>

        <div class="panel-body">

            <div class="col-xs-2 pull-${i % 2 == 0 ? 'right' : 'left'}">
                <img src="${g.createLink(controller: 'user', action: 'image', params: [id: trending.createdBy.id])}"
                     width="65px" height="65px"/>

                <g:include controller="user" action="userImage" params='[username: "${trending.createdBy}"]'/>

            </div>

            <div class="col-xs-10 pull-left">
                <br>
                <span class="col-xs-4 text-muted">@${trending.createdBy}</span>
                <span class="col-xs-4" style="padding-left:1px">Subscriptions</span>
                <span class="col-xs-4" style="padding-left:1px">Posts</span><br>
                <span class="col-xs-4" style="color:blue;">

                    <g:if test="${session.user}">
                        <div data-id="tre">
                            <ls:showSubscribe topicId="${trending.id}"/>
                        </div>
                    </g:if>
                </span>
                %{--<span class="col-xs-4" style="color:blue;padding-left:1px">${trending.count}</span>--}%

                <span class="col-xs-4" style="color:blue;padding-left:1px"><ls:subscriptionCount
                        topicId="${trending.id}" user="${trending.createdBy}"/>
                </span>
                <span class="col-xs-2" style="color:blue;padding-left:1px"><ls:resourceCount
                        topicId="${trending.id}"/>
                </span>

            </div>
            <br><br><br><br>

        </div>

    </div>

    <div class="col-xs-12"><hr style="border-width:3px;padding:0px;border-color:darkgrey">
    </div>
</g:each>