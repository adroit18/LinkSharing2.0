package com.tothenew.linksharing

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured


class ResourceRatingController {

    @Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def saveRating(long id) {
        User user = session.user
        Resource resource = Resource.read(id)
        ResourceRating resourceRating = ResourceRating.findByUserAndResource(user, resource)
        Integer score1 = params.rating

        if (resourceRating) {
            println "-===========================================" + resourceRating.id
            println id
            resourceRating.validate(flush: true)
            resourceRating.executeUpdate("update ResourceRating as RR set RR.score=:rating where RR.id=:ide",
                    [rating: (score1 - 48), ide: resourceRating.id])
//       resourceRating.save(flush: true)
        } else {

            ResourceRating newResourceRating = new ResourceRating(score: (score1 - 48), user: user, resource: resource)
            if (newResourceRating.validate(flush: true)) {
                newResourceRating.save()

            } else {
                render([error: "Cannot save Resource Rating"]) as JSON
            }
        }

        redirect(controller: "login", action: "index")
    }
}
