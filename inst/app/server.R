todo_name <- Sys.getenv("TODO_NAME")
base_url <- Sys.getenv("BASE_URL")
task_limit <- Sys.getenv("TASK_LIMIT")
# if you have the backend running locally you can use this for testing:
# todo_name <- "todo1"
# base_url <- "http://127.0.0.1:8000/todo"
server <- \(input, output, session) {
  num_of_tasks <- reactiveVal()
  todo_list <- reactiveVal(
    get_todo_list(
      todo_name = todo_name,
      base_url = base_url
    )
  )
  observeEvent(todo_list(), {
    num_of_tasks(length(todo_list()))
  })
  observeEvent(todo_list(),
    {
      lapply(todo_list(), \(item) {
        task <- item$item
        task_id <- item$id
        container_id <- paste0("task_", task_id, "_container")
        text_input_id <- paste0("task_", task_id)
        save_edits_id <- paste0("save_task_", task_id)
        delete_task_id <- paste0("delete_task_", task_id)
        ui <- tags$div(
          id = container_id,
          class = "d-flex mb-3",
          textInput(
            inputId = text_input_id,
            label = NULL,
            value = task,
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
        observeEvent(input[[delete_task_id]],
          {
            removeUI(
              selector = paste0("#", container_id),
              immediate = TRUE,
              session = session
            )
            delete_task(
              todo_name = todo_name,
              base_url = base_url,
              task_id = task_id
            )
            todo_list(
              get_todo_list(
                todo_name = todo_name,
                base_url = base_url
              )
            )
            shinytoastr::toastr_success(
              message = "Task deleted!",
              progressBar = TRUE,
              timeOut = 3000,
              position = "bottom-center"
            )
          },
          once = TRUE
        )
        # hide/show save edits btn:
        observeEvent(input[[text_input_id]], {
          shinyjs::toggle(
            id = save_edits_id,
            condition = input[[text_input_id]] != task,
            anim = TRUE,
            animType = "fade"
          )
        })
        # save edits:
        observeEvent(input[[save_edits_id]], {
          update_task(todo_name, base_url, task_id, input[[text_input_id]])
          todo_list(
            get_todo_list(
              todo_name = todo_name,
              base_url = base_url
            )
          )
          shinyjs::hide(id = save_edits_id, anim = TRUE, animType = "fade")
          shinytoastr::toastr_success(
            message = "Task updated!",
            progressBar = TRUE,
            timeOut = 3000,
            position = "bottom-center"
          )
        })
      })
    },
    once = TRUE
  )
  # hide/show the no tasks container:
  observeEvent(num_of_tasks(), {
    removeUI(
      selector = "#task_loading_skeleton",
      immediate = TRUE
    )
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
    if (num_of_tasks() > task_limit) {
      shinytoastr::toastr_error(
        message = "Maximum task limit exceeded.",
        title = "Error!",
        progressBar = TRUE,
        position = "bottom-center"
      )
      return()
    }
    new_task <- input$new_task
    req(new_task)
    add_task(todo_name = todo_name, base_url = base_url, task = new_task)
    todo_list(
      get_todo_list(
        todo_name = todo_name,
        base_url = base_url
      )
    )
    new_task_id <- todo_list()[[length(todo_list())]]$id
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
    # delete task:
    observeEvent(input[[delete_task_id]],
      {
        removeUI(
          selector = paste0("#", container_id),
          immediate = TRUE,
          session = session
        )
        delete_task(
          todo_name = todo_name,
          base_url = base_url,
          task_id = new_task_id
        )
        todo_list(
          get_todo_list(
            todo_name = todo_name,
            base_url = base_url
          )
        )
        shinytoastr::toastr_success(
          message = "Task deleted!",
          progressBar = TRUE,
          timeOut = 3000,
          position = "bottom-center"
        )
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
      update_task(todo_name, base_url, new_task_id, input[[text_input_id]])
      todo_list(
        get_todo_list(
          todo_name = todo_name,
          base_url = base_url
        )
      )
      shinyjs::hide(id = save_edits_id, anim = TRUE, animType = "fade")
      shinytoastr::toastr_success(
        message = "Task updated!",
        progressBar = TRUE,
        timeOut = 3000,
        position = "bottom-center"
      )
    })
    shinyjs::reset(id = "new_task")
  })
}
