package com.tothenew.linksharing

import grails.converters.JSON
import grails.transaction.Transactional

class UserController {

    def assetResourceLocator
    ResourceService resourceService
    SubscriptionService subscriptionService
    TopicService topicService
    UserService userService
    EmailService emailService

//
//    def index() {
//
//    }

    def registrationHandler(UserCO co) {
        def f = request.getFile('file')
//        log.info("File uploaded: $user.avatarType")
//        User user = new User(email: co.emailId, username: co.username, password: co.password, confirmPassword: co.confirmPassword, firstName: co.firstName, lastName: co.lastName, active: true, admin: false)
        co.profilePic = f.bytes
        co.photoType = f.contentType
        User user = new User(co.properties)
        if (user.save(flush: true, failOnError: true)) {
            render(view: "/login/registerSuccess")
        } else
            render([message: "Failiure"] as JSON)


    }

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

    def isExisting(String recoveryemail) {
        int num = 0;
        num = User.countByEmailId(recoveryemail)
        if (num == 1)
            render true
        else
            render false

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
        userCO.profilePic = userImage.bytes
        userCO.photoType = userImage.contentType
        //      User user = new User(userCO.properties)

        boolean success = userService.updateUserProfile(userCO, userObj)
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


    def userTable(String q, String active) {

        params.max = params.max ? params.max : 2
        params.offset = params.offset ? params.offset : 0
        params.sort="id";
        params.order="asc"
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
            list = User.findAllByIsActive(flag,params)
            a += User.countByIsActive(flag)

        } else {
            boolean flag = false;
            list = User.findAllByIsActive(flag,params)
            a += User.countByIsActive(flag)
        }
        params.flag == null?render(view: 'allUsers', model: [userList: list, size: a, queryString1: q, queryString2: active]):render(template: 'userlist', model: [userList: list])

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


    def forgotPassword(String recoveryemail) {
        User user = User.findByEmailId(recoveryemail)
        if (user && user.isActive) {
            String newPassword = RandomPasswordGenerator.generateRandomPassword()
            println "heloo ${recoveryemail} and ${newPassword}"
            EmailDTO emailDTO = new EmailDTO(to: [recoveryemail], subject: "Account Recovery", view: "/email/_password", model: [userName: user.name, newPassword: newPassword, serverUrl: grailsApplication.config.grails.serverURL])
            emailService.sendMail(emailDTO)
//            user.password = newPassword
//            user.confirmPassword = newPassword
            if (user.executeUpdate("update User as U set U.password=:password where U.id=:id", [password: newPassword, id: user.id]))
                ([message: "Success"]) as JSON
            else
                ([error: "Email not for a valid user"]) as JSON

            redirect(controller: "login", action: "index")
        }
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


}