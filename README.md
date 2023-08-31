
<!-- README.md is generated from README.Rmd. Please edit that file -->

# todofend

<!-- badges: start -->
<!-- badges: end -->

Frontend for a todo list web app. Built using
[shiny](https://shiny.posit.co/).

See the backend [here](https://github.com/kennedymwavu/todobend).

## Installation

You can install the development version of todofend like so:

``` r
remotes::install_github("kennedymwavu/todofend")
```

## Environment variables

In your working directory, make sure you have a `.Renviron` file with
these variables:

``` r
TODO_NAME=your-todo-list-name
BASE_URL=base-url-to-the-api-backend
TASK_LIMIT=your-desired-task-limit
```

For example:

``` r
TODO_NAME=todo1
BASE_URL=http://127.0.0.1:8000/todo
TASK_LIMIT=500
```

## Run app

``` r
todofend::run_app()
```
