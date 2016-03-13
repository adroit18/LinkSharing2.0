package com.tothenew.linksharing

import grails.transaction.Transactional

@Transactional
class SubscriptionService {

    def serviceMethod() {

    }

    def searchSubscription(TopicSearchCO co){
        if (co) {
          return  Subscription.findByUser(co.getUser())
        }


    }







    }



