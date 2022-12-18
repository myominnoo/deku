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
  	log_tab(id, ns),
  	data_tab(id, ns),
  	transform_tab(id, ns),
  	analysis_tab(id, ns),
  	graph_tab(id, ns)
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

    output$codebook_table <- rhandsontable::renderRHandsontable({
    	get_codebook_table(mtcars[1:10, 1:6])
    })

    output$rename_table <- rhandsontable::renderRHandsontable({
    	get_rename_table(mtcars)
    })

		output$delete_vars_table <- rhandsontable::renderRHandsontable({
			get_delete_vars_table(data.frame(Vars = names(mtcars)))
		})

		output$show_log <- renderPrint({
			p(shinipsum::random_text(nwords = 1e4))
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
log_tab <- function(id, ns) {
	tabPanel(
		title = NULL,
		icon = phosphoricons::ph("notepad"),
		verbatimTextOutput(ns("show_log"))
	)
}

#' @noRd
data_tab <- function(id, ns) {
	navbarMenu(
		title = "Data",
		# icon = phosphoricons::ph("file-csv"),
		tabPanel(
			title = "Import data",
			icon = phosphoricons::ph("upload"),
			datamods::import_ui(
				"data-import",
				from = c("env", "file", "copypaste", "googlesheets", "url"),
				file_extensions = c(".csv", ".txt", ".xls", ".xlsx", ".rds",
														".fst", ".sas7bdat", ".sav", ".dta")
			)
		),
		tabPanel(
			title = "Export data",
			icon = phosphoricons::ph("download"),
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
			title = "View codebook",
			icon = phosphoricons::ph("notebook"),
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

		"Column functions:",

		tabPanel(
			title = "Rename variables",
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
			title = "Remove variables",
			icon = phosphoricons::ph("backspace"),
			alert_info(
				"Right-click on corresponding rows below and delete them, ",
				"then apply changes by clicking the button."
			),
			rhandsontable::rHandsontableOutput(ns("delete_vars_table")),
			actionButton(
				ns("validate"),
				tagList(
					phosphoricons::ph("arrow-circle-right"), "Apply changes"
				),
				class = "btn-primary", width = "100%"
			)
		),

		tabPanel(
			title = "Order variables",
			icon = phosphoricons::ph("list-numbers"),
			p("Use drag and drop UI with multiple selection set to TRUE ",
				"to rearrange vars"),
			actionButton(
				ns("validate"),
				tagList(
					phosphoricons::ph("arrow-circle-right"), "Apply changes"
				),
				class = "btn-primary", width = "100%"
			)
		),

		tabPanel(
			title = "Create or change variables",
			icon = phosphoricons::ph("sidebar-simple"),
			p("Use selectInput + textareaInput to feed into mutate()"),
			actionButton(
				ns("validate"),
				tagList(
					phosphoricons::ph("arrow-circle-right"), "Apply changes"
				),
				class = "btn-primary", width = "100%"
			)
		),

		"---",
		"Row functions:",

		tabPanel(
			title = "Subset observations",
			icon = phosphoricons::ph("funnel"),
			p("Use selectInput + textareaInput to feed into mutate()"),
			actionButton(
				ns("validate"),
				tagList(
					phosphoricons::ph("arrow-circle-right"), "Apply changes"
				),
				class = "btn-primary", width = "100%"
			)
		),

		tabPanel(
			title = "Order observations",
			icon = icon("arrow-up-wide-short"),
		),

		"---",
		"Change structure:",

		tabPanel(
			title = "Long to Wide",
			icon = phosphoricons::ph("columns"),

		),
		tabPanel(
			title = "Wide to Long",
			icon = phosphoricons::ph("rows"),
		)
	)
}



#' @noRd
analysis_tab <- function(id, ns) {
	navbarMenu(
		title = "Analyze",
		# icon = icon("table"),

		"Descriptives:",

		tabPanel(
			"Tabulation",
			icon = phosphoricons::ph("squares-four")
		),

		tabPanel(
			"Summary",
			icon = phosphoricons::ph("dots-nine")
		),

		"Inferentials:",

		tabPanel(
			"Parametric Tests",
			icon = phosphoricons::ph("hash-straight")
		),
		tabPanel(
			"Non-parametric Tests",
			icon = phosphoricons::ph("hash")
		),
		tabPanel(
			"Generalized Linear Model",
			icon = phosphoricons::ph("chart-line-up")
		),
		tabPanel(
			"Mixed Model",
			icon = icon("sitemap")
		),
		tabPanel(
			"Survival",
			icon = icon("timeline")
		),
	)
}





#' @noRd
graph_tab <- function(id, ns) {
	navbarMenu(
		title = "Graphs",
		# icon = icon("table"),

		"Univariate:",
		tabPanel("Bar"),
		tabPanel("Line"),
		tabPanel("High-low"),
		tabPanel("Boxplot"),
		tabPanel("Histogram"),

	)
}
