package com.tothenew.linksharing
/**
 * Created by deepak on 12/2/16.
 */
enum Link_Visibility {
    PUBLIC,
    PRIVATE

    public static Link_Visibility toenum(String str) {
        if(str.equalsIgnoreCase("PUBLIC")){
            PUBLIC
        }
        else
            PRIVATE
    }
}