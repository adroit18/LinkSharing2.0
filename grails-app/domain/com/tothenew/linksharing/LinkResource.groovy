package com.tothenew.linksharing
import groovy.transform.EqualsAndHashCode

@EqualsAndHashCode
class LinkResource extends Resource {

    String url;

    static constraints = {
        url(blank:false);
    }
    String toString(){
        return  url
    }
}