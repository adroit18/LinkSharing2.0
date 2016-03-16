package com.tothenew.linksharing

import grails.converters.JSON

class LoginController {


    def index() {
        if (session.user) {
            params.max
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

    def login(String username, String password) {
        User user = User.findByUsernameAndPassword(username, password);

        // ResourceRating resourceRating = new ResourceRating()
        // render resourceRating.getTopPosts();
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


    def logout() {
        session.invalidate()
        ([message: "User Logged Out"] as JSON)
        forward(controller: 'login', action: 'index')


    }


}
