class SimpleWikiTagLib {
  static namespace = 'w'
  def wikiEngine
  def wikiContext

  def show = {attrs, body ->
    def content = body()
    content=content.replaceAll(/\r\n|\r|\n/,"\n")
    //println wikiEngine
    if(wikiEngine){
      def text = wikiEngine.render(content.trim(), wikiContext)
      out<<text
    }else{
      println "wikiEngine ERROR"
      out<<""
    }
  }
  
}