package com.tothenew.linksharing

import grails.validation.Validateable

@Validateable
class UserCO {

       String username
        String emailId
        String password
        String firstName
        String lastName
        Boolean isAdmin = false
        Boolean isActive = true
        byte[] profilePic
        String confirmPassword
        String imageFileName
        transient photoType

       static mapping={
           isActive defaultValue: true
       }
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
            profilePic(nullable: true)
            photoType(nullable:true)
        }
    }




