package com.tothenew.linksharing;
import com.tothenew.linksharing.*
import grails.validation.Validateable

/**
 * Created by deepak on 24/2/16.
 */
@Validateable
class TopicVO {
    Integer id
    String name
    Link_Visibility visibility
    Integer count
    User createdBy
}
