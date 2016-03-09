package com.tothenew.linksharing

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
            ilike('description',"%${co.q}%")
        }
    }

     RatingInfoVO getRatingInfo() {
        List result = ResourceRating.createCriteria().get{
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
        List recentSharesList, recentSharesList1;
        recentSharesList = Resource.createCriteria().list(max: 5, offset: 0, sort: 'lastUpdated', order: 'desc') {
            projections {
                property('url')
                property('description')
                property('filePath')
                property('createdBy')
                property('topic')
                //count();
                property('lastUpdated')
                property('id')

            }

            Date date = new Date()
            Calendar calendar = Calendar.getInstance();
            recentSharesList.each {
                calendar.setTimeInMillis((date.time - recentSharesList[it][5].time));
                int time_HOUR = calendar.get(Calendar.HOUR);
                int time_MINUTE = calendar.get(Calendar.MINUTE);
                int time_SECOND = calendar.get(Calendar.SECOND);
                recentSharesList1 = recentSharesList
                if (time_HOUR > 1)
                    recentSharesList1[it][6] = time_HOUR
                else
                    recentSharesList1[it][6] = time_MINUTE > 1 ? time_MINUTE : time_SECOND

            }

        }
        return recentSharesList

    }

    String whichResource()
    {
        if(this instanceof LinkResource) {
            return "Link"
        }
        else if(this instanceof DocumentResource)
        {
            return "Document"
        }
    }
    boolean canViewedBy(User user)
    {
        Topic resourceTopic = this.topic
        return resourceTopic.canViewedBy(user)
    }



}
