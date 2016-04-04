package com.tothenew.linksharing
import grails.transaction.Transactional
@Transactional
class EmailService {
    def mailService
    def sendMail(EmailDTO emailDTO)
    {

        mailService.sendMail{

            async true
            from "linksharingapplication@gmail.com"
            to emailDTO.to.toArray()
            subject emailDTO.subject
            if(emailDTO.content)
                body emailDTO.content
            else
                body(view:emailDTO.view,model:emailDTO.model)
        }
    }
};