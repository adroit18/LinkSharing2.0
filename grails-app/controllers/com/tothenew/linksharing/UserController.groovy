package com.tothenew.linksharing

import grails.converters.JSON
import grails.transaction.Transactional

class UserController {

    def assetResourceLocator
    ResourceService resourceService
    SubscriptionService subscriptionService
    TopicService topicService
    UserService userService


    def index() {
    }

    def registrationHandler(UserCO co) {
        def f = request.getFile('file')
//        log.info("File uploaded: $user.avatarType")
//        User user = new User(email: co.emailId, username: co.username, password: co.password, confirmPassword: co.confirmPassword, firstName: co.firstName, lastName: co.lastName, active: true, admin: false)
        co.profilePic = f.bytes
        co.photoType = f.contentType
        User user = new User(co.properties)
        if (user.save()) {
            render 'success'
        } else {
            flash.message = user.errors
            flash.error = 'User not registered'
            render user.errors
        }


    }






//
//        String filePath = grailsApplication.config.userProfileImageFolder + userCO.username
//        File dir = new File(filePath)
//        if (!dir.exists()) {
//            dir.mkdirs()
//        }//userCO.photo
//
//        def userImage = request.getFile('file')
//        if (!userImage.empty) {
//            userCO.photo = userImage.originalFilename
//            userImage.transferTo(new File("${grailsApplication.config.userProfileImageFolder}${userCO.username}"))
//        }
//
//        User user = new User(userCO.properties)
//        user.profilePic = userCO.username
//

//        if (user.save(flush: true, failOnError: true)) {
//            render(view: "/login/registerSuccess")
//        } else
//            ([message: "Failiure"] as JSON)
//
//    }


    def isUsernameValid(String username) {
        int numUser = 0
        numUser = User.countByUsername(username)
        if (numUser >= 1)
            render false
        else
            render true
    }

    def isEmailIdValid(String emailId) {
        int num = 0;
        num = User.countByEmailId(emailId)
        if (num >= 1)
            render false
        else
            render true

    }

  def image(Long id) {
            User user = User.get(id)
            byte[] image
            if (user.profilePic) {
                image = user.profilePic
            } else {
                image = assetResourceLocator.findAssetForURI('img.png').byteArray
            }
            response.contentType = user.photoType
            response.contentLength = image.size()
            OutputStream out = response.outputStream
            out.write(image)
            out.close()
        }



//        User user = User.findByUsername(params.username);
//        println "-...........${user}"
//
//        if (user?.profilePic) {
//            render ls.userImage([username: params.username])
//        } else {
//            render asset.image(src: 'img.png', width: '64px', height: '64px')
//
//        }
//    }


    def showForgotPassword() {
        render(view: 'forgotPassword')
    }


    def editProfile() {
        User userObj = session["user"]
        List<Topic> topicList = Topic.findAllByCreatedBy(userObj)
        int subsCount = Subscription.countByUser(userObj)
        render(view: 'editProfile', model: [user: userObj, topicList: topicList, subsCount: subsCount])
    }


    def updateProfile(UserCO userCO) {

        def userImage = request.getFile('file')
        User userObj = session["user"]
        boolean success = userService.updateUserProfile(userCO, userObj, userImage)
        if (success) {
            flash.message = g.message(code: "profile.update.success")
            redirect(controller: "user", action: "editProfile")
        } else {
            flash.error = g.message(code: "error.in.updation")
            redirect(controller: "user", action: "editProfile")
        }

    }

    def updatePassword(UserCO userCO) {
        User userObj = session["user"]
        boolean success = userService.updatePassword(userCO, userObj)
        if (success) {
            render([message: "Successfully Update"]) as JSON
            redirect(controller: "user", action: "editProfile")
        } else {
            render([message: "Could not update Password"]) as JSON
            redirect(controller: "user", action: "editProfile")
        }

    }


    def userTable(String active) {
        println '------------------' + active
        if (active.equals("Show All Users")) {
            List list = User.list(sort: 'id', order: 'asc')
            render(view: 'allUsers', model: [userList: list])
        } else if (active.equals("Show All Active Users")) {
            boolean flag = true;
            List list = User.findAllByIsActive(flag)
            render(view: 'allUsers', model: [userList: list])
        } else {
            boolean flag = false;
            List list = User.findAllByIsActive(flag)
            render(view: 'allUsers', model: [userList: list])
        }

    }

    @Transactional
    def activate() {
        User user = User.findById(params.userId)
        user.isActive = true
        user.confirmPassword = user.password
        user.save(failOnError: true, flush: true)
        redirect(action: 'userTable')
    }

    @Transactional
    def deactivate() {
        User user = User.findById(params.userId)
        user.isActive = false
        user.confirmPassword = user.password
        user.save(failOnError: true, flush: true)
        redirect(action: 'userTable')
    }


    def profile(ResourcesSearchCo resourcesSearchCo) {


    }

    def topics(TopicSearchCO co) {
        def list = topicService.searchTopic(co)
        render(template: "/topic/list", model: [searchTopics: list])
    }

    def subscriptions(TopicSearchCO co) {
        def list = subscriptionService.searchSubscription(co)
        render(template: "/topic/list", model: [searchSubscriptions: list])
    }

    def resource(ResourcesSearchCo co) {
        def list = resourceService.searchResource(co)
        render(template: "/topic/list", model: [searchResources: list])
    }


}