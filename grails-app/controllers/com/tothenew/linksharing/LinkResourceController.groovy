package com.tothenew.linksharing

import grails.converters.JSON

class LinkResourceController {
//
//    def index() {
//
//    }

    def linkSave() {
        LinkResource linkResource = new LinkResource(url: params.link, description: params.description, topic: Topic.findByName(params.topicName), createdBy: session.user)
        if (linkResource.save(flush: true, failOnError: true)) {
            def subscriptions = linkResource.topic.subscriptions
            for (Subscription subscriptionObj : subscriptions) {
                ReadingItem readingItem = new ReadingItem()
                readingItem.user = subscriptionObj.user
                readingItem.resource = linkResource
                readingItem.save(flush: true, failOnError: true)

            //forward (controller:"login", action:"index")
            render ([message: "Resource saved Successfully"] as JSON)
        }}
        else
            render ([error: "Wrong Details"] as JSON)

    }


}
