<!doctype HTML>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Link Sharing</title>
</head>

<body>
<div class="container-fluid">
    <div class="row ">
        <h3 class="text-success text-center">Registering User Failed</h3>

        <div style="color:red">
            <g:hasErrors>
                <g:eachError><p><g:message error="${it}"/></p></g:eachError>
            </g:hasErrors>
        </div>

        <h3 class="text-center" style="color: green">Click
        <g:link controller="Login" action="index">here</g:link> to login</h3>
       </h3>

    </div>
</div>
</body>
</html>