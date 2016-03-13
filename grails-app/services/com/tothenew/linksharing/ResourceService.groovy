package com.tothenew.linksharing

import grails.transaction.Transactional

@Transactional
class ResourceService {

    def serviceMethod() {
    }

    def searchResource(ResourcesSearchCo co) {

        if (co) {
            List<Resource> list = Resource.search(co).list();
            return list
//            render(view: "search", model: [searchResources: list])
             }
// else {
//            flash.message = "Search Parametres not Set"
//        }


    }
}
