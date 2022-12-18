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
  	home_tab(id, ns),
  	data_tab(id, ns),
  	transform_tab(id, ns)
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
    # output$show_active_dataname <- renderUI(alert_info("No dataset."))
    output$show_active_dataname <- renderUI(
    	alert_success(sprintf(
    		"Active dataset: %s with %s rows and %s columns",
    		"mtcars", nrow(mtcars), ncol(mtcars)
    	))
    )

    output$show_active_dataset <- reactable::renderReactable({
    	show_reactable(mtcars)
    })
  })
}

## To be copied in the UI
#

## To be copied in the server
#


# ui helpers --------------------------------------------------------------

#' @noRd
home_tab <- function(id, ns) {
	tabPanel(
		title = NULL,
		icon = phosphoricons::ph("table"),
		uiOutput(ns("show_active_dataname")),
		reactable::reactableOutput(ns("show_active_dataset"))
	)
}

#' @noRd
data_tab <- function(id, ns) {
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
transform_tab <- function(id, ns) {
	navbarMenu(
		title = "Transform",
		# icon = icon("table"),
		tabPanel(
			"Rename variables",
			icon = phosphoricons::ph("kanban"),
			h2("Rename variables")
		),
		tabPanel(
			"Clean variable names",
			icon = phosphoricons::ph("textbox"),
			h2("Clean variable names")
		),
		tabPanel(
			"Remove variables",
			icon = phosphoricons::ph("backspace"),
			h2("Remove variables")
		)
	)
}
