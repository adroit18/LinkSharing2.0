package com.tothenew.linksharing

import grails.converters.JSON

//import Link_Visibility

class TopicController {

    EmailService emailService;


    def index() {
        Topic topic = Topic.get(params.id)
        def list=topic?.resources
        render(view: 'topicIndex', model: [users: topic.getSubscribedUsers(), topicName: topic.name, resourceList:list])
    }

//ResourcesSearchCo co,

    def show(ResourcesSearchCo co) {
        Topic topic = Topic.read(co.topic_id);
        if (!topic) {
           render ([error: "Topic Not Found"] as JSON)
            // println("a gya gay gayg a")
            //  forward(controller: "user", action: "index");
        } else if (topic && topic.visibility == Link_Visibility.PUBLIC) {
            //println "asdf,nfd";
            render ([message: "Success"] as JSON)
        } else if (topic && topic.visibility == Link_Visibility.PRIVATE) {
            if (topic.subscriptions.user.findAll { it.username == session.user }) {
               render ([message: "Success"] as JSON)
            } else {
                ([error: "User Subscription not found"] as JSON)
                redirect(controller: "login", action: "index")
            }
        }
    }

    def save(String name, String visibility) {
        Topic topic
        if (name && visibility) {
            User createdBy = session.user;
            topic = new Topic(name: name, createdBy: createdBy, visibility: Link_Visibility.toenum(visibility))
            if (topic.save(failOnError: true)) {
               ([message: "Topic saved Successfully"] as JSON)

            } else
              ([message: "Topic could not be saved"] as JSON)

        } else
           ([message: "none"] as JSON)

        //render flash.message
        //render  view:"../index";
        redirect(controller: "login", action: "index", model: [topic: topic])
        //  <g:renderErrors bean="${topic}"/>
    }

    def topicDelete(long id) {
        Topic topic = Topic.get(id);
        if (topic?.delete(flush: true))
             ([message: "Topic Deleted Successfully"])
        else
             ([message: "Error Occured"])
    }

//    def editTopic(long id, String changed,String visibility,String seriousness)
//    {
//        println "dknfksjndfjnsdfnskjfnjks--------------------------------------"
//        println changed+'------------'+visibility+'========='+seriousness
//        Topic topic = Topic.get(id)
//        topic.executeUpdate("update Topic as T set T.name=:name where T.id=:id", [name: changed, id: id])
//        topic.executeUpdate("update Topic as T set T.visibility=:visibility where T.id=:id", [visibility:Link_Visibility.toenum(visibility), id: id])
//
//       def subscription= Subscription.findByTopic(topic)
//        subscription.executeUpdate("update Subscription as S set S.seriousness=:seriousness where S.id=:id", [seriousness:Seriousness.toenum(seriousness), id: ${subscription.id}])
//
//
//    }


    def editTopic() {
        Topic topic = Topic.get(params.topicId)
        topic.name = params.topicName
        if (topic.save(failOnError: true, flush: true))
            render([message: "Topic Successfully edited"] as JSON)
        else
            render([message: "Topic Could not be edited"] as JSON)
    }


    def deleteTopic() {
        Topic topicObj = Topic.get(params.topicId)
        if (topicObj.createdBy == session.user)
            render([message: "Creator of Topic Cannot delete Topic"] as JSON)
        else {
            topicObj.delete(flush: true)
            render([message: "Topic Deleted Successfully"] as JSON)
        }

    }


    def changeVisibility() {
        Topic topic = Topic.get(params.topicId)
        topic.visibility = params.visibility
        if (topic.save(failOnError: true, flush: true))
            render([message: "Visibility successfully Changed"] as JSON)
        else
            render([message: "Visibility Could not be Changed"] as JSON)

    }

    def invite(String topicName, String emailId) {
        Topic topic = Topic.findByName(topicName);
        println "................." +topic
        if (topic) {
            EmailDTO emailDTO = new EmailDTO(to: [emailId], subject: "${session.user} invited you to like a topic.", view: "/email/_invite", model: [topic: topic, user: session.user, serverUrl: grailsApplication.config.grails.serverURL])
            emailService.sendMail(emailDTO)
            redirect(controller: "login", action: "index")
        } else
           render ([message: "Topic Not Found"] as JSON)

    }

    def join(long id) {
        User invitedUser = session.user
        Topic invitedTopic = Topic.read(id)
        if (Subscription.countByTopicAndUser(invitedTopic, invitedUser)) {
            Subscription newSubscription = new Subscription(topic: invitedTopic, user: invitedUser)
            if (newSubscription.validate()) {
                newSubscription.save()
              render  ([message :"Subscribed"]) as JSON
            } else {
               render ([error : "Couldn't save Subscription"]) as JSON
            }
        } else {
           render ([message :"Already Subscribed"]) as JSON
        }
        redirect(controller: "user", action: "index")
    }

    def viewAllTrend(){
        List<TopicVO> trendingTopics = Topic.getTrendingTopics();
        render view:'_allTrendingTopics',model: [trendingTopics:trendingTopics]
    }

}
