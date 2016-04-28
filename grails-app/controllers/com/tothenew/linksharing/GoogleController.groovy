package com.tothenew.linksharing

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier
import com.google.api.client.http.HttpTransport

import grails.converters.JSON
import com.google.api.client.http.javanet.NetHttpTransport
import com.google.api.client.json.JsonFactory
import com.google.api.client.json.jackson2.JacksonFactory

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static com.tothenew.linksharing.SecUserSecRole.create

class GoogleController {

    def index(String id) {

       HttpTransport transport = new NetHttpTransport()
        JsonFactory jsonFactory = new JacksonFactory()

        GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(transport, jsonFactory)
                .setAudience(Arrays.asList(id))
                .setIssuer("https://accounts.google.com")
                .build();

        GoogleIdToken idToken = GoogleIdToken.parse(jsonFactory, id)

//        if(verifier.verify(idToken))
//        render idToken;


        if (idToken != null) {
            def payload = idToken.getPayload();

            String userId = payload.getSubject();
            System.out.println("User ID: " + userId);

            // Get profile information from payload
            String emailId = payload.getEmail();
            boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
            String username = (String) payload.get("name");
            String pictureUrl = (String) payload.get("picture");

            String lastName = (String) payload.get("family_name");
            String firstName = (String) payload.get("given_name");

            username = 'google_' + userId;

            def url = pictureUrl
            URL imageURL = new URL(url);
            BufferedImage originalImage = ImageIO.read(imageURL);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(originalImage, "jpg", baos);
            baos.flush();
            byte[] imageInByte = baos.toByteArray();
            baos.close()


            if (User.countByUsername(username) == 0) {
                String password = UUID.randomUUID()
                String confirmPassword = password
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


        } else {
            System.out.println("Invalid ID token.");
        }
    }
}
