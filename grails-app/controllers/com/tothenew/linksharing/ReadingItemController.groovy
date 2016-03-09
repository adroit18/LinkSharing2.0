package com.tothenew.linksharing

class ReadingItemController {

    def index() {}

    def changeIsRead(long id, boolean isRead) {
        println "attribute ++++ :::::::: ${flash.query}"
        ReadingItem readingItem = ReadingItem.get(id)
        println "++++++++++++++++++++++++++++++" + request.getHeader('referer');
        String redirectUrl = "request.getHeader('referer')"
        if  (flash.query!= null) {
            redirectUrl = redirectUrl + "?q=" + flash.query
        } else {
            redirectUrl = request.getHeader('referer')
        }
        if (readingItem.executeUpdate("update ReadingItem as RI set RI.isRead=:isRead where RI.id=:id", [isRead: isRead, id: id])) {
            redirect(url: redirectUrl)
        } else
            flash.error = "Error"


    }
}
