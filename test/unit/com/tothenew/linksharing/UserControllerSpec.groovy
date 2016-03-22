package com.tothenew.linksharing

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(UserController)
class UserControllerSpec extends Specification {
//
//    def setup() {
//    }
//
//    def cleanup() {
//    }


    void "register should render success when user is saved"(){
        setup:
        User.metaClass.save = {
            return true
        }
        //User user = new User(firstName: fname, lastName: lname, emailId: email, password: password,username: name)
        //user.save();

        when:
        controller.register()

        then:
        response.contentAsString=="User is Set Successfully !!!!!"
   //     response.contentAsString=="User is Set with emailid = ${user.emailId}, username= ${user.username},firstname=  ${user.firstName},lastname=  ${user.lastName},password= ${user.password} and confirm password= ${user.confirmPassword}"

        //where:
      //  sno | fname     | lname    | name            | email     | password
       // 1   | "Deepak"  | "hello"  | "Deepak hello"  | "test@123" | "test@1234"


    }

    void "register should set flash error on save fail"(){
        setup:
        User.metaClass.save = {
            return  false
        }

        when:
        controller.register()

        then:
        response.contentAsString=="User is not set yet !!!!!"


    }


}