package com.tothenew.linksharing

class ApplicationFilters {

    def filters = {

/*
        loginCheck(controller: '*',action:"*",controllerExclude:"login") {
            before = {
               if (!session.user) {
                    flash.error="Please Sign in........."
                    redirect(action: 'index', controller: 'login')
                   if(controllerName.equals('user')  && actionName.equals('index')) {
                        // render session.user.username;
                   }
               } else {
               }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }*/
    }
}


class SecurityFilters {
    def filters =
            {
                loginCheck(controller: '*', action: '*')
                        {
                            before =
                                    {
                                        if (!session.user && !actionName.equals('login')) {
                                            redirect(action: 'login')
                                            return
                                            false
                                        }
                                    }
                        }
            }
}




