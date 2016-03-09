package linksharing

import com.tothenew.linksharing.*;
import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.IgnoreRest
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@Mock(Resource)
@TestFor(ResourceController)
class ResourceControllerSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "delete successful"() {
        setup:
        Resource resource
        Resource.metaClass.static.get = { def id ->
            return resource
        }
        and:
        Resource.metaClass.delete = {Map p->   }
        resource=new LinkResource()



        when:
        controller.delete()

        then:
        response.contentAsString == ""
        where:
        id=1

    }

    def "delete resource not found"(){
        setup:
        Resource.metaClass.static.get = { def id ->
            return null
        }
        Resource.metaClass.delete={}
        when:
        controller.delete()

        then:
        response.contentAsString == "resource not found"

        where:
        id=1
    }
}