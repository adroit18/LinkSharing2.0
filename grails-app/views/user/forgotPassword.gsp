<!doctype HTML>
<html>
<head>
    <meta name="layout" content="main"/>

    <script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>

    <script>

        $(function () {
            $("#forgetPasswordForm").validate({
                rules: {
                    recoveryemail: {
                        unique: true,
                        required: true,
                        email: true,
                        remote: "${createLink(controller: 'user',action: 'isExisting')}"
                    }
                },
                messages: {
                    recoveryemail: {
                        required:"Enter appropriate Email address",
                        remote: jQuery.validator.format("Email ID no recognized !!")
                    }

                },
                submitHandler: function (form) {
                    form.submit();
                }
            });

        });
    </script>

</head>

<body>
<div class="col-xs-4"></div>
<div class="col-xs-4">
<div class="panel panel-primary forgot-pass">
    <div class="panel-heading" style="background-color: rgba(0, 188, 212, 0.58); ">
        <h3 class="panel-title">Forgot Password</h3>
    </div>

    <div class="panel-body">
        <g:form class="form-box" name="forgetPasswordForm" >
            <div>

                <g:textField name="recoveryemail" class="form-control form-register-field" placeholder="Email"/>
            </div><br>
            <g:actionSubmit controller="user" name="button" value="Submit" action="forgotPassword" style="width: 75%; margin-left: 10%;"
                            class=" btn form-btn"/><br><br>

            <g:link controller="login" action="index">Go Back and Try Again !!</g:link>
        </g:form>
    </div>
</div>
</div>
<div class="col-xs-4"></div>
</body>

</html>