package com.tothenew.linksharing
import groovy.transform.EqualsAndHashCode

@EqualsAndHashCode
abstract class Resource {
    String description;
    User createdBy;
    Topic topic;
    Date lastUpdated;
    Date dateCreated;

    static hasMany = [readingItems: ReadingItem, resourceRating: ResourceRating]
    static belongsTo = [topic: Topic]
    static transients = ['ratingInfo'];

    static mapping = {
        //tablePerHierarchy(false)
        description(type: 'text')
    }

    static constraints = {
    }

    static namedQueries = {
        search { ResourcesSearchCo co ->
            if (co.topic_id) {
                eq('topic_id', co.topic_id)
            }
            if (co.visibility) {
                eq('topic.visibility', co.visibility)
            }
            ilike('description', "%${co.q}%")
        }
    }

    RatingInfoVO getRatingInfo() {
        List result = ResourceRating.createCriteria().get {
            projections {
                count('id', 'totalVotes')
                sum('score')
                avg('score')
            }
            eq('resource', this)
            order('totalVotes', 'desc')
        }

        new RatingInfoVO(totalVotes: result[0], totalScore: result[1], averageScore: result[2])
    }


    static List recentShares() {
        List recentSharesList
        recentSharesList = Resource.createCriteria().list(max: 5, offset: 0, sort: 'lastUpdated', order: 'desc') {
            projections {
                //createAlias('readingItems','r')
                property('url')
                property('description')
                property('filePath')
                property('createdBy')
                property('topic')
                //count();
                property('lastUpdated')
                property('id')

            }

        }
        return recentSharesList

    }

    String whichResource() {
        if (this instanceof LinkResource) {
            return "Link"
        } else if (this instanceof DocumentResource) {
            return "Document"
        }
    }

    boolean canViewedBy(User user) {
        Topic resourceTopic = this.topic
        return resourceTopic.canViewedBy(user)
    }
    String toString() {
        return description
    }



}
