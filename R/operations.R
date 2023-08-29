#' Get all items in a todo list
#' @param todo_name Name of the todo list
#' @param base_url Base url of the todo api
#' @export
#' @return A named list
get_todo_list <- \(todo_name, base_url) {
  httr2::request(base_url = base_url) |>
    httr2::req_url_path_append(todo_name) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
#' Add an item to a todo list
#' @inheritParams get_todo_list
#' @param task Task to add
#' @export
add_task <- \(todo_name, base_url, task) {
  httr2::request(base_url = base_url) |>
    httr2::req_url_path_append(todo_name) |>
    httr2::req_body_json(list(todo = todo_name, items = task)) |>
    httr2::req_perform()
}
#' Delete an item from a todo list
#' @inheritParams get_todo_list
#' @param task_id Id of the task to delete
#' @export
delete_task <- \(todo_name, base_url, task_id) {
  httr2::request(base_url = base_url) |>
    httr2::req_url_path_append(todo_name) |>
    httr2::req_body_json(list(todo = todo_name, item_ids = task_id)) |>
    httr2::req_method("DELETE") |>
    httr2::req_perform()
}
#' Update a todo list item
#' @inheritParams get_todo_list
#' @param task_id Id of the task to update
#' @param updated_item The new updated item
#' @export
update_task <- \(todo_name, base_url, task_id, updated_item) {
  httr2::request(base_url = base_url) |>
    httr2::req_url_path_append(todo_name, task_id) |>
    httr2::req_body_json(
      list(
        todo = todo_name,
        item_id = task_id,
        item = updated_item
      )
    ) |>
    httr2::req_method("PUT") |>
    httr2::req_perform()
}
