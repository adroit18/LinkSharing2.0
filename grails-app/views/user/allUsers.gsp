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
</div> <div class="col-xs-4">
            <g:select from="['Show All Users','Show All Active Users','Show Only In-Active Users']" id="active" name="active" class="btn-primary" value="None Selected">
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
</div>

    <div class="row">
        <div class="col-md-2"></div>

        <div class="col-md-8 centered">
            <table border="1px" class="table table-striped table-bordered table-hover" style="padding: 10px;">
                <tr>
                    <td class="table-header">Id</td>
                    <td class="table-header">Username</td>
                    <td class="table-header">Email</td>
                    <td class="table-header">Firstname</td>
                    <td class="table-header">Lastname</td>
                    <td class="table-header">Active</td>
                    <td class="table-header">Manage</td>
                </tr>
                <g:each in="${userList}" var="user">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.username}</td>
                        <td>${user.emailId}</td>
                        <td>${user.firstName}</td>
                        <td>${user.lastName}</td>
                        <g:if test="${user.isActive}">
                            <td>Yes</td></g:if>
                        <g:else>
                            <td>No</td>
                        </g:else>
                        <g:if test="${user.isActive}">
                            <td><g:link class="anchor-nounderline" controller="user" action="deactivate"
                                        params="[userId: user.id]">Active</td></g:link>
                        </g:if>
                        <g:else>
                            <td><g:link class="anchor-nounderline" controller="user" action="activate"
                                        params="[userId: user.id]">Deactivated</td></g:link>
                        </g:else>
                    </tr>
                </g:each>
            </table>
        </div>

        <div class="col-md-2"></div>
    </div>

</div>
</body>
</html>