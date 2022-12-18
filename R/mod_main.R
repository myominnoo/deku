#' main UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @import shiny
mod_main_ui <- function(id){
  ns <- NS(id)
  navbarPage(
  	theme = bslib::bs_theme(5, "flatly"),
  	title = "Deku",
  	id = "navbar_main",
  	home_tab,
  )
}

#' main Server Functions
#'
#' @noRd
mod_main_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
#

## To be copied in the server
#


# ui helpers --------------------------------------------------------------

home_tab <- tabPanel(
	title = "Home",
	icon = icon("house"),
	h2("Home menu")
)
# navbarMenu(
# 	title = "Data Management",
# 	icon = icon("table"),
# 	tabPanel("Import data", icon = phosphoricons::ph("upload"),
# 					 datamods::import_ui(
# 					 	"data-import",
# 					 	from = c("env", "file", "copypaste", "googlesheets", "url"),
# 					 	file_extensions = c(".csv", ".txt", ".xls", ".xlsx", ".rds",
# 					 											".fst", ".sas7bdat", ".sav", ".dta")
# 					 )),
# 	tabPanel("Export data", icon = phosphoricons::ph("download"), h2("Export data")),
# 	"---",
# 	tabPanel("Rename variables", icon = phosphoricons::ph("kanban"), h2("Rename variables")),
# 	tabPanel("Clean variable names", icon = phosphoricons::ph("textbox"), h2("Clean variable names")),
# 	tabPanel("Remove variables", icon = phosphoricons::ph("backspace"), h2("Remove variables"))
# )

