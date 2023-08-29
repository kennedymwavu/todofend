#' Run the todo app
#'
#' @export
run_app <- \() {
  app_dir <- system.file("app", package = "todofend")
  if (app_dir == "") {
    stop(
      "Could not find the app directory. Try re-installing `todofend`.",
      call. = FALSE
    )
  }
  shiny::shinyAppDir(appDir = app_dir)
}
