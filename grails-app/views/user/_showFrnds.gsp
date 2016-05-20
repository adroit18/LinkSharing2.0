<head>
    <meta name="layout" content="index"/>
    <title>Link Sharing friends</title>
</head>

<body>
<div class="col-xs-3">
</div>

<div class="col-xs-7">
    <div class="panel">
        <div class="row">
            <g:if test="${users}">
                <div class="panel-heading">
                    <h3 style="text-align:center;text-decoration-style:wavy;
                    font-style: italic">Your Results:-
                    </h3>
                </div>

                <div class="panel-body">

                    <div class="panel">
                        <div class="panel-body">
                            <g:each in="${users}" var="user" status="index">

                                <div class="col-xs-2 pull-${index % 2 == 0 ? 'right' : 'left'}">
                                    %{--<g:include controller="user" action="userImage" params='[username: "${shares[3].username}"]'/>--}%
                                    <img src="${g.createLink(controller: 'user', action: 'image', params: [id: user.id])}"
                                         width="65px"
                                         height="65px"/>
                                </div>


                                <div class="col-xs-10 center-block">

                                    <h2>${index + 1}.&nbsp;${user.firstName}&nbsp;${user.lastName}</h2>

                                </div>


                                <div class="panel-body">

                                    <div class="col-xs-12 text-center">
                                        <h5>${user.emailId}</h5>
                                        <h5>${Constants.PROFESSION_LIST[user.profession - 1]}</h5>
                                        <em>Last Seen On:</em>
                                        ${user.lastLoginTime.getDateTimeString()}&nbsp; <br>
                                        %{--${user.lastLoginTime.date},&nbsp;--}%
                                        %{--${user.lastLoginTime.getYear()} at ${user.lastLoginTime.hours()}--}%
                                    </div>
                                    <br><br><br>

                                    <strong>Topics created:</strong><br>
                                    <g:each in="${user.topics}" var="topic" status="index1">

                                        <div class="col-xs-12">
                                            ${index1 + 1}.   <g:link value="topic"
                                                                     url="[controller: 'topic', action: 'index', params: [id: topic.id]]"
                                                                     style="text-decoration:none">

                                                ${topic.name}

                                            </g:link>
                                        </div>
                                    </g:each>


                                    <br><br><br>

                                    <div class="col-xs-12">
                                        <strong>Subscribed to Topics:</strong><br>
                                        <g:each in="${user.subscriptions}" var="sub" status="index2">
                                            <div class="col-xs-6">
                                                ${index2 + 1}.    <g:link value="topic"
                                                                          url="[controller: 'topic', action: 'index', params: [id: sub.topic.id]]"

                                                                          style="text-decoration:none">${sub.topic.name}

                                                </g:link>
                                            </div>
                                        </g:each>
                                    </div>

                                </div>

                                <hr style="border-width:3px;padding:0px;border-color:darkgrey">
                            </g:each>
                        </div>
                    </div>

                </div>

            </g:if>
            <g:else>

                <div class="panel-heading"><h3 style="text-align:center;text-decoration-style:wavy;
                font-style: italic">None To Show
                </h3>
                </div>

                <div class="panel-body">

                </div>

            </g:else>

        </div>
    </div>
</div>

<g:render template="/documentResource/create" model="[subscribed: subscribedTopics]"/>
<g:render template="/topic/create"/>
<g:render template="/topic/email"/>
<g:render template="/linkResource/create" model="[subscribed: subscribedTopics]"/>




</body>




