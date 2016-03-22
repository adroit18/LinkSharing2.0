package com.tothenew.linksharing

import grails.transaction.Transactional

@Transactional
class TopicService {

//    def serviceMethod() {
//    }

    def searchTopic(TopicSearchCO co){

        List list=Topic.findByCreatedBy(co.getUser())
        return list


    }

}
