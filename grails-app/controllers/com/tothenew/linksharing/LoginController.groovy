package com.tothenew.linksharing

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

//import grails.plugin.springsecurity.annotation.Secured

class LoginController {

    def springSecurityService

    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def index() {
        def user = springSecurityService.currentUser
        session.user = user
        if (session.user) {
            List subscriptionList = Subscription.getSubscriptions(session.user)
            List inboxList = ReadingItem.userInbox(session.user)
            List<Topic> subscribedTopics = User.getSubscribedTopics(session.user)

            ([message: "Login Successfull"] as JSON)
            render view: '/user/userIndex', model: [subscriptionList: subscriptionList, inboxList: inboxList, subscribedTopics: subscribedTopics]

        } else {
            List resourceList = ResourceRating.getTopPosts()//.collect { it[2] };
            //List<Resource> resourceList = Resource.getAll(resourceIds)
            List recentShares = LinkResource.recentShares()

            ([message: "Login Unsuccessfull"] as JSON)

            render view: 'index', model: [resourceList: resourceList, recentShares: recentShares]
        }
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
