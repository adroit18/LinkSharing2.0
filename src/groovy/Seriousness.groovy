package com.tothenew.linksharing

import grails.validation.Validateable

/**
 * Created by deepak on 12/2/16.
 */
@Validateable
enum Seriousness {
    SERIOUS,
    VERY_SERIOUS,
    CASUAL

    public static Seriousness toenum(String str) {
        if(str.equalsIgnoreCase("serious")){
            SERIOUS
        }
        else if (str.equalsIgnoreCase("very_serious"))
            VERY_SERIOUS
        else
            CASUAL

    }

}