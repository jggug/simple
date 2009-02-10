class SimpleWikiTagLib {
  static namespace = 'w'
  def wikiEngine
  def wikiContext

  def show = {attrs, body ->
    def content = body()
    content=content.replaceAll(/\r\n|\r|\n/,"\n")
    if(wikiEngine){
      def text = wikiEngine.render(content.trim(), wikiContext)
      out<<text
    }else{
      println "wikiEngine ERROR"
      out<<""
    }
  }
  
  /** パンくずの表示 */
  def topicPath = { attrs, body ->
    if(attrs.page) {
      out << "<div class='topicPath'>"
      def parentList=parentLink(attrs.page).reverse()
      parentList.eachWithIndex{ title,idx ->
        out << "<a href='${createLinkTo(url:'/')}/display/${title}'>"
        out << title
        out << "</a>"
        if((parentList.size()-1)!=idx){
          out << "&nbsp;>&nbsp;"
        }
      }
      
      out << "</div>"
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