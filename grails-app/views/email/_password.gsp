<%@ page contentType="text/html"%>
<body>
<h2>Hello ${userName}!! Please login using the new password generated for your account. Also it is advised to change your password after logging in.</h2>
<p>${newPassword}</p>
<g:link url="${serverUrl}/login/index">Login</g:link>
</body>