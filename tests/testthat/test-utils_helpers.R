test_that("alert_* message works", {
	expect_true(inherits(alert_success("Hello"), "shiny.tag"))
	expect_true(inherits(alert_info("Hello"), "shiny.tag"))
	expect_true(inherits(alert_warning("Hello"), "shiny.tag"))
	expect_true(inherits(alert_danger("Hello"), "shiny.tag"))
})
