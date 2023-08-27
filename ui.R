ui <- bslib::page(
  title = "Todo",
  theme = bslib::bs_theme(
    version = 5,
    base_font = bslib::font_google(family = "Quicksand")
  ),
  lang = "en",
  shinyjs::useShinyjs(),
  tags$head(
    tags$link(
      rel = "icon",
      type = "image/x-icon",
      href = "card-checklist.svg"
    ),
    tags$link(rel = "stylesheet", href = "styles.css"),
    tags$link(
      rel = "stylesheet",
      href = "https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
    ),
    tags$script(src = "script.js")
  ),
  tags$body(
    tags$div(
      class = "container py-4",
      tags$div(
        class = "card p-4 border-0",
        tags$div(
          class = "card-body",
          tags$h1(
            id = "today",
            class = "card-title fw-semibold fs-4 mb-3",
            sprintf("Task List %s", format(Sys.Date(), format = "%Y"))
          ),
          tags$form(
            class = "d-flex",
            textInput(
              inputId = "new_task",
              label = NULL,
              placeholder = "What do you have planned?",
              width = "100%"
            ) |>
              tagAppendAttributes(class = "mb-0 me-1"),
            actionButton(
              inputId = "add_task",
              label = NULL,
              icon = icon(
                name = NULL,
                class = "bi bi-plus-lg"
              ),
              class = "btn-primary btn-sm border-0 fs-5 rounded-circle",
              type = "submit"
            )
          )
        )
      ),
      tags$div(
        class = "card mt-3 p-4 border-0",
        tags$div(
          class = "card-body",
          tags$h5(
            class = "card-title mb-3 fs-5",
            tags$i(class = "bi bi-card-list"),
            "Tasks In Progress"
          ),
          tags$div(
            id = "task_container",
            tags$div(
              id = "no_tasks_container",
              tags$p("Woohoo!🎉 Nothing lined up. Try adding new tasks.")
            )
          )
        )
      )
    )
  )
)
