<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="index"/>

    %{--..................................gMAIL ....................--}%
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <meta name="google-signin-client_id"
          content="447898827649-nsncn6vq1fa3uguv8jhgsggl9lru73rv.apps.googleusercontent.com">

    <script>

        function onSignIn(googleUser) {
            var profile = googleUser.getBasicProfile();
            console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
            console.log('Name: ' + profile.getName());
            console.log('Image URL: ' + profile.getImageUrl());
            console.log('Email: ' + profile.getEmail());

            var id_token = googleUser.getAuthResponse().id_token;
            console.log("ID Token: " + id_token);

            window.location = "/google/index?id=" + id_token


        }


    </script>

    %{--...........................................gmail ends...............................--}%



    %{--...............................facebook........................--}%
    <script>
        // This is called with the results from from FB.getLoginStatus().

        //function fbLogin() {

        function statusChangeCallback(response) {
            console.log('statusChangeCallback');
            console.log(response);
            // The response object is returned with a status field that lets the
            // app know the current login status of the person.
            // Full docs on the response object can be found in the documentation
            // for FB.getLoginStatus().
            if (response.status === 'connected') {
                // Logged into your app and Facebook.
                testAPI();
            } else if (response.status === 'not_authorized') {
                // The person is logged into Facebook, but not your app.
                document.getElementById('status').innerHTML = 'Please log ' +
                        'into this app.';
            } else {
                // The person is not logged into Facebook, so we're not sure if
                // they are logged into this app or not.
                document.getElementById('status').innerHTML = 'Please log ' +
                        'into Facebook.';
            }
        }

        // This function is called when someone finishes with the Login
        // Button.  See the onlogin handler attached to it in the sample
        // code below.
        function checkLoginState() {
            FB.getLoginStatus(function (response) {
                statusChangeCallback(response);
            });
        }

        window.fbAsyncInit = function () {
            FB.init({
                appId: '454549484736344',
                cookie: true,  // enable cookies to allow the server to access
                               // the session
                xfbml: true,  // parse social plugins on this pagef
                version: 'v2.5' // use graph api version 2.5
            });

            // Now that we've initialized the JavaScript SDK, we call
            // FB.getLoginStatus().  This function gets the state of the
            // person visiting this page and can return one of three states to
            // the callback you provide.  They can be:
            //
            // 1. Logged into your app ('connected')
            // 2. Logged into Facebook, but not your app ('not_authorized')
            // 3. Not logged into Facebook and can't tell if they are logged into
            //    your app or not.
            //
            // These three cases are handled in the callback function.


        };

        function fbLogin() {
            FB.getLoginStatus(function (response) {
                console.log("heloo world" + response)
                statusChangeCallback(response);
            });
        }
        // Load the SDK asynchronously
        (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s);
            js.id = id;
            js.src = "//connect.facebook.net/en_US/sdk.js";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));

        // Here we run a very simple test of the Graph API after login is
        // successful.  See statusChangeCallback() for when this call is made.
        function testAPI() {
            console.log('Welcome!  Fetching your information.... ');
            FB.api('/me?fields=name,id,first_name, last_name,picture, email', function (response) {
                console.log('Successful login for: ' + response.picture.data.url);
                var pic = response.picture.data.url;
                document.getElementById('status').innerHTML =
                        'Thanks for logging in helo , ' + response.last_name + '!';


                $('body').append("extraform");
                $("#fbusername").val(response.name)
                $("#id").val(response.id)

                /*..........dekho*/

                $("#fbfirstName").val(response.first_name)
                $("#fblastName").val(response.last_name)
                $("#fbemailId").val(response.email)
                $("#fbpicture").val(pic)

                $("#extraform").submit();

            });

        }

    </script>

    <!--
Below we include the Login Button social plugin. This button uses
the JavaScript SDK to present a graphical Login button that triggers
the FB.login() function when clicked.
-->

    %{--.................................................facebook ends...................................--}%



    <meta charset="UTF-8">
    <title>Sign-Up/Login Form</title>
    <link href='http://fonts.googleapis.com/css?family=Titillium+Web:400,300,600' rel='stylesheet' type='text/css'>

    <link rel="stylesheet" href="/css/normalize.css">

    <link rel="stylesheet" href="/css/style.css">

</head>


<body>
<div class="col-xs-4"></div>

<div class="col-xs-7">
<g:if test="${session.user}">

    <div class="col-xs-4 alert bg-success" role="alert">
         You are Already LoOoooged in !!
    </div>

</g:if>

<g:else>

    <div id="status">
        <g:if test="${loginMessage}">
            <div class="alert bg-danger" role="alert">
                <svg class="glyph stroked cancel"><use xlink:href="#stroked-cancel"
                                                       onclick="cancelLoginMessage()"></use>
                </svg> ${loginMessage}
            </div>
        </g:if>
    </div>

    <div class="form">

        <ul class="tab-group">
            <li class="tab active"><a href="#signup">Sign Up</a></li>
            <li class="tab"><a href="#login">Log In</a></li>
        </ul>

        <div class="tab-content">
            <div id="signup">
                <h1>Sign Up for Free</h1>

                <g:form class="form-horizontal" controller="user" action="registrationHandler"
                        name="registrationForm" enctype="multipart/form-data">

                    <div class="top-row">
                        <div class="field-wrap">
                            <label>
                                First Name<span class="req">*</span>
                            </label>
                            <input type="text" autocomplete="off" id="firstName" name="firstName"/>
                        </div>

                        <div class="field-wrap">
                            <label>
                                Last Name<span class="req">*</span>
                            </label>
                            <input type="text" autocomplete="off" id="lastName" name="lastName"/>
                        </div>
                    </div>

                    <div class="field-wrap">
                        <label>
                            Email Address<span class="req">*</span>
                        </label>
                        <input type="email" autocomplete="off" name="emailId"/>
                    </div>

                    <div class="field-wrap">
                        <label>
                            <User></User> Name<span class="req">*</span>
                        </label>
                        <input type="text" autocomplete="off" name="username" id="username"/>
                    </div>


                    <div class="field-wrap">
                        <label>
                            Set A Password<span class="req">*</span>
                        </label>
                        <input type="password" autocomplete="off" name="password"/>
                    </div>


                    <div class="field-wrap">
                        <label>
                            Confirm Password<span class="req">*</span>
                        </label>
                        <input type="password" autocomplete="off" name="password" name="confirmPassword"/>
                    </div>


                    <div class="field-wrap">
                        <label></label><input autocomplete="off" type="file" name="file" value="Browse"/>
                    </div>


                    <div class="field-wrap" style="color: white;font-style: italic">
                        <webcam:webcamAnchor/> &nbsp;Use Webcam to Click Picture !
                    </div>


                    <div class="field-wrap">
                        <g:submitButton controller="user" action="registrationHandler" value="Register"
                                        class="button button-block"
                                        name="submit"/>
                    </div>

                </g:form>

            </div>


            <div id="login">
                <h1>Welcome Back!</h1>

                <g:form name="loginForm" id="loginForm" url="/j_spring_security_check" role="form"
                        class="form-horizontal">

                    <div class="field-wrap">
                        <label>
                            User Name<span class="req">*</span>
                        </label>
                        <input autocomplete="off" name="j_username"/>
                    </div>

                    <div class="field-wrap">
                        <label>
                            Password<span class="req">*</span>
                        </label>
                        <input type="password" autocomplete="off" name="j_password"/>
                    </div>

                    <p class="forgot"><g:link controller="user"
                                              action="showForgotPassword">Forgot Password</g:link></p>

                    <div class="field-wrap">
                        <fb:login-button scope="public_profile,email" onlogin="fbLogin();">
                        </fb:login-button>
                    </div>

                    <br><br>

                    <div class="field-wrap">
                        <div class="g-signin2" data-onsuccess="onSignIn"></div>
                    </div>

                    <div class="field-wrap">
                        <g:actionSubmit value="Login" class="button button-block"
                                        style="width:100%"/>
                    </div>

                </g:form>

            </div>

        </div><!-- tab-content -->

    </div> <!-- /form -->
</div>
</g:else>

<style type="text/css">
.error {
    color: red;
    padding: 0px 30px 0px 0px;

}
</style>

<asset:javascript src="application.js"/>
<script src="/js/index.js"></script>

<script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>

<script>
    $(function () {
        $("#registrationForm").validate({
            errorElement: 'div',
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
                    required: "Please enter a valid email address",
                    remote: "Email ID already exists"
                },
                username: {
                    remote: "Username already exists"
                }
            },
            submitHandler: function (form) {
                form.submit();
            }
        });
    });


    $(function () {
        $("#loginForm").validate({
            rules: {
                username: "required",
                password: "required",
            },
            messages: {
                username: "Please enter Username",
                password: "Please enter appropriate password !!",
            },
            submitHandler: function (form) {
                form.submit();
            }
        });

    });


    //    $('#my-alert').text(message)
    $("document").ready(function () {
        $('#loginButton').click(function () {

            callAjax()
        });
        function callAjax() {
            $.ajax({
                url: "/login/login",
                type: "post",
                dataType: 'json',
                data: {ids: JSON.stringify(idList), option: option, id: id},

                success: function (data) {
                    console.log(data);
                },
                error: function (xhr) {
                    alert(xhr.responseText);
                }

            });
        }
    })
</script>

<script>



    function cancelLoginMessage() {
        $(document).ready(function () {
            $("#status").hide();

        })
    }
</script>


<form style="display:none" action="/facebook/fbLogin" id="extraform" name="extraform"
      method="post">
    <input type="hidden" name="username" id="fbusername" value="">
    <input type="hidden" name="id" id="id" value="">
    <input type="hidden" name="firstName" id="fbfirstName" value="">
    <input type="hidden" name="lastName" id="fblastName" value="">
    <input type="hidden" name="picture" id="fbpicture" value="">
    <input type="hidden" name="emailId" id="fbemailId" value="">
</form>

</body>

</html>
