%{--<html>--}%
%{--<head>--}%
    %{--<meta name="layout" content="main"/>--}%
    %{--<title>Form</title>--}%
%{--</head>--}%

%{--<body>--}%

%{--<g:hasErrors bean="${user}" field="firstName">--}%
    %{--<g:eachError>--}%
        %{--<g:message error="${it?.firstName}">--}%

        %{--</g:message>--}%

    %{--</g:eachError>--}%

%{--</g:hasErrors>--}%

%{--<g:renderErrors bean="${user}"/>--}%

%{--<g:form controller="Util" action="index">--}%
    %{--<label>First Name:</label>--}%
    %{--<g:textField name="firstName"/><br/>--}%
    %{--<label>Last Name:</label>--}%
    %{--<g:textField name="lastName"/><br/>--}%
    %{--<label>Age:</label>--}%
    %{--<g:textField name="age"/><br/><label>Password:</label>--}%
    %{--<g:passwordField name="password"></g:passwordField>--}%
    %{--<g:actionSubmit value="Save" action="index"/>--}%
%{--</g:form>--}%


%{----}%
%{--<tl:showUserList/>--}%
%{----}%

%{--</body>--}%
%{--</html>--}%