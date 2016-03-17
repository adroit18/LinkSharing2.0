package com.tothenew.linksharing

import grails.converters.JSON


class ResourceRatingController {

//    def index() {}

    def saveRating(long id) {
        User user = session.user
        Resource resource = Resource.read(id)
        ResourceRating resourceRating = ResourceRating.findByUserAndResource(user, resource)
        Integer score1=params.rating

        if (resourceRating) {
//            resourceRating.score = params.rating
            resourceRating.executeUpdate("update ResourceRating as RR set RR.score=:rating where RR.id=:ide",[rating:(score1-48),ide:id])
        } else {
            ResourceRating newResourceRating = new ResourceRating(score: (score1-48), user: user, resource: resource)
            if (newResourceRating.validate()) {
                newResourceRating.save()

            } else {
                render([error: "Cannot save Resource Rating"]) as JSON
            }
        }

        redirect(controller:"login", action:"index")
    }
}
