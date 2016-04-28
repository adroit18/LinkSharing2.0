package com.tothenew.linksharing

import grails.converters.JSON

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static com.tothenew.linksharing.SecUserSecRole.create

class FacebookController {

    def fbLogin(String username, String emailId, String firstName, String lastName) {

        username = 'facebook_' + params.userId
        if (User.countByUsername(username) == 0) {
            String password = UUID.randomUUID()
            String confirmPassword = password

            def url = params.picture
            URL imageURL = new URL(url);
            BufferedImage originalImage = ImageIO.read(imageURL);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(originalImage, "jpg", baos);
            baos.flush();
            byte[] imageInByte = baos.toByteArray();
            baos.close()

            User user = new User(username: username, emailId: emailId, firstName: firstName, lastName: lastName, password: password, confirmPassword: confirmPassword, profilePic: imageInByte)

            if (user.save(flush: true, failOnError: true)) {
                def userRole = SecRole.findByAuthority('ROLE_USER')
                create(user, userRole, true)
            }
            session.user = user

            if (session.user) {
                List subscriptionList = Subscription.getSubscriptions(session.user)
                List inboxList = ReadingItem.userInbox(session.user)
                List<Topic> subscribedTopics = User.getSubscribedTopics(session.user)

                ([message: "Login Successfull"] as JSON)
                render view: '/user/userIndex', model: [subscriptionList: subscriptionList, inboxList: inboxList, subscribedTopics: subscribedTopics]

            }


        } else {
            User user = User.findByUsername(username);
            session.user = user

            if (session.user) {
                List subscriptionList = Subscription.getSubscriptions(session.user)
                List inboxList = ReadingItem.userInbox(session.user)
                List<Topic> subscribedTopics = User.getSubscribedTopics(session.user)

                ([message: "Login Successfull"] as JSON)
                render view: '/user/userIndex', model: [subscriptionList: subscriptionList, inboxList: inboxList, subscribedTopics: subscribedTopics]

            }

        }

    }
}
