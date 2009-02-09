import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.radeox.engine.context.BaseInitialRenderContext
import org.springframework.cache.ehcache.EhCacheFactoryBean

beans = {
  textCache(EhCacheFactoryBean) {
      timeToLive = 300
  }
  downloadCache(EhCacheFactoryBean) {
      timeToLive = 300
  }
  contentCache(EhCacheFactoryBean) {
      timeToLive = 300
  }
  wikiCache(EhCacheFactoryBean) {
      timeToLive = 300
  }
  //contentToMessage(ContentAlertStack)
  wikiContext(BaseInitialRenderContext)
  wikiEngine(GrailsWikiEngineFactoryBean) {
      cacheService = ref('cacheService')
      def config = ConfigurationHolder.getConfig()
      contextPath = config.grails.serverURL
      context = wikiContext
  }
}