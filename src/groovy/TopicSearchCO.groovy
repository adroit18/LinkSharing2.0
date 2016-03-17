package com.tothenew.linksharing

import grails.validation.Validateable


@Validateable
class TopicSearchCO {
    long id
    String visibility

    def getUser() {
        Topic topic = Topic.get(id)

        return topic.createdBy;

    }


}
