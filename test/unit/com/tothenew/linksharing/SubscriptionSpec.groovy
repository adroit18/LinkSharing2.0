package com.tothenew.linksharing



//import Link_Visibility
//import Seriousness
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Subscription)

class SubscriptionSpec extends Specification {

//    def setup() {
//    }
//
//    def cleanup() {
//    }


    void "test something"() {

        setup: "user created topic"
        String topicName = "grails"
        User user = new User(firstName: "deepak", lastName: "uniyal", email: "a@b.com", password: "qwerty", username: "abc")
        Topic topic = new Topic(name: topicName, visibility: Link_Visibility.PRIVATE, createdBy: user)
        Subscription subscription = new Subscription(topic: topic, user: user, seriousness: Seriousness.CASUAL)



        when:
        subscription.save()
        subscription.errors.allErrors.each {
            println it
        }
        println subscription.errors


        then:
        subscription.count() == 1

        when:
        Subscription subscriptionNew = new Subscription(topic: topic, user: user, seriousness: Seriousness.CASUAL)
        subscriptionNew.save()

        then:
        subscription.count() == 1
        subscriptionNew.errors.allErrors.size() == 1
        subscriptionNew.errors.getFieldErrorCount('user') == 1
    }


    void "test for Seriousness"() {

        setup:
        Subscription subscription = new Subscription(seriousness: seriousness)
        when:
        Boolean result = subscription.validate()
        then:
        result == valid;
        where:

        seriousness              | valid
        Seriousness.SERIOUS      | true
        Seriousness.CASUAL       | true
        Seriousness.VERY_SERIOUS | true
        null                     | false
        ""                       | false

    }


}
