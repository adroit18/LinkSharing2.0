package com.tothenew.linksharing

import grails.converters.JSON

class SubscriptionController {

    def index() {}

    def saveTopic(long id) {
        Topic topic = Topic.get(id);
        User user = session.user;
        Subscription subscription = new Subscription(topic: topic, user: user, seriousness: Seriousness.SERIOUS);
        if (subscription.save(flush: true))
            ([message: "Subscription saved Successfully"] as JSON)

        else
            ([message: "Subscription could not be saved"] as JSON)

//        render flash.message;
        redirect(controller: 'login', action: 'index')


    }

    def update(long id, String seriousness) {
        Subscription subscription = Subscription.get(id)
        if (subscription && Seriousness.toenum(seriousness)) {
            subscription.seriousness = Seriousness.toenum(seriousness)
            if (subscription.save(flush: true)) {
                ([message: "Success"] as JSON)
            } else {
                ([message: "Error"] as JSON)

            }
        } else {
            ([message: "Subscription or Seriousness Not Found"] as JSON)
        }
    }

    def delete(long id) {
        Subscription subscription = Subscription.findByUserAndTopic(session.user, Topic.read(id))
        if (subscription) {
            subscription.delete(flush: true)
           // redirect(request.getHeader('referer'));
            ([message: "Subscription Deleted Successfully"] as JSON)
        } else
            ([message: "Subscription Not Found"] as JSON)

        redirect(controller: 'login',action: 'index')
    }


}
