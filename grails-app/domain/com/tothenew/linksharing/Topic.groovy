package com.tothenew.linksharing

class Topic {
    String name;
    User createdBy;
    Link_Visibility visibility;
    Date lastUpdated;
    Date dateCreated;
    static transients = ['subscribedUsers']
    //static belongsTo = [user: User]
    static hasMany = [subscriptions: Subscription, resources: Resource]
    static constraints = {
        name(blank: false, unique: 'createdBy');
        visibility(inlist: Link_Visibility.values() as List);
    }
    static mapping = {
        sort name: 'asc'
    }

    def afterInsert() {
        Topic.withNewSession {
            Subscription subscription = new Subscription(topic: this, user: this.createdBy, seriousness: Seriousness.VERY_SERIOUS)
            subscription.save()
        }
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
        println vos[0..4]
    }


    List getSubscribedUser(long id) {
        List list = Subscription.createCriteria().list {
            projections {
                createAlias('topic', 't')
                createAlias('user', 'u')
                property('u.username')
            }
            eq('t.id', id)

        }
    }



    String toString() {
        return name
    }

    List<User> getSubscribedUsers() {
        return Subscription.findAllByTopic(this)*.user
    }

    boolean isPublic()
    {
        return this.visibility==Link_Visibility.PUBLIC
    }
    boolean canViewedBy(User user)
    {
        return (user.isAdmin || this.isPublic() || Subscription.countByUserAndTopic(user,this))
    }

}