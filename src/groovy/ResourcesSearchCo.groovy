package com.tothenew.linksharing
/**
 * Created by deepak on 24/2/16.
 */
class ResourcesSearchCo extends searchCO {
    String q
    long topic_id
    String visibility;
    Link_Visibility getLink_Visibility(){

        Link_Visibility.toenum(this.visibility)
    }

}
