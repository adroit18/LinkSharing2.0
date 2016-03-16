<table class="table">
    <thead>
    <tr>
        <th>#</th>
        <th>Username</th>
        <th>Email</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Active</th>
        <th>Manage</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${users}" var="user">
        <g:if test="${user.isActive}">
            <g:set var="active" value="success"/>
        </g:if>
        <g:else>
            <g:set var="active" value="danger"/>
        </g:else>
        <g:if test="${user.id!=session.user.id || !user.isAdmin}">
            <tr class="${active}">
                <td>${user.id}</td>
                <td>${user.username}</td>
                <td>${user.emailId}</td>
                <td>${user.firstName}</td>
                <td>${user.lastName}</td>
                <td>
                    <g:if test="${user.isActive}">
                        Yes
                    </g:if>
                    <g:else>
                        No
                    </g:else>
                </td>
                <td><g:if test="${user.isActive}">
                    <a href="#" class="activateButtons" id="deactivate"
                       onclick="updateActivation(${user.id}, this.id)">Deactivate</a>
                </g:if>
                    <g:else>
                        <a href="#" class="activateButtons" id="activate"
                           onclick="updateActivation(${user.id}, this.id)">Activate</a>
                    </g:else></td>
            </tr>
        </g:if>
    </g:each>
    </tbody>
    <g:paginate total="${userCount}" next="Forward" prev="Previous" maxsteps="10" controller="user" action="usershow"/>
</table>
<script>
    function updateActivation(id, buttonid) {
        var active = ($("#" + buttonid).text()) == "Activate";
        $.ajax({
            url: "/user/activateUser",
            data: {"activate": active, "userId": id},
            method: "POST",
            success: function (data) {
                var response = data.message
                if (response == "User activated" || response == "User Deactivated") {
                    loadUserTable(function () {
                        $("#responseMessagePassword").attr("class", "alert alert-success").show();
                        $("#responseMessagePassword > .visibilityText").text(response);
                    })
                }
                else {
                    $("#responseMessagePassword").attr("class", "alert alert-danger").show();
                    $("#responseMessagePassword > .visibilityText").text(response);
                }
            },
            error: function (data) {
                $("#responseMessagePassword").attr("class", "alert alert-danger").show();
                $("#responseMessagePassword > .visibilityText").text(data.statusText);
            }
        });
    }
    function loadUserTable(callback) {
        $("#userTableSection").load("/user/loadUserTable", function () {
            if (callback) {
                callback();
            }
        });
    }
</script>