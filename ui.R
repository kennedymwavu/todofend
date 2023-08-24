ui <- bslib::page(
  title = "Todo",
  theme = bslib::bs_theme(version = 5),
  lang = "en",
  shinyjs::useShinyjs(),
  tags$head(
    tags$script(src = "script.js")
  ),
  tags$div(
    class = "bg-light min-vh-100",
    tags$div(
      class = "container",
      tags$h1(
        id = "today",
        sprintf("Task List %s", format(Sys.Date(), format = "%Y"))
      ),
      tags$div(
        class = "d-flex",
        textInput(
          inputId = "new_task",
          label = NULL,
          placeholder = "What do you have planned?"
        ) |>
          tagAppendAttributes(class = text_input_classes),
        actionButton(
          inputId = "add_task",
          label = NULL,
          icon = icon(
            name = NULL,
            class = "glyphicon glyphicon-plus",
            lib = "glyphicon"
          ),
          class = "btn-primary btn-sm"
        )
      ),
      tags$div(
        class = "mt-3",
        tags$h1("Tasks"),
        tags$div(
          id = "task_container",
          tags$div(
            id = "no_tasks_container",
            tags$p("No tasks lined up")
          )
        )
      )
    )
  )
)
