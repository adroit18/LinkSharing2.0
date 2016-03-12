package com.tothenew.linksharing

import grails.converters.JSON

class UserController {

    def index() {
    }

    def registrationHandler(UserCO userCO) {
        String filePath = grailsApplication.config.userProfileImageFolder + userCO.username
        File dir = new File(filePath)
        if (!dir.exists()) {
            dir.mkdirs()
        }//userCO.photo

        def userImage = request.getFile('file')
        if (!userImage.empty) {
            userCO.photo = userImage.originalFilename
            userImage.transferTo(new File("${grailsApplication.config.userProfileImageFolder}${userCO.username}"))
        }

        User user = new User(userCO.properties)
        user.profilePic=userCO.username
        if (user.save(flush: true, failOnError: true)) {
            render(view: "/login/registerSuccess")
        } else
             ([message: "Failiure"] as JSON)

    }



    def isUsernameValid(String username) {
        int numUser=0
         numUser=User.countByUsername(username)
        if(numUser>=1)
            render false
        else
            render true
    }

    def isEmailIdValid(String emailId){
        int num=0;
        num=User.countByEmailId(emailId)
        if(num>=1)
            render false
        else
            render true

    }


def userImage() {

    User user = User.findByUsername(params.username);
    println "-...........${user}"

    if (user?.profilePic) {
        render ls.userImage([username: params.username])
    } else {
        render asset.image(src: 'img.png', width: '64px', height: '64px')

    }
}


def showForgotPassword() {
    render(view: 'forgotPassword')
}

}