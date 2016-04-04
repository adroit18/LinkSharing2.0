import com.tothenew.linksharing.*

import static com.tothenew.linksharing.SecUserSecRole.create


//import Link_Visibility
//import Seriousness

class BootStrap {

    def grailsApplication
    def init = {

        println "External file is included " + grailsApplication.config.myname
        List<User> users = createUsers()
        createTopics();
        createResource();

        subscribeTopics();
        createReadingItems();

        createResourceRatings();


    }

    List<User> createUsers() {

        def adminRole = new SecRole(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = new SecRole(authority: 'ROLE_USER').save(flush: true)

        List<User> users = []
        if (User.count() == 0) {

            User admin = new User(firstName: "Deepak", lastName: "Uniyal", username: "Deepak Uniyal", password: "test@1234", emailId: "deepak.uniyal@tothenew.com", isAdmin: true, isActive: true)
            if (admin.save(flush: true, failOnError: true)) {
                users.add(admin)
                log.error "User ${admin} saved successfully"
            } else {
                log.error "Error saving user : ${admin.errors.allErrors}"
            }
           create(admin,adminRole,true)

          User normal = new User(firstName: "Waquar", lastName: "Azam", username: "Waquar Azam", password: "test@1234", emailId: "waquar.azam@tothtenew.com", isAdmin: false, isActive: false)
            if (normal.save(flush: true, failOnError: true)) {
                users.add(normal)
            } else {
                log.error "Error saving user : ${normal.errors.allErrors}"
            }
            create(normal,userRole,true)



            users;
        }

    }

    void createTopics() {
        User.getAll().each {
            if (it?.topics?.size() < 1) {
                (1..5).each { index ->
                    Topic topic = new Topic(name: "name${index}${it}${it}", createdBy: it, visibility: Link_Visibility.PRIVATE)
                    if (topic.save())
                        log.info("Created Topic ${topic}");
                    else
                        log.error("Could not create topic ${topic}")

                }

            }
        }
    }

    void createResource() {
        Topic.getAll().each { topic ->
            User topicCreator = topic.createdBy
            (1..2).each {
                    DocumentResource documentResource = DocumentResource.findOrCreateWhere(filePath: 'home', description: topic.name, createdBy: topicCreator, topic: topic)
                if (documentResource.save()) {
                    topic.resources?.add(documentResource)
                    log.info('document resource added to Topic')
                } else {

                    log.error documentResource.errors
                }
            }
            (1..2).each {
                LinkResource linkResource = LinkResource.findOrCreateWhere(url: 'https://www.google.com', description: topic.name, createdBy: topicCreator, topic: topic)
                if (linkResource.save()) {
                    topic.resources?.add(linkResource)
                    log.info('link resource added to topic')
                } else {
                    log.error linkResource.errors
                }
            }
        }

    }


    void subscribeTopics() {
        List<Topic> topics = Topic.getAll()
        List<User> users = User.getAll()
        users.each { user ->
            (topics - user.topics).each {
                Subscription subscription = Subscription.findOrCreateWhere(topic: it, user: user, seriousness: Seriousness.CASUAL)
                if (subscription.save()) {
                    log.info("subscription created for user ${user} and topic ${it}")
                } else {
                    log.error("unable to create subscription for user ${user} and topic ${it}")
                }
            }
        }

    }

    void createReadingItems() {
        ReadingItem readingItem
        Resource resource
        Subscription.getAll().each {
            resource = Resource.findByTopic(it.topic)
            //println resource
            if ((resource.createdBy != it.user) && (!ReadingItem.findByUserAndResource(it.user, resource))) {
                readingItem = new ReadingItem(user: it.user, resource: resource, isRead: false)
                if (readingItem.save()) {
                    log.info("reading item created for ${it.user} and ${resource}")
                }
            }
        }
    }


    void createResourceRatings() {
        ResourceRating rating
        ReadingItem.getAll().each {
            if (!it.isRead) {
                rating = new ResourceRating(user: it.user, resource: it.resource, score: 1)
                if (rating.save()) {
                    log.info("created resource rating for user ${it.user} and resource ${it.resource}")
                } else
                    log.error("unable to create resource rating for user ${it.user} and resource ${it.resource}")
            }
        }
    }

/*
     void createReadingItems() {
         List<User> users = User.getAll()
         users.each { user ->
             Set subscribedTopics = user.topics
             subscribedTopics.each { subscribedTopic ->
                 Set resources = subscribedTopic.resources
                 resources.each { resource ->
                     if (resource.createdBy != user) {
                         ReadingItem readingItem = ReadingItem.findOrCreateWhere(user: user, resource: resource)
                         if (readingItem.save()) {
                             log.info("reading item created for ${user} and ${resource}")
                         } else {
                             log.error(readingItem.errors)
                         }
                     } else {
                         log.info("${resource.createdBy} == ${user}")
                     }

                 }
             }
         }
     }


    void createResourceRatings() {
        Set readingItems = ReadingItem.findAllByIsRead(false)
        readingItems.each { readingItem ->
            User user = readingItem.user
            Resource resource = readingItem.resource
            ResourceRating resourceRating = new ResourceRating(user: user, resource: resource, score: 4)
            if (resourceRating.save()) {
                log.info("created resource rating for user ${user} and resource ${resource}")
            } else {
                log.error("unable to create resource rating for user ${user} and resource ${resource}")
            }
        }

    }

*/


    def destroy = {

    }
}
