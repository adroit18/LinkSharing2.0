package com.tothenew.linksharing

class User {

    String emailId;
    String firstName;
    String lastName;
    String username;
    String password;
    Boolean isActive;
    Boolean isAdmin;
    String profilePic;
    static transients = ['name', 'subscribedTopics']
    transient confirmPassword;

    Date lastUpdated;
    Date dateCreated;


    static hasMany = [topics: Topic, subscriptions: Subscription, readingItems: ReadingItem, resources: Resource, ratingItems: ResourceRating]
    static mapping = {
        //profilePic(sqlType: 'longblob')
        sort id: 'desc'
        isActive defaultValue: true
    }
    static constraints = {
        emailId(nullable: true, unique: true, blank: false, email: true);
        password(blank: false, minSize: 5);
        firstName(blank: false);
        lastName(blank: false);
        isActive(nullable: true);
        isAdmin(nullable: true);
        profilePic(nullable: true);

        confirmPassword(bindable: true, nullable: true, blank: true, validator: { String val, User obj ->
            boolean result = false

            if (obj.id) {
                result = true
            } else {
                result = val = obj.password
            }
            return result
        })


    }

    String getName() {
        [this.firstName, this.lastName].findAll { it }.join(' ')

    }

    String toString() {
        return getName()
    }


    static List<TopicVO> getTrendingTopics() {
        List resources = Resource.createCriteria().list {
            projections {
                createAlias('topic', 't')
                groupProperty('t.id')
                property('t.name')
                property('t.visibility')
                property('createdBy')
                count();
            }
        }
        List list = resources.sort { -it[4] }
        List<TopicVO> vos = []
        list.each {
            vos << new TopicVO(id: it[0], name: it[1], visibility: it[2], createdBy: it[3], count: it[4])
        }
        return vos[0..4];
    }

    static List userTotalSubscriptionsAndTopics(User user1) {

        List userDetails1 = Subscription.createCriteria().listDistinct {
            projections {
                count()
            }
            eq("user.id", user1.id)
        }
        List userDetails2 = Topic.createCriteria().listDistinct {
            projections {
                count()
            }
            eq("createdBy", user1)
        }
        List userDetails = userDetails1 + userDetails2
        println userDetails

        return userDetails;

    }


    static List getSubscribedTopics(User user1) {
        List list = User.createCriteria().list {
            projections {
                createAlias('subscriptions', 's');
                property('s.topic')

            }
            eq('s.user', user1)
        }
        return list

    }

    boolean canDeleteResource(Resource resource)
    {
        if((resource.createdBy.id==this.id)|| this.admin)
        {
            return true
        }
        else {
            return false
        }
    }

    int getScore(Resource resource)
    {
        int score = ResourceRating.createCriteria().get{
            projections {
                property("score")
            }
            eq("user",this)
            eq("resource",resource)
        }
        return score
    }


}
