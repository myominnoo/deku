#' Create reactable without edit mode
#'
#' @description Create reactable without edit mode that has custom design
#' @param data data.frame
#' @return `reactable`
#'
#' @noRd
get_reactable <- function(data) {
	reactable::reactable(
		data = data,
		searchable = TRUE,
		defaultPageSize = 15,
		rownames = TRUE,
		showPageSizeOptions = TRUE,
		filterable = TRUE,
		defaultColDef = reactable::colDef(html = TRUE),
		height = "600px",
		paginationType = "simple",
		pagination = TRUE,
		bordered = TRUE, outlined = TRUE,
		compact = TRUE, highlight = TRUE,
		striped = TRUE,
		wrap = FALSE
	)
}

#' Create rhandsontable with edit mode
#'
#' @description Create rhandsontable with edit mode
#' @param data data.frame
#' @return `reactable`
#'
#' @importFrom magrittr `%>%`
#'
#' @noRd
get_codebook_table <- function(data) {
	rhandsontable::rhandsontable(data, stretchH = "all", height = 400)
		# rhandsontable::hot_col(col = "Type", allowInvalid = FALSE, type = "dropdown",
		# 				source = c("character", "numeric", "integer", "factor",
		# 									 "ordered", "logical", "Date", "POSIXlt", "POSIXct")) %>%
		# rhandsontable::hot_col("Chart", renderer = htmlwidgets::JS("renderSparkline")) %>%
		# rhandsontable::hot_col(c("Missing", "Chart", "Obs"), readOnly = TRUE) %>%
		# rhandsontable::hot_col("Missing", format = "0%") %>%
		# rhandsontable::hot_context_menu(allowRowEdit = FALSE, allowColEdit = FALSE) %>%
		# rhandsontable::hot_cols(colWidths = 130)
}


#' Create rhandsontable to rename variables
#'
#' @description Create rhandsontable with edit mode
#' @param data data.frame
#' @return `reactable`
#'
#' @importFrom magrittr `%>%`
#'
#' @noRd
get_rename_table <- function(data) {
	rhandsontable::rhandsontable(
		data.frame(old = names(data), new = ""),
		colHeaders = c("Variable", "New Name"),
		stretchH = "all",
		height = 400
	) %>%
		rhandsontable::hot_context_menu(
			allowRowEdit = FALSE,
			allowColEdit = FALSE
		) %>%
		rhandsontable::hot_col(1, readOnly = TRUE)
}


#' Create rhandsontable to delete variables
#'
#' @description Create rhandsontable with edit mode
#' @param data data.frame
#' @return `reactable`
#'
#' @importFrom magrittr `%>%`
#'
#' @noRd
get_delete_vars_table <- function(data) {
	rhandsontable::rhandsontable(data, stretchH = "all", height = 400) %>%
		rhandsontable::hot_context_menu(
			allowRowEdit = TRUE,
			allowColEdit = FALSE
		) %>%
		rhandsontable::hot_col(1:ncol(data), readOnly = TRUE) %>%
		rhandsontable::hot_cols(colWidths = 400)
}

