#' Show reactable data without edit mode
#'
#' @description A fct function
#' @param data data.frame
#' @return `reactable`
#'
#' @noRd
show_reactable <- function(data) {
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

