package com.tothenew.linksharing
import groovy.transform.EqualsAndHashCode

@EqualsAndHashCode
class User {

    String emailId;
    String firstName;
    String lastName;
    String username;
    String password;
    Boolean isActive;
    Boolean isAdmin;
    byte[] profilePic;
    static transients = ['name', 'subscribedTopics']
    transient confirmPassword;
    transient photoType

    Date lastUpdated;
    Date dateCreated;


    static hasMany = [topics: Topic, subscriptions: Subscription, readingItems: ReadingItem, resources: Resource, ratingItems: ResourceRating]
    static mapping = {
        profilePic(sqlType: 'longblob')
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
        if((resource.createdBy.id==this.id)|| this.isAdmin)
        {
            return true
        }
        else {
            return false
        }
    }

    static int getScore(Resource resource,User user){

        ResourceRating resourceRating= ResourceRating.findByUserAndResource(user,resource)
        int score=1
        if(resourceRating){
            score=resourceRating.score
        }
        return score
    }

    boolean isSubscribed(long topicId)
    {
        return(Subscription.findByUserAndTopic(this,Topic.read(topicId)))
    }



}
