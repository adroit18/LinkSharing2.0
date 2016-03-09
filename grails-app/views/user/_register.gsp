<head>
    <script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>

    <script>
        $(function () {
            $("#registrationForm").validate({
                rules: {
                    firstName: "required",
                    lastName: "required",
                    emailId: {
                        unique: true,
                        required: true,
                        email: true
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
                        remote: {
                            url: ''
                        }
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
                    emailId: "Please enter a valid email address"

                },

                submitHandler: function (form) {
                    form.submit();
                }
            });

            $("#registrationForm").validate({});

        });

    </script>
</head>


<div class="panel panel-default ">
    <div class="panel-heading" id="head">Register</div>

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

                <div class="col-xs-7"><g:textField name="emailId"
                                                   class="form-control form-register-field"></g:textField>
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-5"><label class="control-label">Username<sup>*</sup></label></div>

                <div class="col-lg-7"><g:textField name="username"
                                                   class="form-control form-register-field"></g:textField>
                </div></div>

            <div class="form-group">
                <div class="col-xs-5"><label class="control-label">Password<sup>*</sup></label></div>

                <div class="col-xs-7"><g:passwordField name="password"
                                                       class="form-control form-register-field"></g:passwordField>
                </div></div>

            <div class="form-group">
                <div class="col-xs-5"><label class="control-label">Confirm Password<sup>*</sup></label></div>

                <div class="col-xs-7"><g:passwordField name="confirmPassword"
                                                       class="form-control form-register-field"></g:passwordField>
                </div></div>

            <div class="form-group">
                <div class="col-xs-5"><label class="control-label">Profile Picture<sup>*</sup></label></div>

                <div class="col-xs-7"><input type="file" name="file" value="Browse"/>
                </div></div>

            <div class="form-group">
                <g:submitButton controller="User" action="registrationHandler" value="Register"
                                class="btn form-btn register-btn col-xs-6 col-xs-offset-3 "
                                name="submit"></g:submitButton></div>
        </g:form>
    </div>
</div>


















































































