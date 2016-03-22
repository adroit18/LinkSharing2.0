package com.tothenew.linksharing

//import Link_Visibility


//import Link_Visibility
import grails.test.mixin.TestFor
import spock.lang.Specification
import spock.lang.Unroll


@TestFor(Topic)
class TopicSpec extends Specification {

//    def setup() {
//    }
//
//    def cleanup() {
//    }



    @Unroll
    def "test something"() {
        given: ""
        String topicName = "Grails";


        User user = new User(emailId: "helloa@yt.com", firstName: "deepak", lastName: "uniyal", password: "Hellopoiyt", userName: "deepak uniyal");
        Topic topic = new Topic(name: topicName, createdBy: user, visibility: Link_Visibility.PRIVATE);
        when: "User will save"
        topic.save(failOnError: true);

        then: ""
        topic.count() == 1;

        when: ""
        Topic newTopic = new Topic(name: topicName, createdBy: user, visibility: Link_Visibility.PRIVATE);
        newTopic.save();
//println topic.count();
        then:
        topic.count() == 1;
        newTopic.errors.allErrors.size() == 1;
        newTopic.errors.getFieldErrorCount('name') == 1;


    }

    @Unroll
    def "Visibility should not be null & must be enum"() {
        setup: "user created topic"
        User user = new User(emailId: "helloa@yt.com", firstName: "deepak", lastName: "uniyal", password: "Hellopoiyt", userName: "deepak uniyal");
        Topic topic = new Topic(createdBy: user, name: "deepak", visibility:visibility)

        when: "check for valiation"
        Boolean result = topic.validate()
        println "${topic.validate()})"

        then: "test the result"
        result == valid

        where: "trying different values"

        sno | visibility              | valid
        1   | " "                     | false
        2   | null                    | false
        4   | Link_Visibility.PUBLIC  | true
        5   | Link_Visibility.PRIVATE | true
        6   | "xyz"                   | false

    }

    void "TestingToString"() {
        setup:
        Topic topic = new Topic(name: 'History')

        expect:
        topic.name == topic.toString()
    }
}