package com.tothenew.linksharing

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import groovy.json.internal.Dates

class UserController {

    def assetResourceLocator
    ResourceService resourceService
    SubscriptionService subscriptionService
    TopicService topicService
    UserService userService
    EmailService emailService


    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def registrationHandler(UserCO co) {
        boolean reply = userService.registerUser(co)
        if (reply)
            render(view: "/login/registerSuccess")
        else
            render([message: "Failiure"] as JSON)

    }


    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def isUsernameValid(String username) {
        int numUser = 0
        numUser = User.countByUsername(username)
        if (session.user.username == username)
            render true
        else if (numUser >= 1 || username.startsWith("facebook_") || username.startsWith("google_"))
            render false
        else
            render true
    }

    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def isEmailIdValid(String emailId) {
        int num = 0;
        num = User.countByEmailId(emailId)
        if (num >= 1)
            render false
        else
            render true

    }

    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def isExisting(String recoveryemail) {
        int num = 0;
        num = User.countByEmailId(recoveryemail)
        if (num == 1)
            render true
        else
            render false

    }


    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
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


    def showForgotPassword() {
        render(view: 'forgotPassword')
    }

    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def editProfile() {
        User userObj = session["user"]
        List<Topic> topicList = Topic.findAllByCreatedBy(userObj)
        int subsCount = Subscription.countByUser(userObj)
        render(view: '_editProfile', model: [user: userObj, topicList: topicList, subsCount: subsCount])
    }


    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def updateProfile(UserCO userCO) {
        User userObj = session["user"]
        boolean success = userService.updateUserProfile(userCO, userObj)
        if (success) {
            redirect(controller: "user", action: "editProfile")
        } else {
            redirect(controller: "user", action: "editProfile")
        }

    }

    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
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


    @Secured(['ROLE_ADMIN'])
    def userTable(String q, String active, params) {
        List ret = userService.userTable(q, active, params)
        params.flag == null ? render(view: 'allUsers', model: [userList: ret[0], size: ret[1], queryString1: q, queryString2: active]) : render(template: 'userlist', model: [userList: ret[0]])

    }

    @Transactional
    @Secured(['ROLE_ADMIN'])
    def activate() {
        User user = User.findById(params.userId)
        user.isActive = true
        user.confirmPassword = user.password
        user.save(failOnError: true, flush: true)
        redirect(action: 'userTable')
    }

    @Transactional
    @Secured(['ROLE_ADMIN'])
    def deactivate() {
        User user = User.findById(params.userId)
        user.isActive = false
        user.confirmPassword = user.password
        user.save(failOnError: true, flush: true)
        redirect(action: 'userTable')
    }


    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def forgotPassword(String recoveryemail) {
        if (userService.forgotPassword(recoveryemail))
            redirect(controller: "login", action: "index")

    }

    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def completeProfile() {
        int ide = 10;

        User user1 = User.get(session.user.id);
        List list = ["Student", "Professor", "IT Professional", "Others"]

        for (int i = 0; i < list.size(); i++) {
            println "============================" + list[i]
            if (list[i].equals(params.completedProfession)) {
                ide = i;
                break;
            }
        }

        user1.profession = ide + 1
        user1.save(flush: true, failOnError: true)
        redirect(controller: "login", action: "index")
    }

//    def profile(ResourcesSearchCo resourcesSearchCo) {
//
//
//    }


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

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def lineChartResponse() {

        List<User> userList = User.getAll()
        Date today = new Date()
        Calendar cal = Calendar.getInstance()
        int month = cal.get(Calendar.MONTH)
        List<Dates> dates = [];

        for (int iterator = 0; iterator <= 11; iterator++) {
            if (iterator == 0) {
                dates[0] = today
            } else if (iterator == 1) {
                dates[1] = today - today.date
            } else {
                dates[iterator] = dates[iterator - 1] - dates[iterator - 1].date
            }
        }

        dates[12] = dates[11] - dates[11].date
//        println ".............................." + dates
//        List<Calendar> datesList = new ArrayList<Calendar>(12)
        List countNum = [];
        for (int iterator = 0; iterator <= 10; iterator++) {
            countNum[iterator] = User.countByLastLoginTimeBetween(dates[iterator + 1], dates[iterator])
        }
        countNum[11] = User.countByLastLoginTimeBetween(dates[12], dates[11])
        render([userList: userList.username, countNum: countNum, dates: dates] as JSON)
    }

    def searchFrnds() {
        String str = params.name
        println str

        List  users = []
        users = User.findAllByUsernameOrFirstNameOrLastNameIlike("%${str}%","%${str}%","%${str}%")
//        usersId.each {
//            users.add(User.get(it)) as List<User>
//        }
        println "..............." + users
        render view: '/user/_showFrnds', model: [users: users]
    }

}