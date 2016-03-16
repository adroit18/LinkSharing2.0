package com.tothenew.linksharing

import grails.converters.JSON;

class DocumentResourceController {

    def index() {}


    def documentSave(DocumentResourceCO documentResourceCO) {
render "kjlk"
        if (documentResourceCO == null) {
            ([message: "Empty Resource"] as JSON)
        } else {

            User user = session.user
            def docFile = request.getFile("file")
            if (docFile.empty) {
                ([message: "File Cannot Be Empty"] as JSON)
                println "sdadadassssssssssssssssssssssssssssssssss"

            } else {
                DocumentResource documentResource = new DocumentResource();
                println ",................ssssss......${documentResourceCO.properties}"
                boolean result = documentResource.saveDocumenResource(documentResourceCO, user, docFile)
                if (result) {
                    ([message: "Resource Successfully Created"] as JSON)
                    redirect(controller: 'login', action: 'index')
                } else {
                    ([message: "Error Submitting Resource"] as JSON)
                    redirect(controller: 'login', action: 'index')
                }

            }
        }

    }

    def downloadDocument() {
        Resource document = Resource.get(params.fid)
        //  println "-----------------+++++++++${document}"
        if (document == null) {
            flash.message = "Resource file missing."
            return true
        } else {
            response.setContentType("application/pdf")
            def filePath = grailsApplication.config.uploadDocumentFolder + document.filePath
            //    println "-----------------${filePath}"

            response.setHeader("Content-Disposition", "Attachment")
            File file = new File(filePath)
            FileInputStream fileInputStream = new FileInputStream(file)
            OutputStream outputStream = response.getOutputStream()
            byte[] buffer = new byte[4096]
            int len
            while ((len = fileInputStream.read(buffer)) > 0) {
                outputStream.write(buffer, 0, len)
            }
            outputStream.flush()
            outputStream.close()
            fileInputStream.close()
        }
    }
}



