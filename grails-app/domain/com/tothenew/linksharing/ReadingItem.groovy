package com.tothenew.linksharing

class ReadingItem {

    Resource resource;
    User user;
    boolean isRead;
    Date lastUpdated;
    Date dateCreated;
    static  belongsTo = [user:User,resource:Resource]

        static constraints = {
           // resource(nullable: false)
            resource unique: "user";
            //isRead(nullable: false)
        }


    static List userInbox(User user1) {

        List list=ReadingItem.createCriteria().list{
            projections{
                createAlias('resource','r')
                property('id')
                property('r.description')
                property('r.url')
                property('r.createdBy')
                property('r.id')
            }
            eq('user',user1)
//            eq('isRead',false)

        }
        return list
    }


}