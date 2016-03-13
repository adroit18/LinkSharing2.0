package com.tothenew.linksharing

import grails.validation.Validateable

@Validateable
class EmailDTO {
    List<String> to
    String view
    String subject
    String content
    Map model

    static constraints = {
        model(nullable: true)
        to(nullable: false)
        view(nullable: false)
        subject(nullable: false)
        content(nullable:true)
    }
}