server <- \(input, output, session) {
  last_task_id <- reactiveVal(0)
  num_of_tasks <- reactiveVal(0)
  # hide/show the no tasks container:
  observeEvent(num_of_tasks(), {
    shinyjs::toggle(
      id = "no_tasks_container",
      condition = num_of_tasks() < 1
    )
  })
  output$num_of_tasks <- renderText({
    if (num_of_tasks() < 1) {
      return()
    }
    sprintf(
      "%s task%s remaining",
      num_of_tasks(),
      if (num_of_tasks() == 1) "" else "s"
    )
  }) |>
    bindEvent(num_of_tasks())
  observeEvent(input$add_task, {
    req(input$new_task)
    new_task_id <- last_task_id() + 1
    num_of_tasks(num_of_tasks() + 1)
    last_task_id(new_task_id)
    new_task <- input$new_task
    container_id <- paste0("task_", new_task_id, "_container")
    text_input_id <- paste0("task_", new_task_id)
    save_edits_id <- paste0("save_task_", new_task_id)
    delete_task_id <- paste0("delete_task_", new_task_id)
    ui <- tags$div(
      id = container_id,
      class = "d-flex mb-3",
      textInput(
        inputId = text_input_id,
        label = NULL,
        value = new_task,
      ) |>
        tagAppendAttributes(class = "mb-0 me-2 flex-grow-1"),
      actionButton(
        inputId = save_edits_id,
        label = NULL,
        icon = icon(
          name = NULL,
          class = "bi bi-check-lg"
        ),
        class = "btn-success btn-sm me-1 fs-5 border-0 rounded-circle",
      ) |>
        shinyjs::hidden() |>
        bslib::tooltip("Save edits"),
      actionButton(
        inputId = delete_task_id,
        label = NULL,
        icon = icon(
          name = NULL,
          class = "bi bi-trash"
        ),
        class = "btn-danger btn-sm fs-5 border-0 rounded-circle"
      ) |>
        bslib::tooltip("Delete task")
    ) |>
      shinyjs::hidden()
    insertUI(
      selector = "#task_container",
      where = "afterBegin",
      ui = ui,
      immediate = TRUE,
      session = session
    )
    shinyjs::show(id = container_id, anim = TRUE)
    # once a task is deleted, reduce number of tasks:
    observeEvent(input[[delete_task_id]], {
      removeUI(
        selector = paste0("#", container_id),
        # immediate = TRUE,
        session = session
      )
      num_of_tasks(num_of_tasks() - 1)
    },
    once = TRUE
    )
    # hide/show save edits btn:
    observeEvent(input[[text_input_id]], {
      shinyjs::toggle(
        id = save_edits_id,
        condition = input[[text_input_id]] != new_task,
        anim = TRUE,
        animType = "fade"
      )
    })
    # save edits:
    observeEvent(input[[save_edits_id]], {
      shinyjs::hide(id = save_edits_id, anim = TRUE, animType = "fade")
    })
    shinyjs::reset(id = "new_task")
  })
}
