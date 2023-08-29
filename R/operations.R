get_todo_list <- \(todo_name, base_url) {
  httr2::request(base_url = base_url) |>
    httr2::req_url_path_append(todo_name) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
add_task <- \(todo_name, base_url, task) {
  httr2::request(base_url = base_url) |>
    httr2::req_url_path_append(todo_name) |>
    httr2::req_body_json(list(todo = todo_name, items = task)) |>
    httr2::req_perform()
}
delete_task <- \(todo_name, base_url, task_id) {
  httr2::request(base_url = base_url) |>
    httr2::req_url_path_append(todo_name) |>
    httr2::req_body_json(list(todo = todo_name, item_ids = task_id)) |>
    httr2::req_method("DELETE") |>
    httr2::req_perform()
}
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
