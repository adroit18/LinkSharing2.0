package com.tothenew.linksharing


import com.tothenew.linksharing.*


import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(DocumentResource)
class DocumentResourceSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
        setup: "user created Resource"
        // User user = new User(firstName: "sona", lastName: "Kumra", email: "a@b.com", password: "qwerty", username: "abc")
        User user = new User(firstName: "deepak", lastName: "uniyal",username: 'deepak uniyal', emailId: "a@b.com", password: "qwertsdy")
        Topic topic = new Topic(name:"grails", visibility:Link_Visibility.PRIVATE, createdBy: user)
        DocumentResource documentResource = new DocumentResource(filePath:filepath ,description:"this is helpfull",topic:topic ,createdBy:user )

        when: "check for validation"
        Boolean result = documentResource.validate();
        println "${documentResource.errors.allErrors}"

        then: "test the result"
        result == valid

        where: "trying different values"

        sno | filepath                | valid
        1   | " "                  | false
        2   | null                 | false
        3   | "Desktop" | true

    }
    void "TestingToString"() {
        setup:
        DocumentResource documentResource = new DocumentResource(filePath: 'Home')
        expect:
        documentResource.toString() == "Home"
    }
}
