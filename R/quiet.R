#' Perform action quietly
#'
#' Suppress all warnings, messages, and console output.
#'
#' @export
#' @note Updated 2023-04-26.
#'
#' @return Invisible `NULL`.
#'
#' @examples
#' quiet({
#'     message("hello world")
#' })
quiet <- function(expr) {
    invisible({
        capture.output({
            suppressWarnings({
                suppressMessages({
                    expr
                })
            })
        })
        NULL
    })
}
