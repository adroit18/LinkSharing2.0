package com.tothenew.linksharing

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

class SubscriptionController {

//    def index() {}

    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def saveTopic(long id) {
//        println 'saveTopic ' +id
        Topic topic = Topic.get(id);
        User user = session.user;
        Subscription subscription = new Subscription(topic: topic, user: user, seriousness: Seriousness.SERIOUS);
        if (subscription.save(flush: true))
           render ([message: "<span class='unsubscribe' id=${id} >Unsubscribe </span>", status:true] as JSON)

        else
           render ([error: "Subscription could not be saved",status: false] as JSON)

//        render flash.message;
//        redirect(controller: 'login', action: 'index')


    }

    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def update(long id, String seriousness) {
        Subscription subscription = Subscription.get(id)
        if (subscription && Seriousness.toenum(seriousness)) {
            subscription.seriousness = Seriousness.toenum(seriousness)
            if (subscription.save(flush: true)) {
                render ([message: "Success"] as JSON)
            } else {
                render ([message: "Error"] as JSON)

            }
        } else {
            render ([message: "Subscription or Seriousness Not Found"] as JSON)
        }
    }

    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def delete(long id) {
//        println 'delete ' +id
        Subscription subscription = Subscription.findByUserAndTopic(session.user, Topic.read(id))
        if (subscription) {
            subscription.delete(flush: true)
           // redirect(request.getHeader('referer'));
           render ([message:"<span class='subscribe' id=${id} >Subscribe </span>",status: true] as JSON)
        } else
           render ([error: "Subscription Not Found",status: false] as JSON)

        //redirect(controller: 'login',action: 'index')
    }


    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def changeSeriousness() {
        Topic topic = Topic.load(params.topicId)
        User user = session.user
        Subscription subscription = Subscription.findByUserAndTopic(user, topic)
        subscription.seriousness = params.seriousness
        if(subscription.save(flush: true, failOnError: true))
            render([status: "true", message: "Seriousness successfully Changed"] as JSON)
        else
            render([status: "false", message: "Seriousness Could not be Changed"] as JSON)

    }


    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def viewAll(){
        List subscriptionList = Subscription.getSubscriptions(session.user)
        render view: '_allSubscriptions', model: [subscriptionList:subscriptionList]
    }




}
