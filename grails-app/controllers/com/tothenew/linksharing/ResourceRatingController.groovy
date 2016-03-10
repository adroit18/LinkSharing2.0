package com.tothenew.linksharing

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
                flash.error = "Cannot save Resource Rating"
            }
        }
        redirect(controller:"login", action:"index")
    }
}
