package com.tothenew.linksharing

import grails.converters.JSON

class LinkResourceController {

    def index() {

    }

    def linkSave() {
        LinkResource linkResource = new LinkResource(url: params.link, description: params.description, topic: Topic.findByName(params.topicName), createdBy: session.user)
        if (linkResource.save(flush: true, failOnError: true)) {
//            Resource resource=Resource.get(linkResource.id)
//            ReadingItem readingItem=new ReadingItem(user: linkResource.createdBy,resource: resource,isRead: true)
//            readingItem.save(flush: true,failOnError: true)
            forward (controller:"login", action:"index")
            ([message: "Resource saved Successfully"] as JSON)
        }
        else  ([message: "WRONG Details"] as JSON)

    }


}
