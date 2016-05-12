package com.tothenew.linksharing

class UtilController {

    def index() {
        render view: 'pageNotFound'
    }
    def erro()
    {
        render view: 'error'
    }

    def test(User user) {
        render user
    }

    def uitest(){
        render view: "/util/index"
    }
    def uiftest(){
        render view: "/user/loginAndRegister"
    }
}
