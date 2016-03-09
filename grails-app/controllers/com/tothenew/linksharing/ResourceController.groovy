package com.tothenew.linksharing

import grails.converters.JSON

class ResourceController {

    def index() {}

    def delete(long id) {

        User loggediInUser = session.user
        Resource resource = Resource.read(id)
        if(loggediInUser.canDeleteResource(resource))
        {
            resource.delete()
            flash.message = "Resource Deleted"
        }
        else {
            flash.error = "Cannot found resource"
        }
        redirect(controller:"login",action:"index")
    }

    def search(ResourcesSearchCo co) {
        println "params : ${params}"
        if (co) {
            List<Resource> list = Resource.search(co).list();
            render(view: "search", model: [searchResources: list, query : params.q])
        } else{
            flash.message = "Search Parametre not Set"
        }



    }
//    def search(ResourcesSearchCo co)
//    {
////        if(co.q)
////        {
//            co.visibility = Link_Visibility.PUBLIC
//            List<Resource> resources = Resource.search(co).list([max:5]);
//            render(view:"search",model:[searchResources:resources])
////        }
////        else
////            flash.message = "No input in query"
//    }
//


    def show(long id)
    {
        Resource resource = Resource.get(id)
        if(resource.canViewedBy(session.user)) {
            List trendingTopics = Topic.getTrendingTopics()
            render(view: "/resource/_show", model: [resource: resource, trendingTopics: trendingTopics])
        }
        else {
            flash.error = "User Cannot view Topic"
        }
    }

}


