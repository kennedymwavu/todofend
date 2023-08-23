ui <- bslib::page(
  title = "Todo",
  theme = bslib::bs_theme(version = 5),
  lang = "en",
  shinyjs::useShinyjs(),
  tags$div(
    class = "bg-light min-vh-100",
    tags$div(
      class = "container",
      tags$h1(sprintf("Task List %s", format(Sys.Date(), format = "%Y"))),
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
          label = "Add task",
          icon = icon(
            name = NULL,
            class = "glyphicon glyphicon-plus me-1",
            lib = "glyphicon"
          ),
          class = "btn-primary"
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
