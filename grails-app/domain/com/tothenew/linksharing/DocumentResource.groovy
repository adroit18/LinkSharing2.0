package com.tothenew.linksharing
//import groovy.transform.EqualsAndHashCode
//
//@EqualsAndHashCode
class DocumentResource extends Resource {

    def grailsApplication
    String filePath;
    static transients =['contentType']
        String ide = UUID.randomUUID().toString()

    static mapping = {
        ide generator: 'assigned'

    }
    static constraints = {
        filePath(blank: false)
        //     contentType(blank:false)
    }

    String toString() {
        return filePath
    }
    def getContentType(){
        return "application/pdf"
    }

    boolean saveDocumenResource(DocumentResourceCO documentResourceCO, User user, def file) {

        if (file.getContentType() == contentType) {
            String filePath = grailsApplication.config.uploadDocumentFolder + documentResourceCO.topic.getId()
            File dir = new File(filePath)
            if (!dir.exists()) {
                dir.mkdirs()
            }
            file.transferTo(new File(filePath, "${ide}${file.originalFilename}"))
            documentResourceCO.filePath = documentResourceCO.topic.id + "/" +ide+ "${file.originalFilename}"
            DocumentResource documentResource = new DocumentResource(documentResourceCO.properties)
            documentResource.createdBy = user

            if (documentResource.validate()) {
                documentResource.save(flush: true, failOnError: true)
                def subscriptions = documentResource.topic.subscriptions
                for (Subscription subscriptionObj : subscriptions) {
                    ReadingItem readingItem = new ReadingItem()
                    readingItem.user = subscriptionObj.user
                    readingItem.resource = documentResource
                    readingItem.save(flush: true, failOnError: true)

                }
                return true
            }
            return false
        }
    }


}
