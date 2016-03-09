package com.tothenew.linksharing

import grails.test.spock.IntegrationSpec

class ResourceRatingIntegrationSpec extends IntegrationSpec {

    def setup() {
    }

    def cleanup() {
    }

    void "top posts"() {
        setup:
        List list=ResourceRating.getTopPosts()

        expect:
        list.size()==5

    }
}