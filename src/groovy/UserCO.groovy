package com.tothenew.linksharing

import grails.validation.Validateable

/**
 * Created by deepak on 8/3/16.
 */
@Validateable
class UserCO {

       String username
        String emailId
        String password
        String firstName
        String lastName
        Boolean isAdmin = false
        Boolean isActive = true
        String photo
        String confirmPassword
        String imageFileName


        String toString() {
            return "${firstName} ${lastName}"
        }
        static constraints = {
            confirmPassword(nullable: false, blank: false)
            username(unique: true, size: 1..100)
            emailId(unique: true, email: true)
            imageFileName nullable: true
            password(size: 4..50, validator: { val, obj ->
                return val.equals(obj.confirmPassword)
            })
            photo(nullable: true)
        }
    }




