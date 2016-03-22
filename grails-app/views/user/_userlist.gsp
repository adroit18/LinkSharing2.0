<table border="1px" class="table table-striped table-bordered table-hover" style="padding: 10px;">
    <tr>
        <td class="table-header">Id</td>
        <td class="table-header">Username</td>
        <td class="table-header">Email</td>
        <td class="table-header">Firstname</td>
        <td class="table-header">Lastname</td>
        <td class="table-header">Active</td>
        <td class="table-header">Manage</td>
    </tr>

<g:each in="${userList}" var="user">
    <tr>
        <td>${user.id}</td>
        <td>${user.username}</td>
        <td>${user.emailId}</td>
        <td>${user.firstName}</td>
        <td>${user.lastName}</td>
        <g:if test="${user.isActive}">
            <td>Yes</td></g:if>
        <g:else>
            <td>No</td>
        </g:else>
        <g:if test="${user.isActive}">
            <td><g:link class="anchor-nounderline" controller="user" action="deactivate"
                        params="[userId: user.id]">Active</td></g:link>
        </g:if>
        <g:else>
            <td><g:link class="anchor-nounderline" controller="user" action="activate"
                        params="[userId: user.id]">Deactivated</td></g:link>
        </g:else>
    </tr>
</g:each>
</table>
