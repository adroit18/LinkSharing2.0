<%@ page import="com.tothenew.linksharing.*" %>

<div class="panel panel-default " style="border:none">
    <div class="panel-heading head" id="topPosts">
        Top Posts

        <div class="pull-right "><form>
            <select class="form-control" id="sel1" style="height:29px">
                <option>Public</option>
                <option>Private</option>
                <option>Global</option>
                <option>Mid</option>
            </select></form>
        </div>

    </div>

<g:each in="${resourceList}" var="resource">
    <div class="panel-body bdy" margin="10px 10px 10px 10px">
        <div class="row">
            <div class="col-xs-2">
                <g:include controller="user" action="userImage" params='[username: "${resource[4]}"]'/>

            </div>

            <div class="col-xs-10">
                <div>${resource[4]}<span class="text-muted">@${resource[4]} ${resource[5]}</span>

                    <div class="pull-right"><a href="https://${resource[1]}">${resource[1]}</a></div>

                    <p>
                        ${resource[2]}
                    </p>

                    <i class="fa fa-facebook-official"></i>
                    <i class="fa fa-tumblr"></i>
                    <i class="fa fa-google-plus"></i>


                    <span><g:link controller="resource" action="show" params="[id:resource[0]]" style="text-decoration:underline;font-size:10px">View Post</g:link>
                    </span>

                </div>

            </div>

        </div>
    </div></br><hr style="border-width:3px;padding:0px;border-color:blue">
</g:each>
</div>

