#' Perform action quietly
#'
#' Suppress all warnings, messages, and console output.
#'
#' @note Updated 2023-04-26.
#' @noRd
quietly <- function(expr) {
    invisible({
        capture.output({
            suppressWarnings({
                suppressMessages({
                    expr
                })
            })
        })
    })
}
