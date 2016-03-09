package com.tothenew.linksharing

class CustomTaglibTagLib {


    static namespace = "ls"

    def markAsRead = { attrs, body ->
        User user = session.user
        ReadingItem readingItem = ReadingItem.findById((attrs.id))
        flash.query = attrs.query
        if (user && readingItem) {
            def id = readingItem.id
            def isRead = readingItem.isRead
            if (isRead) {
                out << g.link(controller: "readingItem", action: "changeIsRead", params: [id: id, isRead: false], "style": "font-size:10px") {
                    "Mark as Unread "
                }

            } else {
                out << g.link(controller: "readingItem", action: "changeIsRead", params: [id: id, isRead: true], "style": "font-size:10px") {
                    "Mark as Read "
                }

            }
        }

    }

    def trendingTopics = { body ->
        List<TopicVO> trendingTopics = Topic.getTrendingTopics();
        out << g.render(template: "/topic/trendingTopics", model: [trendingTopicsList: trendingTopics])
    }
    def topPosts = { body ->
        List resourceList = ResourceRating.getTopPosts();
        out << render(template: "/topic/topPosts", model: [resourceList: resourceList])

    }

    def userImage = { attrs ->
        out << "<img src='/images/${attrs.username}' width=64 height=64 id='test'/>"
    }
    def canDeleteResouce = { attr, body ->
        User loggedInUser = session.user
        Resource resource = attr.resource
        (loggedInUser.canDeleteResource(resource)) ? out << link(controller: "resource", action: "delete", id: resource.id, "Delete") : out << ""

    }


}
//    def checkReading = { attr ->
//        User loggedInUser = session.getAttribute("user")
//        if (loggedInUser != null) {
//            ReadingItem readingItem = ReadingItem.changeIsRead(loggedInUser, attr?.resource, false)
//            if (readingItem) {
//                out << g.render(template: '/templates/readResource', model: [resourceId: attr?.resource?.id, ajaxClass: "markReadInbox"])
//            } else {
//                return
//            }
//        }
//        return
//    }

//}

//    class CustomTagLib {
//    def checkRes = { attr ->
//        def resType = attr?.resource?.class
//        if (resType == LinkResource) {
//            LinkResource linkResource = Resource.findById(attr?.resource?.id)
//            out << "<a  href=" + linkResource?.url + ' target = "_blank" ' + ">View Full Site</a>"
//        } else {
//            out << g.render(template: "/templates/downloadResource", model: [resourceId: attr?.resource?.id])
//        }
//    }
//
//}
