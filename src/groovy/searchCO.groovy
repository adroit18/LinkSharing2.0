package com.tothenew.linksharing

import grails.validation.Validateable

@Validateable
class searchCO {
    String q
    Integer max
    Integer offset
    String order
    String sort

}
