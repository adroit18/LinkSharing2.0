package com.tothenew.linksharing
//
//class FirstTagLib {
//    static defaultEncodeAs = [taglib: 'html']
//    static namespace = "ls"
//
//    def markAsRead={
//        User user=session.user
//        List readingItems=user.readingItems
//    Boolean isAdmin=Boolean.valueOf(attrs.isAdmin)
//    out<<link(contreoller:'user',action:'showUserDetail',params: [isAdmin:isAdmin],
//    isAdmin?'Link For Admin User':'Link For Non-Admin User')<<'|||'
//}
//
////def showUserList={
////    List<User> user=[]
////    for(int i=1;i<=10;i++){
////        user.add(new User(firstName: "user_${i}"))
////    }
////    out<<render(template: 'util',model:[user:user])
////}
////
////    def showAdmin={attrs,body ->
////        Boolean isAdmin=Boolean.valueOf(session.user.isAdmin)
////        if(isAdmin)
////        {
////            out<<body()
////        }
////
////    }
////*/
////
////
////}
