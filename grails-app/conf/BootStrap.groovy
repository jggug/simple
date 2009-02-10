import org.grails.plugins.springsecurity.service.AuthenticateService

class BootStrap {
	AuthenticateService authenticateService

  def init = { servletContext ->
    def adminName="admin"
    def adminRealName="管理者"
    def adminEmail="admin@grails.jp"
    def password="grailsRock"
    
    // ユーザがなかった場合にデフォロールとデフォ管理者を作ります
    if(Person.list().size()==0) {
      def r_user=new Authority(authority:"ROLE_USER",description:"").save(flush:true)
      def r_admin=new Authority(authority:"ROLE_ADMIN",description:"").save(flush:true)
      
  		def pass = authenticateService.passwordEncoder(password)
      def admin=new Person(username:adminName,userRealName:adminRealName,enabled:true,email:adminEmail,emailShow:true,passwd:pass).save(flush:true)
      r_user.addToPeople(admin)
      r_admin.addToPeople(admin)
      r_user.save(flush:true)
      r_admin.save(flush:true)
      println "create default role & user"
    }
  }
  def destroy = {
  }
} 