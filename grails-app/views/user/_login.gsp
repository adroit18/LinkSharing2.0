%{--..................................gMAIL ....................--}%
<script src="https://apis.google.com/js/platform.js" async defer></script>
<meta name="google-signin-client_id" content="447898827649-nsncn6vq1fa3uguv8jhgsggl9lru73rv.apps.googleusercontent.com">

<script>

    function onSignIn(googleUser) {
        var profile = googleUser.getBasicProfile();
        console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
        console.log('Name: ' + profile.getName());
        console.log('Image URL: ' + profile.getImageUrl());
        console.log('Email: ' + profile.getEmail());
    }
</script>

<script>
    function signOut() {
        var auth2 = gapi.auth2.getAuthInstance();
        auth2.signOut().then(function () {
            console.log('User signed out.');
        });
    }
</script>

%{--...........................................gmail ends...............................--}%



%{--...............................facebook........................--}%
<script>
    // This is called with the results from from FB.getLoginStatus().
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

        FB.getLoginStatus(function (response) {
            statusChangeCallback(response);
        });

    };

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
        FB.api('/me', function (response) {
            console.log('Successful login for: ' + response.name);
            document.getElementById('status').innerHTML =
                    'Thanks for logging in, ' + response.name + '!';
        });
    }


    FB.logout(function (response) {
        statusChangeCallback(response);
    });
</script>

<!--
  Below we include the Login Button social plugin. This button uses
  the JavaScript SDK to present a graphical Login button that triggers
  the FB.login() function when clicked.
-->

%{--.................................................facebook ends...................................--}%
<script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>

<script>

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


    $('#my-alert').text(message)
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
</head>



<div id="status">
</div>

<div class="panel panel-default" style="padding:8px;border:10px inset yellowgreen;">

    <div class="panel-heading" class="head" id="login" style="border-bottom:3px;border:5px double green;">Login</div>

    <div class="panel-body bdy" margin="10px 10px 10px 10px">

        <g:form name="loginForm" id="loginForm" controller="login" action="login" role="form" class="form-horizontal">
            <div class="form-group">
                <div class="col-xs-4"><label class="control-label">Username<sup>*</sup></label></div>

                <div class="col-xs-8"><input type="text" class="form-control" name="username"/></div>
            </div>

            <div class="form-group">
                <div class="col-xs-4"><label class="control-label">Password<sup>*</sup></label></div>

                <div class="col-xs-8"><input type="password" class="form-control" name="password"/></div>

            </div>

            <div class="form-group">
                <div class="col-xs-2"></div>

                <div class="col-xs-5">
                    <g:link controller="user" action="showForgotPassword">Forgot Password</g:link>

                </div>

                <div class="col-xs-5">
                    <g:actionSubmit value="login" class="btn btn-primary active"
                                    style="width:100%"/>
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-2"></div>

                <p id="my-alert" style="color: red;font-size: medium">${message}</p>

            </div>

            <fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
            </fb:login-button>
            <a href="#" onclick=" FB.logout()">Sign out</a>
            <br>

            <div class="g-signin2" data-onsuccess="onSignIn"></div>
            <a href="#" onclick="signOut();">Sign out</a>

        </g:form>
    </div>
</div>


