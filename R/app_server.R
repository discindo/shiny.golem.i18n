#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  
  # calling the translator sent as a golem option
  i18n <- golem::get_golem_options(which = "translator")
  i18n$set_translation_language("en")
  
  # keep track of language object as a reactive
  i18n_r <- reactive({
    i18n
  })
  
  # change language
  observeEvent(input[["lang"]], {
    shiny.i18n::update_lang(session, input[["lang"]])
    i18n_r()$set_translation_language(input[["lang"]])
  })
  
  output[["welcome"]] <- renderUI({
    
    bg <- switch(input[["lang"]], 
                 "en" = "white",
                 "es" = "yellow",
                 "fr" = "steelblue",
                 "de" = "lightgrey")
    
    div(style = paste("padding: 10px; border-radius: 10px; background:", bg), h3(i18n$t("Welcome")))
  }) 
}
