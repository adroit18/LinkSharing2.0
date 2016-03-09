package com.tothenew.linksharing
/**
 * Created by deepak on 12/2/16.
 */
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