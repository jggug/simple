import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH

class PageController {
  //def index = { redirect(action:findByTitle,params:params) }

  //def wikiEngine
  //def wikiContext

  def findByTitle = {
    def toppage = CH.config?.simple?.contents?.toppage
    Page page
    if(params.pageId){
      page = Page.get(params.pageId)
    }else{
      def title = params.id?:toppage
      page = Page.findByTitle( title )
    }
    if(!page) {
      page = Page.findByTitle( toppage )
    }
    
    if(page) {
      render(view:"show", model:[page : page])
    } else {
      if(authUserDomain) flash.message="トップページが見つかりませんでした、トップページを作成して下さい"
      redirect(action:createPage,params:[name:toppage])
    }
  }
  
  def createPage = {
    def page = new Page()
    if(params["addChild"]==""){
      page.page=Page.get(params.name)
    }else{
      page.title=params.name!="new"?params.name:""
    }
    render(view:"editPage", model:[page : page,mode:"create"])
  }
  
  def editPage = {
    def page = Page.get( params.id )
    if(!page) {
      flash.message = "Page not found with id ${params.id}"
      redirect(action:findByTitle)
    }else {
      render(view:"editPage", model:[page : page,mode:"edit"])
    }
  }

  def delete = {
      def page = Page.get( params.id )
      if(page) {
        if(page.pages.size()>0){
          flash.message = "子ページが存在するため、ページ「${page}」を削除できません."
          render(view:"editPage", model:[page : page,mode:"edit"])
          return
        }else if(page.page){
          def parent = Page.get(page.page.id)
          parent.removeFromPages(page)
          page.delete()
          flash.message =""
          redirect(uri:"${createLink(url:'/display')}/${parent.title.encodeAsURL()}")
          return
        }else{
          page.delete()
          flash.message = ""
        }
        redirect(action:findByTitle)
      }
      else {
          flash.message = "Page not found with id ${params}"
          redirect(action:findByTitle)
      }
  }

  def update = {
      def page = Page.get( params.id )
      if(page) {
          page.properties = params
          page.updated =authUserDomain
          if(!page.hasErrors() && page.save()) {
              flash.message = "Page ${params.id} updated"
              redirect(uri:"${createLink(url:'/display')}/${page.title.encodeAsURL()}")
          }
          else {
              render(view:'edit',model:[page:page])
          }
      }
      else {
          flash.message = "Page not found with id ${params.id}"
          redirect(action:edit,id:params.id)
      }
  }

  def save = {
    def page = new Page()
    page.properties = params
    page.created =authUserDomain
    page.updated =authUserDomain
    
    // 親ページ指定が無かった場合は自動的にトップページの下に行く
/*    if(!page.page) {
      def topname = CH.config?.simple?.contents?.toppage
      Page topPage=Page.findByTitle(topname)
      if(topPage) page.page=topPage
    }
*/
    
    if(!page.hasErrors() && page.save()) {
      flash.message = "Page ${page.title} created"
      redirect(uri:"${createLink(url:'/display')}/${page.title.encodeAsURL()}")
    }
    else {
        render(view:'create',model:[page:page])
    }
  }
  
  /** 最終更新のRSSFeed */
  def lastUpdate={
    def contextPath=CH.config.grails.serverURL
    def feedUrl=contextPath+"/page/lastUpdated"
    def lastPages=Page.list(max:10,sort:"lastUpdated",order:"desc")

    render(feedType:"rss", feedVersion:"2.0") {
      title="Simple LastUpdated"
      link=feedUrl
      description="最終更新履歴"

      lastPages.each { page ->
        entry(page.title){
          author=page.updated ? page.updated.username : "不明"
          publishedDate=page.lastUpdated
          link=contextPath+"/display/${page.title}"
          page.body
        }
      }
    }
  }
  
  def preview ={
    [msg:params.body]
  }
}
