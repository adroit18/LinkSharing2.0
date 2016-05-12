<div class="panel panel-default">
    %{--<g:set value="${userDetails}" var="details">--}%
    <div class="panel-body">
        <div class="col-xs-2">
            %{--<g:include controller="user" action="userImage" params='[username: "${session.user.username}"]'/>--}%
            <img src="${g.createLink(controller: 'user', action: 'image', params: [id: session.user.id])}" width="65px"
                 height="65px"/>
        </div>

        <div class="col-xs-10" style="font-style: italic">

            <g:if test="${session.user.username.startsWith('facebook_')}">
                <%=" Welcome, " + session.user.firstName + " " + session.user.lastName%>
            </g:if>
            <g:elseif test="${session.user.username.startsWith('google_')}">
                <%=" Welcome, " + session.user.firstName + " " + session.user.lastName%>
            </g:elseif>
            <g:else>
                <%=" Welcome, " + session.user.firstName + " " + session.user.lastName%>
            </g:else>

            <span class="text-muted"><br><%=session.user.emailId%><br>
            </span>

        </div>
        <br><br><br>

        <div class="row">
            <div class="col-xs-12 col-md-6 col-lg-3">
                <div class="panel panel-blue panel-widget ">
                    <div class="row no-padding">
                        <div class="col-sm-3 col-lg-5 widget-left">
                            <svg class="glyph stroked bag"><use xlink:href="#stroked-bag"></use></svg>
                        </div>

                        <div class="col-sm-9 col-lg-7 widget-right">
                            <div class="large">
                                <ls:subscriptionCount
                                        user="${session.user.username}"/>
                            </div>

                            <div class="text-muted">Subscriptions</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xs-12 col-md-6 col-lg-3">
                <div class="panel panel-red panel-widget">
                    <div class="row no-padding">
                        <div class="col-sm-3 col-lg-5 widget-left">
                            <svg class="glyph stroked app-window-with-content"><use
                                    xlink:href="#stroked-app-window-with-content"></use></svg>
                        </div>

                        <div class="col-sm-9 col-lg-7 widget-right">
                            <div class="large"><ls:topicCount user="${session.user}"/></div>

                            <div class="text-muted">Topics</div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
