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
    	alert_success(sprintf("Active dataset: %s", "mtcars"))
    )

    ## show active dataset after data import
    output$show_active_dataset <- reactable::renderReactable({
    	get_reactable(mtcars)
    })

    output$show_codebook_info <- renderUI(
    	alert_info(sprintf(
    		"%s has %s rows and %s columns.", "mtcars", nrow(mtcars), ncol(mtcars)
    	))
    )

    output$codebook_table <- reactable::renderReactable({
    	get_codebook_table(mtcars[1:10, 1:6])
    })

    output$rename_table <- reactable::renderReactable({
    	get_rename_table(mtcars)
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
			"Export data", icon = phosphoricons::ph("download"),
			sidebarPanel(
				selectInput(
					ns("data"), "Select a dataset:",
					choices = c("mtcars", "iris", "infert")
				),
				selectInput(
					ns("file_type"), "File Type:",
					choices = c("xlsx", "xls", "dta")
				),
				hr(),
				downloadButton(
					ns("download"), "Download",
					class = "btn-primary", style = "width:100%;"
				)
			)
		),
		"---",
		tabPanel(
			"View codebook", icon = phosphoricons::ph("notebook"),
			uiOutput(ns("show_codebook_info")),
			alert_info(
				"Change variable names, data type, or add labels in the table",
				" below, then apply changes by clicking the button."
			),
			rhandsontable::rHandsontableOutput(ns("codebook_table")),
			shiny::actionButton(
				ns("validate"),
				tagList(
					phosphoricons::ph("arrow-circle-right"), "Apply changes"
				),
				class = "btn-primary", width = "100%"
			)
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
			alert_info(
				"Add new names to corresponding variables in the table below, ",
				"then apply changes by clicking the button."
			),
			rhandsontable::rHandsontableOutput(ns("rename_table")),
			actionButton(
				ns("validate"),
				tagList(
					phosphoricons::ph("arrow-circle-right"), "Apply changes"
				),
				class = "btn-primary", width = "100%"
			),
			actionButton(
				ns("clean"),
				tagList(
					phosphoricons::ph("textbox"), "Clean all names"
				),
				class = "btn-danger", width = "100%"
			)
		),
		tabPanel(
			"Remove variables",
			icon = phosphoricons::ph("backspace"),
			h2("Remove variables")
		)
	)
}
