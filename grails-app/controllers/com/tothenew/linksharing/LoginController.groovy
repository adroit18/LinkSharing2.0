package com.tothenew.linksharing

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

//import grails.plugin.springsecurity.annotation.Secured

class LoginController {


    def springSecurityService
    static List<Topic> subscribedTopics

    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def index() {
        def user = springSecurityService.currentUser
        session.user = user

        if (session.user) {
            Date date = new Date();
            User user1 = session.user;
            user1.executeUpdate("update User as U set U.lastLoginTime=:D where U.id=:id", [D: date, id: user1.id])

            subscribedTopics = User.getSubscribedTopics(session.user)
            User userObj = session["user"]

            List<Topic> topicList = Topic.findAllByCreatedBy(userObj)
            int subsCount = Subscription.countByUser(userObj)

            ([message: "Login Successfull"] as JSON)

            render view: '/user/userIndex', model: [subscribedTopics: subscribedTopics
                                                    , user          : userObj, topicList: topicList, subsCount: subsCount]

        } else {
            render view: '/user/loginAndRegister'
        }
    }

    def inboxData() {
        if (session.user) {
            List inboxList = ReadingItem.userInbox(session.user)
            render view: '/user/_inbox', model: [inboxList: inboxList, subscribedTopics: subscribedTopics]
        } else {
            render view: '/user/loginAndRegister', model: [loginMessage: "You Must Login First"]
        }
        Random rnd = new Random()
        rnd.nextInt()
    }


    def trendingTopics() {
        if (session.user) {
            List<TopicVO> trendingTopics = Topic.getTrendingTopics();
            render view: "/topic/_trendingTopics", model: [trendingTopics: trendingTopics, subscribedTopics: subscribedTopics]
        } else {
            render view: '/user/loginAndRegister', model: [loginMessage: "You Must Login First"]
        }
    }


    def subscriptions() {
        if (session.user) {
            List subscriptionList = Subscription.getSubscriptions(session.user)
            render view: '/subscription/_subscriptions', model: [subscriptionList: subscriptionList,
                                                                 subscribedTopics: subscribedTopics]
        } else {
            render view: '/user/loginAndRegister', model: [loginMessage: "You Must Login First"]
        }
    }

    def recentShares() {
        List recentShares = LinkResource.recentShares()
        render view: '/resource/_recentShares', model: [recentShares    : recentShares,
                                                        subscribedTopics: subscribedTopics]

    }

    def topPosts() {
        List resourceList = ResourceRating.getTopPosts()//.collect { it[2] };
        //List<Resource> resourceList = Resource.getAll(resourceIds)
        render view: '/topic/_topPosts', model: [resourceList    : resourceList,
                                                 subscribedTopics: subscribedTopics]

    }


    def logout() {

        session.invalidate()

        ([message: "User Logged Out"] as JSON)
        forward(controller: 'login', action: 'index')
    }


    def loginHandler() {

        def user = springSecurityService.currentUser
        if (user) {
            if (user.isActive == true) {
                session.user = user;
                forward(controller: 'login', action: 'index');

            } else {
                render(view: 'index', model: [message: "Your Account is Not Active"])
                // session.user = user;
                // render flash.error
//                forward(controller: 'login', action: 'index');
            }
        } else {
            render(view: 'index', model: [message: "User Not Found"])
//             flash.error

        }
    }


}
