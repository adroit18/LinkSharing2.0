package com.tothenew.linksharing

import com.tothenew.linksharing.EmailDTO
import grails.transaction.Transactional

@Transactional
class EmailService {
    def mailService
    def sendMail(EmailDTO emailDTO)
    {
        sendMail{
            async true
            to emailDTO.to.toArray()
            subject emailDTO.subject
            if(emailDTO.content)
                body emailDTO.content
            else
                body(view:emailDTO.view,model:emailDTO.model)
        }
    }
}