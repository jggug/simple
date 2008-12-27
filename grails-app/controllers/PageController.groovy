class PageController {
  def index = { redirect(action:list,params:params) }

  // the delete, save and update actions only accept POST requests
  def allowedMethods = [delete:'POST', save:'POST', update:'POST']

  def list = {
      if(!params.max) params.max = 10
      [ pageList: Page.list( params ) ]
  }

  def show = {
      def page = Page.get( params.id )

      if(!page) {
          flash.message = "Page not found with id ${params.id}"
          redirect(action:list)
      }
      else { return [ page : page ] }
  }
  
  
  def wikiEngine
  def wikiContext
  def findByTitle = {
    println "==>"+params
   def title = params.id?:"top"
    def page = Page.findByTitle( title )
    if(!page) {
        flash.message = "Page not found with id ${params.id}"
        redirect(action:list)
    }
    else { 
      //def content = wikiEngine.render(page.body.trim(), wikiContext)
      //println content
      render(view:"show", model:[page : page])
      //return [ page : page ] 
    }
  }
  
  def createPage = {
    //println params.name
    def page = new Page()
    page.properties = params
    page.title=params.name
    
    render(view:"create", model:[page : page])
  }
  

  def delete = {
      def page = Page.get( params.id )
      if(page) {
          page.delete()
          flash.message = "Page ${params.id} deleted"
          redirect(action:list)
      }
      else {
          flash.message = "Page not found with id ${params.id}"
          redirect(action:list)
      }
  }

  def edit = {
      def page = Page.get( params.id )

      if(!page) {
          flash.message = "Page not found with id ${params.id}"
          redirect(action:list)
      }
      else {
          return [ page : page ]
      }
  }

  def update = {
      def page = Page.get( params.id )
      if(page) {
          page.properties = params
          if(!page.hasErrors() && page.save()) {
              flash.message = "Page ${params.id} updated"
              redirect(action:show,id:page.id)
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

  def create = {
      def page = new Page()
      page.properties = params
      return ['page':page]
  }

  def save = {
      def page = new Page(params)
      if(!page.hasErrors() && page.save()) {
          flash.message = "Page ${page.id} created"
          redirect(action:show,id:page.id)
      }
      else {
          render(view:'create',model:[page:page])
      }
  }
}
