package com.tothenew.linksharing

import grails.test.mixin.TestFor
import org.codehaus.groovy.grails.plugins.testing.GrailsMockHttpServletRequest
import org.codehaus.groovy.grails.plugins.testing.GrailsMockMultipartFile
import spock.lang.IgnoreRest
import spock.lang.Specification

import javax.mail.Multipart
import javax.servlet.http.HttpServletRequest

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(UserController)
class UserControllerSpec extends Specification {

    @IgnoreRest
    void "register"() {
        given:
        UserCO co = new UserCO(firstName: fname,
                lastName: lname, emailId: email,
                password: password, confirmPassword: password,
                username: name)

        and:
        request.addFile(new GrailsMockMultipartFile('file', "1212".bytes))

        and:
        User.metaClass.save = {
            return true
        }

        when:
        controller.registrationHandler(co)

        then:
        response.redirectUrl == '/login/registerSuccess'

        where:
        sno | fname     | lname    | name            | email                    | password   | confirmPassword | valid
        1   | ""        | "hello"  | "hello"         | "a@b.com"                | "test123"  | "test123"       | false
        1   | "Deepak"  | "hello"  | "Deepak hello"  | "test123"                | "asmdfl"   | "asmdfl"        | false
        1   | "test123" | "hello"  | "deepak"        | "test123"                | "asfasdfa" | "asfasdfa"      | false
        1   | "Deepak"  | "Uniyal" | "Deepak Uniyal" | "deepakuniyal@gmail.com" | "asdfas"   | "asdfas"        | true


    }

    void "register should set flash error on save fail"() {
        setup:
        User.metaClass.save = {
            return false
        }

        when:
        controller.register()

        then:
        response.contentAsString == "User is not set yet !!!!!"


    }


}