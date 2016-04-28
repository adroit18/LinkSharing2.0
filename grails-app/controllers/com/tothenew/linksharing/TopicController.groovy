package com.tothenew.linksharing

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

//import Link_Visibility

class TopicController {

    EmailService emailService;
    def sortService


    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def index() {
        Topic topic = Topic.get(params.id)
        def list = topic?.resources
        render(view: 'topicIndex', model: [users: topic.getSubscribedUsers(), topicName: topic.name, resourceList: list])
    }

    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def show(ResourcesSearchCo co) {
        Topic topic = Topic.read(co.topic_id);
        if (!topic) {
            render([error: "Topic Not Found"] as JSON)
        } else if (topic && topic.visibility == Link_Visibility.PUBLIC) {
            render([message: "Success"] as JSON)
        } else if (topic && topic.visibility == Link_Visibility.PRIVATE) {
            if (topic.subscriptions.user.findAll { it.username == session.user }) {
                render([message: "Success"] as JSON)
            } else {
                ([error: "User Subscription not found"] as JSON)
                redirect(controller: "login", action: "index")
            }
        }
    }

    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def save(String name, String visibility) {

        Topic topic
        if (name && visibility) {
            User createdBy = session.user;
            topic = new Topic(name: name, createdBy: createdBy, visibility: Link_Visibility.toenum(visibility), concernedArea: createdBy.profession)
            if (topic.save(failOnError: true)) {
                render([message: "Topic saved Successfully"] as JSON)

            } else
                render([message: "Topic could not be saved"] as JSON)

        } else
            render([message: "none"] as JSON)
    }


    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def topicDelete(long id) {
        Topic topic = Topic.get(id);
        if (topic?.delete(flush: true))
            ([message: "Topic Deleted Successfully"])
        else
            ([message: "Error Occured"])
    }


    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def editTopic() {
        Topic topic = Topic.get(params.topicId)
        topic.name = params.topicName
        if (topic.save(failOnError: true, flush: true))
            render([message: "Topic Successfully edited"] as JSON)
        else
            render([message: "Topic Could not be edited"] as JSON)
    }


    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def deleteTopic() {
        Topic topicObj = Topic.get(params.topicId)
        if (topicObj.createdBy == session.user)
            render([message: "Creator of Topic Cannot delete Topic"] as JSON)
        else {
            topicObj.delete(flush: true)
            render([message: "Topic Deleted Successfully"] as JSON)
        }

    }


    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def changeVisibility() {
        Topic topic = Topic.get(params.topicId)
        topic.visibility = params.visibility
        if (topic.save(failOnError: true, flush: true))
            render([message: "Visibility successfully Changed"] as JSON)
        else
            render([message: "Visibility Could not be Changed"] as JSON)

    }

    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def invite(String topicName, String emailId) {
        Topic topic = Topic.findByName(topicName);

        if (topic) {
            println "................." + topic
            EmailDTO emailDTO = new EmailDTO(to: [emailId], subject: "${session.user} invited you to like a topic.", view: "/email/_invite", model: [topic: topic, user: session.user, serverUrl: grailsApplication.config.grails.serverURL])
            emailService.sendMail(emailDTO)
//            redirect(controller: "login", action: "index")
            render([message: "success"]) as JSON

        } else
            render([message: "Topic Not Found"] as JSON)

    }

    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def join(long id) {
        User invitedUser = session.user
        Topic invitedTopic = Topic.read(id)
        if (Subscription.countByTopicAndUser(invitedTopic, invitedUser)) {
            Subscription newSubscription = new Subscription(topic: invitedTopic, user: invitedUser)
            if (newSubscription.validate()) {
                newSubscription.save()
                render([message: "Subscribed"]) as JSON
            } else {
                render([error: "Couldn't save Subscription"]) as JSON
            }
        } else {
            render([message: "Already Subscribed"]) as JSON
        }
        redirect(controller: "user", action: "index")
    }

    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def viewAllTrend() {
        List<TopicVO> trendingTopics = Topic.getTrendingTopics();
        render view: '_allTrendingTopics', model: [trendingTopics: trendingTopics]
    }

    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def recommendationList() {
        List<Double> testArray = []
        List idArray = []
        List listTopic = Topic.getAll()
        for (int i = 0; i < Topic.count(); i++) {
            idArray[i] = listTopic[i].id
            Double result = session.user.profession - listTopic[i].concernedArea
            println result
            testArray[i] = Math.sqrt(Math.abs(result))
        }
        println "*************" + sortService.qSort(testArray, 0, testArray.size() - 1, idArray)
        println "</////////////>"+testArray
        println "44" + sortService.bubSort(testArray, idArray)
        render view: '/recommendation/recommendation1', model: ["dataArray": sortService.bubSort(testArray,idArray)]

    }


}
