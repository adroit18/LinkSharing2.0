package com.tothenew.linksharing
import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@EqualsAndHashCode(includes = 'username')
@ToString(includes = 'username', includeNames = true, includePackage = false)


class User implements Serializable{

    String emailId;
    String firstName;
    String lastName;
    String username;
    String password;
    Boolean isActive;
    Boolean isAdmin;
    byte[] profilePic;
    //added for recommendation channel
    int profession;

    static transients = ['name', 'subscribedTopics']
    transient confirmPassword;
    transient photoType
    Date lastUpdated;
    Date dateCreated;


    private static final long serialVersionUID = 1

    transient springSecurityService


    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired


    User(String username, String password) {
        this()
        this.username = username
        this.password = password
    }

    Set<SecRole> getAuthorities() {
        SecUserSecRole.findAllByUser(this)*.secRole
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
    }


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
        profession(nullable: true)

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

    boolean canDeleteResource(Resource resource) {
        if ((resource.createdBy.id == this.id) || this.isAdmin) {
            return true
        } else {
            return false
        }
    }

    static int getScore(Resource resource, User user) {

        ResourceRating resourceRating = ResourceRating.findByUserAndResource(user, resource)
        int score = 1
        if (resourceRating) {
            score = resourceRating.score
        }
        return score
    }

    boolean isSubscribed(long topicId) {
        return (Subscription.findByUserAndTopic(this, Topic.read(topicId)))
    }


}
