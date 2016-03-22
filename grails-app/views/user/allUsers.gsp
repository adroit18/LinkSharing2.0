<!doctype HTML>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Link Sharing</title>
</head>

<body>

<div class="container-fluid">

<div class="row">

    <g:form controller="user" action="userTable">
        <div class="col-xs-4">
            <label class="pull-left"><h3>What users do u Want to see</h3></label>
        </div>

        <div class="col-xs-4">
            <g:select from="['Show All Users', 'Show All Active Users', 'Show Only In-Active Users']" id="active"
                      name="active" class="btn-primary" value="None Selected">
            </g:select></div>

        <div class="col-xs-4">
            <input type="text" name="q" class="form-control" id="q" placeholder="Or Search by Name..">
        </div>
        </div>
        <div class="col-xs-5"></div>

        <div class="col-xs-4 center-block">

            <g:actionSubmit class=" btn btn-success" controller="user" action="userTable" value="Go"/>

        </div>

    </g:form>
    <br><br>

</div>

<div >
    <div class="row">
        <div class="col-md-2"></div>

        <div class="col-md-8 centered" >
                %{--................................................................--}%


                <div id="updat">
                    <g:render template="userlist" model="[userList: userList]"/>
        </div>
            <util:remotePaginate controller="user" action="userTable" prev="Back" next="Next" update="updat"
                                 total="${size}" max="2" params="[flag: 1, q: queryString1, active: queryString2]"/>


            %{--.........................................................................--}%
        </div>

        <div class="col-md-2"></div>
    </div>

</div>

</body>
</html>