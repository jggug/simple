class SimpleWikiTagLib {
  static namespace = 'w'
  def wikiEngine
  def wikiContext

  def show = {attrs, body ->
    def content = body()
    def pageId = attrs.pageId?:"0";
    content=content.replaceAll(/\r\n|\r|\n/,"\n")
    if(wikiEngine){
      def text = wikiEngine.render(content.trim(),""+pageId, wikiContext)
      out<<text
    }else{
      println "wikiEngine ERROR"
      out<<""
    }
  }
  
  /** パンくずの表示 */
  def topicPath = { attrs, body ->
    if(attrs.page) {
      out << "<ul id='crumbs'>"
      def parentList=parentLink(attrs.page).reverse()
      parentList.eachWithIndex{ title,idx ->
        out << "<li><a href='${createLinkTo(url:'/')}/display/${title}'>"
        out << title
        out << "</a></li>"
      }
      
      out << "</ul>"
    }
  }

  def parentLink(page) {
    def ret=[]
    if(page) {
      ret << page.title?.encodeAsHTML()
      parentLink(page.page).each{ ret << it }
    }
    
    return ret
  }
  
}