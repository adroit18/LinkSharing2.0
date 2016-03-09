package com.tothenew.linksharing
import com.tothenew.linksharing.*

import com.sun.org.apache.bcel.internal.generic.RETURN

class ResourceRating {

    Resource resource;
    int score;
    User user;
    Date lastUpdated;
    Date dateCreated;
    static belongsTo = [user:User, resource:Resource]
    static constraints = {
        //user(nullable: false)
        //resource(nullable: false)
        score(max: 5,min: 1)
        user(unique: 'resource')

    }

    static List getTopPosts(){

        List<ResourceRating>resources=ResourceRating.createCriteria().list(max:5){
            projections{
                createAlias("resource","r")
                groupProperty("r.id")
                property('r.url')
                property('r.description')
                avg('score','avgScore')
            }
            property('r.createdBy')
            property('r.lastUpdated')
            order('avgScore','desc')
        }

        return resources;

    }



}