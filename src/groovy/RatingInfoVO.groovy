package com.tothenew.linksharing

import grails.validation.Validateable

/**
 * Created by deepak on 24/2/16.
 */
@Validateable
class RatingInfoVO {
    Integer totalVotes
    Integer totalScore
    Integer averageScore

}
