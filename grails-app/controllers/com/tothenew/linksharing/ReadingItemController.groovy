package com.tothenew.linksharing

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

class ReadingItemController {

//    def index() {}


    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def changeIsRead(long id, boolean isRead) {
        ReadingItem readingItem = ReadingItem.get(id)
        String newMessage = (isRead == true) ? "<span class='unread' data-id='${id}' style='color:blue' > Mark as Unread </span>" : "<span class='read' data-id='${id}' style='color:blue' > Mark as Read </span>";
//        String newMessage=ls.markAsRead(id: id)
//        println "jjjjjjjjjjjjjjjjjjjjjj"+newMessage
        def status = isRead == true ? "true" : "false"
        if (readingItem.executeUpdate("update ReadingItem as RI set RI.isRead=:isRead where RI.id=:id", [isRead: isRead, id: id])) {
            render(["message": newMessage, "status": status] as JSON)
        } else
            render(["message": "Some Error Occured Please Refresh the Page", "status": false] as JSON)


    }
}
