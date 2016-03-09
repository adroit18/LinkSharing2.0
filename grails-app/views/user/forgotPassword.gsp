<!doctype HTML>
<html>
<head>
    <meta name="layout" content="main"/>

</head>

<body>
<div class="col-xs-4"></div>
<div class="col-xs-4">
<div class="panel panel-primary forgot-pass">
    <div class="panel-heading" style="background-color: rgba(0, 188, 212, 0.58); ">
        <h3 class="panel-title">Forgot Password</h3>
    </div>

    <div class="panel-body">
        <g:form class="form-box" name="forgetPasswordForm" controller="login">
            <div>

                <g:textField name="email" class="form-control form-register-field" placeholder="Email"/>
            </div><br>
            <g:actionSubmit name="button" value="Submit" action="sendingMail" style="width: 75%; margin-left: 10%;"
                            class=" btn form-btn"/><br><br>

            <g:actionSubmit name="button" value="Try Again !!" action="index" style="width: 75%; margin-left: 10%;"
                            class=" btn form-btn"/>
        </g:form>
    </div>
</div>
</div>
<div class="col-xs-4"></div>
</body>
</html>