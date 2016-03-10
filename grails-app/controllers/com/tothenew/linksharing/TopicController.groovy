package com.tothenew.linksharing

import grails.converters.JSON

//import Link_Visibility

class TopicController {

    def index() {
        Topic topic=Topic.get(params.id)
        render(view:'topicIndex',model: [users:topic.getSubscribedUsers(),topicName:topic.name])
    }

//ResourcesSearchCo co,

    def show(ResourcesSearchCo co) {
        Topic topic = Topic.read(co.topic_id);
        if (!topic) {
             ([error:"Topic Not Found"] as JSON)
           // println("a gya gay gayg a")
            //  forward(controller: "user", action: "index");
        }
        else if (topic && topic.visibility == Link_Visibility.PUBLIC) {
            //println "asdf,nfd";
             ([message: "Success"] as JSON)
        }
        else if (topic && topic.visibility == Link_Visibility.PRIVATE) {
            if (topic.subscriptions.user.findAll { it.username == session.user }) {
                 ([message: "Success"] as JSON)
            } else {
                 ([error: "User Subscription not found"] as JSON)
                redirect(controller: "login", action: "index")
            }
        }
    }

    def save(String name, String visibility) {
        Topic topic
        if(name && visibility) {
         User createdBy = session.user;
         topic = new Topic(name: name, createdBy: createdBy, visibility: Link_Visibility.toenum(visibility))
         if (topic.save(failOnError: true)) {
              ([message: "Topic saved Successfully"] as JSON)

         }
         else
              ([message: "Topic could not be saved"] as JSON)

        }
        else
             ([message: "none"] as JSON)

        //render flash.message
        //render  view:"../index";
         redirect(controller:"login", action:"index", model: [topic: topic])
      //  <g:renderErrors bean="${topic}"/>
    }



}
