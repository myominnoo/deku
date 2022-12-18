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
  	header = uiOutput(ns("show_active_dataname")),
  	home_tab(id),
  	data_tab(id),
  	transform_tab(id)
  )
}

#' main Server Functions
#'
#' @noRd
mod_main_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    env <- reactiveValues(data = NULL, dataname = NULL, log = NULL)


    ## dataset status on load
    output$show_active_dataname <- renderUI(
    	alert_info("No dataset.")
    )
  })
}

## To be copied in the UI
#

## To be copied in the server
#


# ui helpers --------------------------------------------------------------

#' @noRd
home_tab <- function(id) {
	tabPanel(
		title = NULL,
		icon = phosphoricons::ph("table"),
		tableOutput("show_active_dataset")
	)
}

#' @noRd
data_tab <- function(id) {
	navbarMenu(
		title = "Data",
		# icon = phosphoricons::ph("file-csv"),
		tabPanel(
			"Import data", icon = phosphoricons::ph("upload"),
			datamods::import_ui(
				"data-import",
				from = c("env", "file", "copypaste", "googlesheets", "url"),
				file_extensions = c(".csv", ".txt", ".xls", ".xlsx", ".rds",
														".fst", ".sas7bdat", ".sav", ".dta")
			)
		),
		tabPanel(
			"Export data", icon = phosphoricons::ph("download")
		),
		"---",
		tabPanel(
			"View codebook", icon = phosphoricons::ph("notebook")
		)
	)
}

#' @noRd
transform_tab <- function(id) {
	navbarMenu(
		title = "Transform",
		# icon = icon("table"),
		tabPanel(
			"Rename variables", icon = phosphoricons::ph("kanban"), h2("Rename variables")
		),
		tabPanel(
			"Clean variable names", icon = phosphoricons::ph("textbox"), h2("Clean variable names")
		),
		tabPanel(
			"Remove variables", icon = phosphoricons::ph("backspace"), h2("Remove variables")
		)
	)
}
