class UrlMappings {
    static mappings = {
      "/"(controller:"page", action:"findByTitle")
      "/$id?"(controller:"page", action:"findByTitle")
      "/$controller/$action?/$id?"{
        constraints {
          // apply constraints here
        }
      }
      "/display/$id"(controller:"page", action:"findByTitle")
      "/create/$name"(controller:"page", action:"createPage")
      "500"(view:'/error')
	}
}
