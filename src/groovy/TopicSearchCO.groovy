package com.tothenew.linksharing
/**
 * Created by deepak on 12/3/16.
 */
class TopicSearchCO {
    long id
    String visibility

    def getUser() {
        Topic topic = Topic.get(id)

        return topic.createdBy;

    }


}
