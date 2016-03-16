package com.tothenew.linksharing

import grails.converters.JSON

class ResourceRatingController {

    def index() {}
    def saveRating(long id)
    {
        User user = session.user
        Resource resource = Resource.read(id)
        ResourceRating resourceRating = ResourceRating.findByUserAndResource(user,resource)
        if(resourceRating)
        {
            resourceRating.score = params.rating
            resourceRating.save()
        }
        else {
            ResourceRating newResourceRating = new ResourceRating(score:params.rating,user:user,resource:resource)
            if(newResourceRating.validate()){
                newResourceRating.save()
            }
            else {
                ([error : "Cannot save Resource Rating"]) as JSON
            }
        }
        redirect(controller:"login", action:"index")
    }
}
