package com.tothenew.linksharing

import grails.converters.JSON

class ResourceController {

//    def index() {}

    def delete(long id) {

        User loggediInUser = session.user
        Resource resource = Resource.load(id)
        if (loggediInUser.canDeleteResource(resource)) {
            resource.delete(flush: true)
            flash.message = "Resource Deleted"
        } else {
            flash.error = "Cannot found resource"
        }
        redirect(controller: "login", action: "index")
    }

        def search(ResourcesSearchCo co) {

        params.max = params.max ? params.max : 5
        params.offset = params.offset ? params.offset : 0

        if (co) {
            List list1 = Resource.createCriteria().list(params) {
                projections {
                    property('id')
                    createAlias('topic', 't')
                }
                ilike('t.name', "%${co.q}%")

            }
            List<Resource> list = Resource.search(co).list(params);

            Integer a=list.totalCount
            Integer  b=list1.totalCount
            render(view: "/Search/search", model: [size:a+b,searchResources: list, resourceTopics: list1, queryString: co.q])
        } else {
            flash.message = "Search Parametres not Set"
        }


    }


    def show(long id) {

        Resource resource = Resource.get(id)
        if (resource.canViewedBy(session.user)) {
            List<TopicVO> trendingTopics = Topic.getTrendingTopics()
            render(view: "/resource/_show", model: [resource: resource, trendingTopics: trendingTopics])
        } else {

            [message: "User Cannot view Topic"] as JSON
        }
    }


    def edit(String newName,long id){
       Resource res=Resource.get(id)

       if(res.executeUpdate("update Resource as R set R.description=:description where R.id=:id", [description:newName, id: id])){
       redirect(controller: 'login',action: 'index');
       }
        else {
           render("/404")
       }

    }


}


