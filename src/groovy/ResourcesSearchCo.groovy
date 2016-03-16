package com.tothenew.linksharing

//import grails.validation.Validateable

/**
 * Created by deepak on 24/2/16.
 */

class ResourcesSearchCo extends searchCO {
    long id
    String q
    long topic_id
    String visibility;
    Integer max
    Integer offset

    Link_Visibility getLink_Visibility() {

        Link_Visibility.toenum(this.visibility)
    }

    void getUser() {
        User user=User.get(id);
        user
    }

}
