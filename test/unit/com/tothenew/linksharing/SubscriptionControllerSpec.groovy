package com.tothenew.linksharing

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@Mock([Subscription,Topic,User])
@TestFor(SubscriptionController)
class SubscriptionControllerSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "delete response success when successful"() {
        setup:
        Subscription subscription = new Subscription()

        and:
        Subscription.metaClass.static.get = { long id ->
            return null
        }

        when:
        controller.delete(ind)
        println ind.getClass();



        then:
        response.contentAsString == ms

        where:
        ind | ms
        2L   | "Subscription Not Found"


    }

    void "resource not found"() {
        setup:
        Subscription.metaClass.'static'.get = { def id -> }

        when:
        controller.delete()

        then:
        response.contentAsString == 'Subscription Not Found'
    }

    void "save Topic Test case"(){
        setup:
        Topic topic=new Topic()
        topic.save(validate: false)
        Topic.metaClass.'static'.get={long id->
            return null
        }
        User user = new User()
        user.save(validate: false)
        session.user=user

        when:
        controller.saveTopic(1)

        then:
        response.contentAsString == 'Subscription saved Successfully'

    }
}