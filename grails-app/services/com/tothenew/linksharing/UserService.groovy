package com.tothenew.linksharing

import grails.transaction.Transactional

@Transactional
class UserService {


    def grailsApplication

    def updateUserProfile(UserCO userCo, User userObj) {
        userObj.firstName = userCo.firstName
        userObj.lastName = userCo.lastName
        userObj.username = userCo.username
        userObj.profilePic=userCo.profilePic
        userObj.confirmPassword = userObj.password

//        if (!userImage.empty) {
//            userObj.profilePic = userImage.originalFilename
//            String filePath = grailsApplication.config.userProfileImageFolder
//            File dir = new File(filePath)
//            if (!dir.exists()) {
//                dir.mkdirs()
//            }
//            userImage.transferTo(new File(filePath + userObj.photo))
//        }
        if (userObj.validate()) {
            userObj.merge(flush: true, failOnError: true)
            return true
        }
        return false
    }

    def updatePassword(UserCO userCo, User userObj) {
//        try {
            if ((userCo.password == (userCo.confirmPassword)) && userCo.password.length() > 7 ) {
                userObj.executeUpdate("update User as U set U.password=:password where U.id=:id", [password: userCo.password, id: userObj.id])
                return true
            }
            return false
//        } catch (Exception e) {
//            return false
//        }
    }
}




