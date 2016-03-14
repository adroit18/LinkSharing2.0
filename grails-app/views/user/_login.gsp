<head><script>
    $('#my-alert').text(message)
        $("document").ready(function() {
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
</script></head>

<div class="panel panel-default" style="padding:8px;border:10px inset yellowgreen;">

    <div class="panel-heading" class="head" id="login" style="border-bottom:3px;border:5px double green;">Login</div>

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
                    <g:actionSubmit     value="login" class="btn btn-primary active"
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


