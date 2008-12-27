class Page {
  static hasMany = [pages:Page]
  static belongsTo = [page:Page]
  
  String title
  String body
  Date dateCreated
  Date lastUpdated
  static constraints = {
    title(nullable:false,blank:false)
    body(nullable:false,maxSize:400000)
    page(nullable:true)
  }
  String toString(){
    title
  }
  
}
