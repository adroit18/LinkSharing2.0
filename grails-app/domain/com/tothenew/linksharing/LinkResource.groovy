package com.tothenew.linksharing

class LinkResource extends Resource {

    String url;

    static constraints = {
        url(blank:false);
    }
    String toString(){
        return  url
    }
}