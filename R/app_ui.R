#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  # calling the translator sent as a golem option
  i18n <- golem::get_golem_options(which = "translator")
  i18n$set_translation_language("en")
  
  tagList(# Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      h3("{golem} app and {shiny.i18n} internationalization"),
      h5("(With server-side translation)"),
      br(),
      column(
        width = 4,
        radioButtons(
          inputId = "lang",
          label = "Select language",
          inline = TRUE,
          choices = i18n$get_languages()
        ),
        uiOutput("welcome")
      )
    ))
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'golem.i18n'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

