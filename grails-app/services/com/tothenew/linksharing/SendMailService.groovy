package com.tothenew.linksharing

import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Autowired

@Transactional
class SendMailService {

//    String xyz;
    def mailService

    void sendMailMethod() {

        mailService.sendMail {

            to "deepakuniyal11@gmail.com"
            subject "Hello John"
            body 'this is some text'
        }

    }

}
