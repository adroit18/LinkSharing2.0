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
            User admin = new User(firstName: "Deepak", lastName: "Uniyal", username: "Deepak Uniyal", password: "test@1234", emailId: "deepak.uniyal@tothenew.com", isAdmin: true, isActive: true, profession: 3, lastLoginTime: new Date())
            if (admin.save(flush: true, failOnError: true)) {
                users.add(admin)
                log.error "User ${admin} saved successfully"
            } else {
                log.error "Error saving user : ${admin.errors.allErrors}"
            }
            create(admin, adminRole, true)

            User normal1 = new User(firstName: "Waquar", lastName: "Azam", username: "furious", password: "test@1234", emailId: "waquar.azam@tothtenew.com", isAdmin: false, isActive: false, profession: 1, lastLoginTime: new Date())
            User normal2 = new User(firstName: "Ram", lastName: "Lakhan", username: "in", password: "test@1234", emailId: "normal2@tothtenew.com", isAdmin: false, isActive: true, profession: 2, lastLoginTime: new Date())
            User normal3 = new User(firstName: "Shyam", lastName: "Tarak", username: "whole", password: "test@1234", emailId: "normal3@tothtenew.com", isAdmin: false, isActive: true, profession: 4, lastLoginTime: new Date())
            User normal4 = new User(firstName: "Harman", lastName: "Bewaja", username: "labled", password: "test@1234", emailId: "normal4@tothtenew.com", isAdmin: false, isActive: true, profession: 5, lastLoginTime: new Date())
            User normal5 = new User(firstName: "Rap", lastName: "Rak", username: "somehow", password: "test@1234", emailId: "normal5@tothtenew.com", isAdmin: false, isActive: true, profession: 6, lastLoginTime: new Date())
            User normal6 = new User(firstName: "Ralph", lastName: "Gaur", username: "tough", password: "test@1234", emailId: "normal6@tothtenew.com", isAdmin: false, isActive: true, profession: 7, lastLoginTime: new Date())
            User normal7 = new User(firstName: "Paul", lastName: "Keval", username: "kama", password: "test@1234", emailId: "normal7@tothtenew.com", isAdmin: false, isActive: true, profession: 8, lastLoginTime: new Date())
            User normal8 = new User(firstName: "Karan", lastName: "Gaja", username: "kll", password: "test@1234", emailId: "normal8@tothtenew.com", isAdmin: false, isActive: true, profession: 9, lastLoginTime: new Date())
            User normal9 = new User(firstName: "Lack", lastName: "Laka", username: "ops", password: "test@1234", confirmPassword: "test@1234", emailId: "normal9@tothtenew.com", isAdmin: false, isActive: true, profession: 10, lastLoginTime: new Date())
            normal2.save(); normal3.save(); normal4.save(); normal5.save(); normal6.save()
            normal7.save(); normal8.save(); normal9.save();
            if (normal1.save(flush: true, failOnError: true)) {
                users.add(normal1); users.add(normal2)
                users.add(normal3); users.add(normal4)
                users.add(normal5); users.add(normal6)
                users.add(normal7); users.add(normal8)
                users.add(normal9)
            } else {
                log.error "Error saving user : ${normal.errors.allErrors}"
            }
            create(normal1, userRole, true)
            create(normal2, userRole, true)
            create(normal3, userRole, true)
            create(normal4, userRole, true)
            create(normal5, userRole, true)
            create(normal6, userRole, true)
            create(normal7, userRole, true)
            create(normal8, userRole, true)
            create(normal9, userRole, true)

            users;
        }

    }

    void createTopics() {
        User.getAll().each {
            if (it?.topics?.size() < 1) {
                (1..2).each { index ->
                    Topic topic = new Topic(name: "name${it.profession}${it}${it}", createdBy: it, visibility: Link_Visibility.PRIVATE, concernedArea: it.profession)
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

    def destroy = {

    }
}
