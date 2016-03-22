package com.tothenew.linksharing
import groovy.transform.EqualsAndHashCode

@EqualsAndHashCode
class Subscription {
    Topic topic;
    User user;
    Date dateCreated;
    Date lastUpdated;
    Seriousness seriousness;
    static belongsTo = [user: User, topic: Topic]

    static constraints = {
        seriousness(nullable: false, blank: false, defaultValue: Seriousness.SERIOUS)
        user(nullable: true, unique: 'topic')
    }

    static mapping = {
        topic lazy: false
        user lazy: false
    }

    static getSubscriptions(User user1) {
        List subscription = Subscription.createCriteria().list {
            projections {
                createAlias("topic", "t")
                createAlias("user", "u")

                groupProperty("t.id")
                property("t.name");
                property("t.createdBy")
                property("id")
                count()

            }
            eq("user.id", user1.id)


        }
return subscription;
    }

    String toString() {
        return topic?.name
    }
}



