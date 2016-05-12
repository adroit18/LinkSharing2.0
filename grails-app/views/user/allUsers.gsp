<!doctype HTML>
<html>
<head>
    <meta name="layout" content="index"/>
    <title>Link Sharing</title>
    <script src="http://canvasjs.com/assets/script/canvasjs.min.js"></script>
    <script src="/js/chart-data.js"></script>

</head>

<body>

<div class="col-xs-3"></div>

<div class="container-fluid col-xs-9">

<div class="row">

    <g:form controller="user" action="userTable">
        <div class="col-xs-8">
            <label class="pull-left"><h3 style="text-align:center;text-decoration-style:wavy;
            font-style: italic">What users do u Want to see</h3></label>
        </div>
        </div>

        <div class="row">

            <div class="col-xs-4">
                <g:select from="['Show All Users', 'Show All Active Users', 'Show Only In-Active Users']" id="active"
                          name="active" class="btn-primary" value="None Selected">
                </g:select>

                <g:actionSubmit class=" btn btn-success" controller="user" action="userTable" value="Go"/>

            </div>

            <div class="col-xs-4">

                <h3 style="text-align:center;text-decoration-style:wavy;
                font-style: italic">OR</h3>
            </div>

            <div class="col-xs-4">
                <input type="text" name="q" class="form-control" id="q" placeholder="Or Search by Name..">
            </div>

        </div>

    </g:form>
    <br><br>

</div>

<div class="row">
    <div class="col-xs-4"></div>

    <div class="col-md-7 centered">
        %{--................................................................--}%


        <div id="updat">
            <g:render template="userlist" model="[userList: userList]"/>
        </div>

        <div style="font-size: 30px;text-align: center">
            <util:remotePaginate controller="user" action="userTable" prev="Back" next="Next" update="updat"
                                 total="${size}" max="5" params="[flag: 1, q: queryString1, active: queryString2]"/>
        </div>

        %{--.........................................................................--}%
    </div>

    <div class="col-xs-2"></div>
</div>

<div class="col-xs-4">
</div>

<div class="col-xs-6">

    <div class="row">

        <div id="chartContainer" style="height: 300px; width: 120%;" onload="adminChart();"></div>

    </div><!--/.row-->

</div>

<div class="col-xs-2"></div>

</body>
</html>

