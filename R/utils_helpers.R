#' Alert message for dataset status
#'
#' @description An alert message with four types
#' info, success, danger, warning.
#' Updated with icons from phosphoricons for each type.
#'
#' @inheritParams shinyWidgets
#'
#' @return `shiny.tag`
#'
#' @noRd
alert_info <- function(...) {
	shinyWidgets::alert(
		status = "info", phosphoricons::ph("info"),
		...
	)
}

#' @noRd
alert_success <- function(...) {
	shinyWidgets::alert(
		status = "success", phosphoricons::ph("check"),
		...
	)
}

#' @noRd
alert_danger <- function(...) {
	shinyWidgets::alert(
		status = "danger", phosphoricons::ph("warning"),
		...
	)
}

#' @noRd
alert_warning <- function(...) {
	shinyWidgets::alert(
		status = "warning", phosphoricons::ph("warning-octagon"),
		...
	)
}
