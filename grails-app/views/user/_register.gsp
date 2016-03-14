<head>
    <script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>

    <script>
        $(function () {
            $("#registrationForm").validate({
                rules: {
                    firstName: "required",
                    lastName: "required",
                    emailId: {
//                        unique: true,
                        required: true,
                        email: true,
                        remote: "${createLink(controller: 'user',action: 'isEmailIdValid')}"
                    },
                    password: {
                        required: true,
                        minlength: 5
                    },
                    confirmPassword: {
                        required: true,
                        minlength: 5
                    },
                    username: {
                            remote: "${createLink(controller: 'user',action: 'isUsernameValid')}"
                    }
                },

// Specify the validation error messages
                    messages: {
                        firstname: "Please enter your first name",
                        lastname: "Please enter your last name",
                        password: {
                            required: "Please provide a password",
                            minlength: "Your password must be at least 5 characters long"
                        },
                        emailId: {
                          required:  "Please enter a valid email address",
                           remote: jQuery.validator.format("Email ID already exists")
                        },
                        username: {
                            remote: jQuery.validator.format("Username already exists")
                        }

                    },

                    submitHandler: function (form) {
                        form.submit();
                    }

            });

        });

    </script>
</head>


<div class="panel panel-default " style="padding:8px;border:10px inset yellowgreen;">
    <div class="panel-heading" id="head" style="border-bottom:3px;border:5px double green;">Register</div>

<div class="panel-body bdy" margin="10px 10px 10px 10px">

    <g:form class="form-horizontal" controller="User" action="registrationHandler" id="registrationForm"
            name="registrationForm" enctype="multipart/form-data">

        <div class="form-group">
            <div class="col-xs-5"><label class="control-label">First Name<sup>*</sup></label></div>

            <div class="col-xs-7 "><g:textField id="firstName" name="firstName"
                                                class="col-xs-7 form-control form-register-field"></g:textField>
            </div>
        </div>

        <div class="form-group">
            <div class="col-xs-5"><label class="control-label">Last Name<sup>*</sup></label></div>

            <div class="col-xs-7"><g:textField id="lastName" name="lastName"
                                               class="col-xs-7 form-control form-register-field"></g:textField></div>
        </div>

        <div class="form-group">
            <div class="col-xs-5"><label class="control-label">Email<sup>*</sup></label></div>

            <div class="col-xs-7"><g:textField name="emailId" class="form-control form-register-field"></g:textField>
            </div>
        </div>

        <div class="form-group">
            <div class="col-xs-5"><label class="control-label">Username<sup>*</sup></label></div>

            <div class="col-lg-7"><g:textField name="username" id="username"
                                               class="form-control form-register-field"></g:textField>
            </div></div>

        <div class="form-group">
        <div class="col-xs-5"><label class="control-label">Password<sup>*</sup></label></div>

        <div class="col-xs-7"><g:passwordField name="password"
                                               class="form-control form-register-field"></g:passwordField>
        </div>                   </div>

        <div class="form-group">
            <div class="col-xs-5"><label class="control-label">Confirm Password<sup>*</sup></label></div>

            <div class="col-xs-7"><g:passwordField name="confirmPassword"
                                                   class="form-control form-register-field"></g:passwordField>
            </div></div>

        <div class="form-group">
            <div class="col-xs-5"><label class="control-label">Profile Picture<sup>*</sup></label></div>

            <div class="col-xs-7"><input class="form-control" type="file" name="file" value="Browse"/>
            </div></div>

        <div class="form-group">
            <g:submitButton controller="User" action="registrationHandler" value="Register"
                            class="btn btn-success form-btn register-btn col-xs-6 col-xs-offset-3 "
                            name="submit"></g:submitButton></div>
    </g:form>
</div>
</div>


















































































