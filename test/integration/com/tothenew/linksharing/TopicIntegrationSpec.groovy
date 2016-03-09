package com.tothenew.linksharing

import grails.test.spock.IntegrationSpec

class TopicIntegrationSpec extends IntegrationSpec {

    def setup() {
    }

    def cleanup() {
    }

    void "trending topics"() {

        when:
        List list=Topic.getTrendingTopics()

        then:
        list.size()==5
    }

    static class ResourceRatingIntegrationSpec extends IntegrationSpec {

        def setup() {
        }

        def cleanup() {
        }

        void "test something"() {
        }
    }
}