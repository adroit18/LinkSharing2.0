<head><script>

    %{--alert("${message}");--}%
    $('#my-alert').text(message)
/*        $("document").ready(function() {
            $('#loginButton').click(function () {
                alert("calling login method..........");
                callAjax()
            });
            function callAjax() {
                $.ajax({
                    url: "/login/login",
                    type: "post",
                    dataType: 'json',
                    data: {ids: JSON.stringify(idList), option: option, id: id}
                    success: function (data) {
                        console.log(data);
                        <-----this logs the data in browser's console
                    },
                    error: function (xhr) {
                        alert(xhr.responseText);
                    }

                });
            }
        })*/
</script></head>

<div class="panel panel-default ">

    <div class="panel-heading" class="head" id="login">Login</div>

    <div class="panel-body bdy" margin="10px 10px 10px 10px">

        <g:form controller="login" action="login" role="form" class="form-horizontal">
            <div class="form-group">
                <div class="col-xs-4"><label class="control-label">Email/Username<sup>*</sup></label></div>

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
                    <g:actionSubmit     value="login" class="btn btn-default active"
                                    style="width:100%"/>
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-2"></div>

                <p id="my-alert">${message}</p>

            </div>

        </g:form>
    </div>
</div>


