class UrlMappings {
    static mappings = {
      "/$id"(controller:"page", action:"findByTitle")
      "/$controller/$action?/$id?"{
        constraints { }
      }
      "/display/$id"(controller:"page", action:"findByTitle")
      "/create/$name"(controller:"page", action:"createPage")
      "/edit/$id"(controller:"page", action:"editPage")
      "/$id?"(controller:"page", action:"findByTitle")
      
      "500"(view:'/error')
	}
}
