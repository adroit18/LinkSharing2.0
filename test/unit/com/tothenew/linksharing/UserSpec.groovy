package com.tothenew.linksharing

import grails.test.mixin.TestFor
import spock.lang.Specification
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(User)
class UserSpec extends Specification {

//    def setup() {
//    }
//
//    def cleanup() {
//    }

    // void "test"(){
    //   expect:
    //  true
    //}
    @Unroll("Executing #sno")
    void "test user validations"() {
        setup:
        User user = new User(firstName: fname, lastName: lname, emailId: email, password: password, username: name)
        when:
        Boolean result = user.validate()

        then:
        result == valid
        where:
        sno | fname     | lname    | name            | email                    | password   | valid
        1   | ""        | "hello"  | "hello"         | "a@b.com"                | "test123"  | false
        1   | "Deepak"  | "hello"  | "Deepak hello"  | "test123"                | "asmdfl"   | false
        1   | "test123" | "hello"  | "deepak"        | "test123"                | "asfasdfa" | false
        1   | "Deepak"  | "Uniyal" | "Deepak Uniyal" | "deepakuniyal@gmail.com" | "asdfas"   | true
    }


    def "Get user full name"() {
        expect:
        new User(firstName: firstName, lastName: lastName).name == name

        where:
        firstName | lastName | name
        "deepak"  | "uniyal" | "deepak uniyal"
        ""        | "uniyal" | "uniyal"
        null      | "uniyal" | "uniyal"
        "deepak"  | ""       | "deepak"
        "deepak"  | null     | "deepak"
        null      | null     | ""
    }

    @Unroll
    def "Check #emailId"() {
        given: "User Object"

        User user = new User(emailId: "helloa@yt.com", confirmPassword: "defgeLLr", password: "defgeLLr", firstName: "Deepak", lastName: "Uniyal", username: "adroit18");

        when: "User will save"
        user.save(failOnError: true);

        then: ""
        user.count() == 1;

        when: ""
        User user1 = new User(emailId: "helloa@yt.com", firstName: "Jai", confirmPassword: "Hellopoiyt", lastName: "Ho", password: "Hellopoiyt", username: "Ram");
        user1.save();

        then:
        user.count() == 1;
        user1.errors.allErrors.size() == 1;
        user1.errors.getFieldErrorCount('emailId') == 1;

    }

    void "getScore default score"(){
        setup:
        ResourceRating.metaClass.'static'.findByUserAndResource={user,resource1->
            return null
        }

        when:
        int n=User.getScore(new LinkResource(),new User())

        then:
        n==1
    }

}
