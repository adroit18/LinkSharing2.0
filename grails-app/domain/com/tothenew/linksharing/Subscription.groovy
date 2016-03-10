package com.tothenew.linksharing

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
                count()

            }
            eq("user.id", user1.id)


        }
return subscription;
    }


}



