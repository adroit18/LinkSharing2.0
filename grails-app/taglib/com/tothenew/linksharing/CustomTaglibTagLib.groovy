package com.tothenew.linksharing

class CustomTaglibTagLib {


    static namespace = "ls"

    def markAsRead = { attrs, body ->
        User user = session.user
        ReadingItem readingItem = ReadingItem.findById((attrs.id))
        flash.query = attrs.query
        if (user && readingItem) {
//            def id = readingItem.id
            def isRead = readingItem.isRead
            if (isRead) {
//                out << g.link(controller: "readingItem", action: "changeIsRead", params: [id: id, isRead: false], "style": "font-size:10px") {
                out << "<span class='unread' data-id='${attrs.id}' style='color:blue' > Mark as Unread </span>"
            } else {
//                out << g.link(controller: "readingItem", action: "changeIsRead", params: [id: id, isRead: true], "style": "font-size:10px") {
                out << "<span class='read' data-id='${attrs.id}' style='color:blue' > Mark as Read </span>"


            }
        }

    }

    def trendingTopics = { body ->
        List<TopicVO> trendingTopics = Topic.getTrendingTopics();
        out << g.render(template: "/topic/trendingTopics", model: [trendingTopics: trendingTopics])
    }
    def topPosts = { body ->
        List resourceList = ResourceRating.getTopPosts();
        out << render(template: "/topic/topPosts", model: [resourceList: resourceList])

    }

    def userImage = { attrs ->
        out << "<img src='/images/${attrs.username}' width=64 height=64 id='test'/>"
    }

    def canDeleteResouce = { attrs, body ->
        User loggedInUser = session.user
        Resource resource = attrs.resource
        if (loggedInUser != null)
            (loggedInUser?.canDeleteResource(resource)) ? out << link(controller: "resource", action: "delete", id: resource.id, "Delete") : out << ""
        else
            out << ""
    }

    def   showSubscribe = { attrs, body ->
        User loggedInUser = session.user
//        println "-----hello------------" + loggedInUser?.isSubscribed(attrs.topicId)
        if (session.user && loggedInUser.isSubscribed(attrs.topicId)) {
//            out << g.link(controller: "subscription", action: "delete", id: "${attrs.topicId}") {
            out << "<span class='unsubscribe' id=${attrs.topicId} >Unsubscribe </span>"
//            }
        } else {
//            out << g.link(controller: "subscription", action: "saveTopic", id: "${attrs.topicId}") {
            out << "<span class='subscribe' id=${attrs.topicId} >Subscribe </span>"
//            }
        }
    }

    def subscriptionCount = { attr, body ->
        int subscription;
            if (attr.topicId) {
            subscription = Subscription.countByTopic(Topic.read(attr.topicId))
        } else if (attr.user) {
            subscription = Subscription.countByUser(session.user)
        } else if (attr.topicId && attr.user) {
            subscription = Subscription.countByUserAndTopic(session.user, Topic.read(attr.topicId))
        }
        out << subscription
    }
    def resourceCount = { attrs, body ->
        out << Resource.countByTopic(Topic.read(attrs.topicId))
    }
    def topicCount = { attrs, body ->
        out << Topic.countByCreatedBy(attrs.user)
    }

    def canUpdateTopic = { attrs, body ->
        Topic topic = Topic.get(attrs.topicId)
       if (session.user.isAdmin == true || topic.createdBy == session.user) {

            out << "<span class='col-xs-4'>"
            out << "<a href='#' class='seditTopicInline' id='sedit-${attrs.topicId}' style='cursor: pointer;'><div class='glyphicon glyphicon-edit'></div></a></span>"
            out << "<span class='col-xs-4'><a href='#' id='sdel-${attrs.topicId}' class='sdeleteTopic' style='cursor: pointer;'><div class='glyphicon glyphicon-trash'></div></a>"

            out << "</span><br>"
        }
        else {
            out << "<div class='col-xs-4' id='visibilityDropDown'>"
            out << "${topic.visibility}           "
            out<< "${Subscription.get(attrs.subId).seriousness}"
            out << "</div>"
        }
    }

    def showSeriousness = { attrs, body ->
        out << g.select(name: 'seriousness', from: ['SERIOUS', 'VERY SERIOUS', 'CASUAL'], value: "${}")
    }


}