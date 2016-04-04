package com.tothenew.linksharing

import grails.converters.JSON
import grails.transaction.Transactional

import static com.tothenew.linksharing.SecUserSecRole.create

@Transactional
class UserService {

    def emailService
    def grailsApplication

    def registerUser(UserCO co) {
        def f = co.file
        co.profilePic = f.bytes
        co.photoType = f.contentType
        User user = new User(co.properties)
        if (user.save()) {
            def userRole = SecRole.findByAuthority('ROLE_USER')
            create(user, userRole, true)
            return true
        } else
            return false
    }

    def updateUserProfile(UserCO userCo, User userObj) {
        def userImage = userCo.file
        userCo.profilePic = userImage.bytes
        userCo.photoType = userImage.contentType

        userObj.firstName = userCo.firstName
        userObj.lastName = userCo.lastName
        userObj.username = userCo.username
        userObj.profilePic = userCo.profilePic
        userObj.confirmPassword = userObj.password

        if (userObj.validate()) {
            userObj.merge(flush: true, failOnError: true)
            return true
        }
        return false
    }


    def updatePassword(UserCO userCo, User userObj) {
        if ((userCo.password == (userCo.confirmPassword)) && userCo.password.length() > 7) {
            userObj.executeUpdate("update User as U set U.password=:password where U.id=:id", [password: userCo.password, id: userObj.id])
            return true
        }
        return false

    }

    def forgotPassword(String recoveryemail) {
        User user = User.findByEmailId(recoveryemail)
        if (user && user.isActive) {
            String newPassword = RandomPasswordGenerator.generateRandomPassword()
            EmailDTO emailDTO = new EmailDTO(to: [recoveryemail], subject: "Account Recovery", view: "/email/_password", model: [userName: user.name, newPassword: newPassword, serverUrl: grailsApplication.config.grails.serverURL])
            emailService.sendMail(emailDTO)
            user.password=newPassword
            if (user.save(flush: true,failOnError: true)) {
                ([message: "Success"]) as JSON
                return true
            } else {
                ([error: "Email not for a valid user"]) as JSON
                return false
            }
        }

    }

def userTable(String q,String active, def params) {
    params.max = params.max ? params.max : 2
    params.offset = params.offset ? params.offset : 0
    params.sort = "id";
    params.order = "asc"
    List list = [];
    Integer a = 0;

    if (q && !q.equals("")) {
        list = User.createCriteria().list(params) {
            or {
                ilike("username", "%${q}%")
                ilike("firstName", "%${q}%")
            }
        }
        a += list.totalCount;
    } else if (active.equals("Show All Users")) {
        list = User.list(params)
        a += User.count();

    } else if (active.equals("Show All Active Users")) {
        boolean flag = true;
        list = User.findAllByIsActive(flag, params)
        a += User.countByIsActive(flag)

    } else {
        boolean flag = false;
        list = User.findAllByIsActive(flag, params)
        a += User.countByIsActive(flag)
    }

    return [list,a]
}




}




