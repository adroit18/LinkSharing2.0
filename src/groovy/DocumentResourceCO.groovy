/**
 * Created by deepak on 6/3/16.
 */

package com.tothenew.linksharing

import grails.validation.Validateable

@Validateable
class DocumentResourceCO {
    String filePath
    String description
    User createdBy
    Topic topic
}
